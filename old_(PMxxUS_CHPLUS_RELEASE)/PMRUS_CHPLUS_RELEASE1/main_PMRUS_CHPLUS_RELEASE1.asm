.gba
.thumb
;.loadtable "./charmap.txt"
.create "./PMRUS_CHPLUS_RELEASE1.gba",0x08000000
.close
.open "./baserom_R.gba","./PMRUS_CHPLUS_RELEASE1.gba",0x08000000

;定义函数地址
.include "./include/OriginSymbols_R.s"
.include "./include/hack_R.s"

;原址修改的部分
.include "./src/HackInOrigin.s"

;中文相关函数
.org HackStart
.include "./src/DrawGlyphTilesChinese.s"

.org HackStart + 0x224  ;0x080208C00
.include "./src/GetGlyphWidthChinese.s"

;图片及中文字模
.org 0x09000000
.fill 0x01000000,0x00   ;扩容至32MB
.include "./graphic/graphic.s"

.close
