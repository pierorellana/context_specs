import sys
from PIL import Image
app,proto,out=sys.argv[1:4]
C='C:/Users/piero/Desktop/workspace/.tmp/prototype/BInova/capturas/'
a=Image.open(app); p=Image.open(C+proto)
a=a.resize((390,int(a.height*390/a.width))); p=p.resize((390,int(p.height*390/p.width)))
h=max(a.height,p.height); im=Image.new('RGB',(790,h),'white'); im.paste(a,(0,0)); im.paste(p,(400,0)); im.save(out)
