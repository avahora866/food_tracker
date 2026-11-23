"""Regenerates the app icon and Android launcher icons. Run: python3 tool/generate_icon.py"""
import os
from PIL import Image, ImageDraw
ROOT=os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')+'/'
S=1024; SS=4; N=S*SS
BG=(15,118,110,255); FG=(255,255,255,255)

def render(bg, scale):
    im=Image.new('RGBA',(N,N),BG if bg else (0,0,0,0))
    d=ImageDraw.Draw(im)
    u=lambda v:int(v*scale*SS)
    r=u(270); rim=u(44); w=u(320); foot=u(40); fw=u(110)
    # total height: rim + r + foot; centre it
    h=rim+r+foot
    top=N//2-h//2+rim  # y of bowl's flat top (under the rim)
    cx=N//2
    d.rounded_rectangle([cx-w, top-rim, cx+w, top], radius=rim//2, fill=FG)
    d.pieslice([cx-r, top-r, cx+r, top+r], 0, 180, fill=FG)
    d.rounded_rectangle([cx-fw, top+r-u(40), cx+fw, top+r+foot], radius=u(16), fill=FG)
    return im.resize((S,S), Image.LANCZOS)

out=ROOT+'assets/icon/'
render(True, 1.0).save(out+'icon.png')
render(False, 0.7).save(out+'foreground.png')

# Android launcher icons
res=ROOT+'android/app/src/main/res/'
full=Image.open(out+'icon.png'); fg=Image.open(out+'foreground.png')
for d,px in {'mdpi':48,'hdpi':72,'xhdpi':96,'xxhdpi':144,'xxxhdpi':192}.items():
    full.resize((px,px),Image.LANCZOS).save(f'{res}mipmap-{d}/ic_launcher.png')
    fp=int(px*108/48)
    fg.resize((fp,fp),Image.LANCZOS).save(f'{res}mipmap-{d}/ic_launcher_foreground.png')
os.makedirs(res+'mipmap-anydpi-v26',exist_ok=True)
open(res+'mipmap-anydpi-v26/ic_launcher.xml','w').write('''<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ic_launcher_background"/>
    <foreground android:drawable="@mipmap/ic_launcher_foreground"/>
    <monochrome android:drawable="@mipmap/ic_launcher_foreground"/>
</adaptive-icon>
''')
open(res+'values/ic_launcher_background.xml','w').write('''<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="ic_launcher_background">#0F766E</color>
</resources>
''')
