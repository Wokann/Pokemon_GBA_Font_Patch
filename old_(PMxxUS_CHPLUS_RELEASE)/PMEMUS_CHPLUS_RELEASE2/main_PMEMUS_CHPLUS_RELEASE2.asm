.gba
.thumb
;.loadtable "./charmap.txt"
.create "./PMEMUS_CHPLUS_RELEASE2.gba",0x08000000
.close
.open "./baserom_E.gba","./PMEMUS_CHPLUS_RELEASE2.gba",0x08000000

;定义函数地址
.include "./include/OriginSymbols_E.s"
.include "./include/hack_E.s"

;原址修改的部分
.include "./src/HackInOrigin.s"

;中文相关函数
.org HackStart1
.include "./src/PrintMonDexNumAndNameChinese.s"

.org HackStart2
.include "./src/RenderTextChinese.s"

;图片及中文字模
.org 0x09000000
.fill 0x01000000,0x00   ;扩容至32MB
.include "./graphic/graphic.s"

.close
