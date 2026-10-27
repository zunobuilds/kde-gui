#!/usr/bin/env python3
"""Inspect one consumer's AT-SPI tree and announcements without changing settings."""

import argparse
import sys
import time


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("pid", type=int, nargs="?", help="PID of the running counter consumer")
    parser.add_argument("--application-name", help="unique AT-SPI application name when PID namespaces differ")
    parser.add_argument("--watch-seconds", type=int, default=20)
    args = parser.parse_args()
    if (args.pid is None) == (args.application_name is None):
        parser.error("supply either a PID or a unique application name")
    if args.application_name is not None and not args.application_name.strip():
        parser.error("application name must be nonempty and unique to the test process")
    if (args.pid is not None and args.pid <= 0) or not 1 <= args.watch_seconds <= 60:
        parser.error("PID must be positive and watch duration must be 1–60 seconds")

    try:
        import gi

        gi.require_version("Atspi", "2.0")
        from gi.repository import Atspi, GLib
    except (ImportError, ValueError):
        print("AT-SPI inspection requires Python GObject and the Atspi 2.0 typelib.", file=sys.stderr)
        return 2

    application = None
    deadline = time.monotonic() + 5
    context = GLib.MainContext.default()
    while time.monotonic() < deadline:
        while context.pending():
            context.iteration(False)
        desktop = Atspi.get_desktop(0)
        for index in range(desktop.get_child_count()):
            candidate = desktop.get_child_at_index(index)
            if candidate and ((args.pid is not None and candidate.get_process_id() == args.pid)
                              or (args.application_name is not None
                                  and candidate.get_name() == args.application_name)):
                application = candidate
                break
        if application:
            break
        time.sleep(0.1)
    if not application:
        print("No matching AT-SPI application; check accessibility status and PID namespace or use a unique application name.", file=sys.stderr)
        return 1

    def print_tree(node, depth=0):
        if depth > 12:
            return
        states = node.get_state_set()
        flags = [name.lower() for name in ("ENABLED", "SENSITIVE", "FOCUSABLE", "FOCUSED")
                 if states.contains(getattr(Atspi.StateType, name))]
        print(f"{'  ' * depth}{node.get_role_name()}: {node.get_name()!r} [{', '.join(flags)}]", flush=True)
        for index in range(node.get_child_count()):
            child = node.get_child_at_index(index)
            if child:
                print_tree(child, depth + 1)

    print_tree(application)

    target_pid = application.get_process_id()

    def on_announcement(event, _data):
        if event.source and event.source.get_process_id() == target_pid:
            print(f"AT-SPI announcement: {event.any_data!r}", flush=True)

    listener = Atspi.EventListener.new(on_announcement, None)
    if not listener.register("object:announcement"):
        print("AT-SPI announcement listener registration failed.", file=sys.stderr)
        return 1
    print("Activate both counters during the observation period; audible speech requires a separate check.", flush=True)
    loop = GLib.MainLoop()

    def stop_watch():
        loop.quit()
        return GLib.SOURCE_REMOVE

    GLib.timeout_add_seconds(args.watch_seconds, stop_watch)
    try:
        loop.run()
    finally:
        listener.deregister("object:announcement")
    print("Observation ended; inspect the recorded tree/events and verify speech manually.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
