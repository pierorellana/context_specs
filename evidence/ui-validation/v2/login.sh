#!/bin/sh
# From Face ID error screen (or login): log in with the demo user.
adb shell input tap 585 2310; sleep 1.5
adb shell input tap 585 861; sleep .4; adb shell input text "demo@binova.local"
adb shell input tap 516 1059; sleep .4; adb shell input text 'Demo1234\!'
adb shell input keyevent 4; sleep .8; adb shell input tap 584 2016; sleep 4
