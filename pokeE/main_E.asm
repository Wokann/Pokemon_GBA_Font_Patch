.gba
.thumb
.loadtable "./PMRSEFRLG_charmap.txt"
.create "./chsfontrom_E.gba",0x08000000
.close
.open "./baserom_E.gba","./chsfontrom_E.gba",0x08000000

;定义函数地址
.include "./include/OriginSymbols_E.s"
.include "./include/hackSymbols_E.s"

;原址修改或跳转
;;1、汉字字库程序
.include "./src/HookInOrigin/RenderText.s"
;;2、含汉字的句子宽度计算
.include "./src/HookInOrigin/GetStringWidth.s"
;;3、图鉴汉字显示位置调整
.include "./src/HookInOrigin/PrintMonDexNumAndName.s"
;;4、SeedRNG随机数生成修复
;;;红蓝宝石风格
.include "./src/HookInOrigin/SeedRNGFix_RS.s"
;;;火红叶绿风格
.include "./src/HookInOrigin/SeedRNGFix_FRLG.s"

;新功能函数
.org HackFunctionAddresses
;;1、汉字字库程序
.include "./src/HackFunction/RenderTextChinese.s"
.include "./src/HackFunction/Convert1bppTo2bpp.s"
;;2、含汉字的句子宽度计算
.include "./src/HackFunction/GetStringWidthChinese.s"
;;3、图鉴汉字显示位置调整
.include "./src/HackFunction/PrintMonDexNumAndNameChinese.s"
;;4、SeedRNG随机数生成修复
;;;红蓝宝石风格
.include "./src/HackFunction/SeedRNGFix_RS.s"
;;;火红叶绿风格
.include "./src/HackFunction/SeedRNGFix_FRLG.s"

;图片
;;1、汉字字库程序
.org ChineseFontAndPunctuationAddresses ;(新字库总大小为0x2CA3C)
.include "./graphic/fonts.s"
;;3、图鉴汉字显示位置调整
.include "./graphic/pokedex.s"

;测试文本
.include "./strings/testText.s"

.close
