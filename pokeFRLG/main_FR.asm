.gba
.thumb
.loadtable "./charmap.txt"
.create "./chsfontrom_FR.gba",0x08000000
.close
.open "./baserom_FR.gba","./chsfontrom_FR.gba",0x08000000

;定义函数地址
.include "./include/OriginSymbols_FR.s"
.include "./include/hack_FR.s"

;原址修改的部分
.include "./src/HackInOrigin.s"

;中文相关函数
.org HackStart
;.include "./src/GetGlyphWidthChinese.s"
;.include "./src/GetStringWidthChinese.s"
.include "./src/RenderTextChinese.s"

;图片及中文字模
.include "./graphic/graphic.s"

;测试文本
;.include "./strings/testText.s"

.close
