.gba
.thumb
.loadtable "./PMRSEFRLG_charmap.txt"
.create "./chsfontrom_FR.gba",0x08000000
.close
.open "./baserom_FR.gba","./chsfontrom_FR.gba",0x08000000

;定义函数地址
.include "./include/OriginSymbols_FR.s"
.include "./include/hackSymbols_FR.s"

;原址修改或跳转
;;1、汉字字库程序
.include "./src/HookInOrigin/RenderText.s"
;;2、含汉字的句子宽度计算
.include "./src/HookInOrigin/GetStringWidth.s"
;;3、保存界面徽章后出现乱码
.include "./src/HookInOrigin/SaveStatToString.s"
;;4、对战界面招式PP属性字体大小
.include "./src/HookInOrigin/sTextOnWindowsInfo_Normal.s"
;;5、rev0版培育屋strcpy错位
.include "./src/HookInOrigin/DaycarePrintMonLvl.s"

;中文相关函数
.org HackFunctionAddresses
;;1、汉字字库程序
.include "./src/HackFunction/RenderTextChinese.s"
.include "./src/HackFunction/Convert1bppTo2bpp.s"
;;2、含汉字的句子宽度计算
.include "./src/HackFunction/GetStringWidthChinese.s"

;图片
;;1、汉字字库程序
.org ChineseFontAndPunctuationAddresses ;(新字库总大小为0x2CA3C)
.include "./graphic/fonts.s"

;测试文本
.include "./strings/testText.s"

.close
