#!/bin/sh
# usage: shot.sh name  -> saves artifacts/v2/name.png downscaled for review
cd /c/Users/piero/Desktop/workspace/artifacts/v2
adb exec-out screencap -p > "$1.png"
python -c "from PIL import Image;im=Image.open('$1.png');im.resize((im.width//2,im.height//2)).save('$1.png')"
