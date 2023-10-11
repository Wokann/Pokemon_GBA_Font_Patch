.gba
.thumb
.loadtable "./charmap.txt"
.create "./chsfontrom_S.gba",0x08000000
.close
.open "./baserom_S.gba","./chsfontrom_S.gba",0x08000000

;定义函数地址
.include "./include/OriginSymbols_S.s"
.include "./include/hack_S.s"

;原址修改的部分
.include "./src/HackInOrigin.s"

;中文相关函数
.org HackStart
.include "./src/GetGlyphWidthChinese.s"
.include "./src/GetStringWidthChinese.s"
.include "./src/DrawGlyphTilesChinese.s"
.include "./src/UpdateSafariBallsTextInHealthboxChinese.s"
.include "./src/UpdateLeftNoOfBallsTextOnHealthboxChinese.s"

;图片及中文字模
;.org 0x09000000
;.fill 0x01000000,0x00   ;扩容至32MB
.include "./graphic/graphic.s"

;测试文本
.include "./strings/testText.s"

.close
