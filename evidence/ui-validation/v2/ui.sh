#!/bin/sh
# Prints clickable/text nodes of the current screen: bounds | text | desc | id
MSYS_NO_PATHCONV=1 adb shell uiautomator dump /sdcard/ui.xml >/dev/null 2>&1
MSYS_NO_PATHCONV=1 adb shell cat /sdcard/ui.xml | python -c "
import sys,re
x=sys.stdin.read()
for n in re.findall(r'<node [^>]*>', x):
    g=lambda k: (re.search(k+r'=\"([^\"]*)\"',n) or [None,''])[1]
    if g('text') or g('content-desc') or g('clickable')=='true':
        print(g('bounds'),'|',g('text'),'|',g('content-desc')[:60],'|',g('resource-id').split('/')[-1])
"
