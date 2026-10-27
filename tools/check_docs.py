#!/usr/bin/env python3
"""Check project Markdown with Python's standard library; no network or builds."""
from pathlib import Path
import re
import subprocess
import sys
from urllib.parse import unquote, urlsplit

ROOT = Path(__file__).resolve().parents[1]


def headings(text):
    ids = set()
    counts = {}
    for title in re.findall(r'^#{1,6}\s+(.+?)\s*#*$', text, re.M):
        slug = re.sub(r'[^\w\- ]', '', title.lower()).replace(' ', '-')
        count = counts.get(slug, 0)
        counts[slug] = count + 1
        ids.add(slug if count == 0 else f'{slug}-{count}')
    return ids


def main():
    paths = ['README.md', 'AGENTS.md', *sorted(str(p.relative_to(ROOT)) for p in (ROOT/'docs').glob('*.md'))]
    errors = []
    checked = 0
    for name in paths:
        ignored = subprocess.run(['git','check-ignore','-q','--',name],cwd=ROOT,check=False).returncode
        if ignored == 0:
            continue
        if ignored != 1:
            errors.append(f'{name}: git ignore check failed')
            continue
        path = ROOT/name
        body = path.read_text()
        checked += 1
        for target in re.findall(r'\[[^\]]*\]\(([^\s)]+)\)', body):
            target = target.strip('<>')
            parsed = urlsplit(target)
            if parsed.scheme or parsed.netloc:
                continue
            dest = (path.parent/unquote(parsed.path)).resolve() if parsed.path else path
            if not dest.is_relative_to(ROOT) or not dest.is_file():
                errors.append(f'{name}: missing or external relative target {target}')
                continue
            ignored_target = subprocess.run(['git','check-ignore','-q','--',str(dest.relative_to(ROOT))],cwd=ROOT,check=False).returncode
            if ignored_target != 1:
                errors.append(f'{name}: link unavailable in clone: {target}')
            if parsed.fragment and dest.suffix == '.md' and unquote(parsed.fragment) not in headings(dest.read_text()):
                errors.append(f'{name}: missing heading: {target}')
        for line, text in enumerate(body.splitlines(),1):
            if text.rstrip() != text:
                errors.append(f'{name}:{line}: trailing whitespace')
    readme=(ROOT/'README.md').read_text()
    credit='[Developed with the help of OpenAI Codex and cloud AI models.](docs/DEVELOPMENT_TOOLS.md)'
    if credit not in readme:
        errors.append('README: missing required AI credit')
    if re.search(r'!\[|<img\b|shields\.io',readme,re.I):
        errors.append('README: image or badge markup')
    for section in ('purpose','status','features','architecture','layout','requirements','usage','tests','roadmap','contributions','limitations','licensing'):
        if section not in readme.lower():
            errors.append(f'README: missing {section} coverage')
    if errors:
        print('\n'.join(errors),file=sys.stderr)
        return 1
    print(f'PASS: {checked} Markdown files; local links/anchors, whitespace, README coverage and AI credit')
    print('External URLs, full CommonMark parsing and native behavior are outside this check.')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
