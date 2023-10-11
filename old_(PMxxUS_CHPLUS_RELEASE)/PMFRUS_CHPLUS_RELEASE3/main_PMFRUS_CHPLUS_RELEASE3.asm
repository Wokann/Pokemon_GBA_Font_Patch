.gba
.thumb
;.loadtable "./charmap.txt"
.create "./PMFRUS_CHPLUS_RELEASE3.gba",0x08000000
.close
.open "./baserom_FR.gba","./PMFRUS_CHPLUS_RELEASE3.gba",0x08000000

;定义函数地址
.include "./include/OriginSymbols_FR.s"
.include "./include/hack_FR.s"

;原址修改的部分
.include "./src/HackInOrigin.s"

;中文相关函数
.org HackStart
.include "./src/RenderTextChinese.s"

;图片及中文字模
.org 0x09000000
.fill 0x01000000,0xFF   ;扩容至32MB
.include "./graphic/graphic.s"

.close
