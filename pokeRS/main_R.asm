.gba
.thumb
.loadtable "./charmap.txt"
.create "./chsfontrom_R.gba",0x08000000
.close
.open "./baserom_R.gba","./chsfontrom_R.gba",0x08000000

;定义函数地址
.include "./include/OriginSymbols_R.s"
.include "./include/hack_R.s"

;原址修改的部分
.include "./src/HackInOrigin.s"

;中文相关函数
.org HackStart  ;gMiscBlank_Gfx
.include "./src/GetGlyphWidthChinese.s"
.include "./src/GetStringWidthChinese.s"
.include "./src/DrawGlyphTilesChinese.s"
.include "./src/UpdateSafariBallsTextInHealthboxChinese.s"
.include "./src/UpdateLeftNoOfBallsTextOnHealthboxChinese.s"

;中文字模
.include "./graphic/graphic.s"

;测试文本
.include "./strings/testText.s"

.close
