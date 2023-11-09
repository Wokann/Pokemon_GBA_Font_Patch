.gba
.thumb
.loadtable "./charmap.txt"
.create "./chsfontrom_R.gba",0x08000000
.close
.open "./baserom_R.gba","./chsfontrom_R.gba",0x08000000

;扩容至32MB
;.org 0x09000000
;.fill 0x01000000,0x00   

;定义函数地址
.include "./include/OriginSymbols_R.s"
.include "./include/hack_R.s"

;原址修改或跳转
;;1.汉字字库及汉字宽度程序
.include "./src/HookInOrigin/DrawGlyphTiles.s"
.include "./src/HookInOrigin/GetGlyphWidth.s"
.include "./src/HookInOrigin/GetStringWidth.s"
;;2.对战及狩猎地带hp窗口汉字显示
.include "./src/HookInOrigin/UpdateNickInHealthbox.s"
.include "./src/HookInOrigin/UpdateSafariBallsTextInHealthbox.s"
.include "./src/HookInOrigin/UpdateLeftNoOfBallsTextOnHealthbox.s"
;;3.寄放系统左侧持有物汉字显示
.include "./src/HookInOrigin/PrintDisplayMonInfo.s"
.include "./src/HookInOrigin/sub_8097F58.s"

;中文相关函数
.org HackFunctionAddresses
;;1.汉字字库及汉字宽度程序
.include "./src/HackFunction/GetGlyphWidthChinese.s"
.include "./src/HackFunction/GetStringWidthChinese.s"
.include "./src/HackFunction/DrawGlyphTilesChinese.s"
;;2.对战及狩猎地带hp窗口汉字显示
.include "./src/HackFunction/UpdateSafariBallsTextInHealthboxChinese.s"
.include "./src/HackFunction/UpdateLeftNoOfBallsTextOnHealthboxChinese.s"

;图片及中文字模
;;1.汉字字库及汉字宽度程序
.include "./graphic/fonts.s"
;;3.寄放系统左侧持有物汉字显示
.include "./graphic/pokemon_storage.s"

;测试文本
.include "./strings/testText.s"

.close
