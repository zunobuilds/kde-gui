set pagination off
set confirm off
set debuginfod enabled off
set breakpoint pending on
break kde_gui::Counter::increment
commands
    silent
    set variable (*self).value = 2147483645
    disable 1
    continue
end
run
quit $_exitcode
