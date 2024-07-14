.gba
.if (Origin_Rom == Chinese_Patched_Rom)
    .open Origin_Rom,0x08000000
.else
    .create Chinese_Patched_Rom,0x08000000
    .close
    .open Origin_Rom,Chinese_Patched_Rom,0x08000000
.endif

;定义函数地址及码表
.loadtable "./PMRSEFRLG_charmap.txt"
.include "./include/hackSymbols_E.h"

;原址修改或跳转
.thumb
.include "./src/HookInOrigin/text.s"            //汉字字库程序
.include "./src/HookInOrigin/pokedex.s"         //图鉴汉字位置调整
.include "./src/HookInOrigin/main.s"            //随机数生成SeedRNG修复
.include "./src/HookInOrigin/naming_screen.s"   //随机数生成SeedRNG修复
.include "./src/HookInOrigin/title_screen.s"    //随机数生成SeedRNG修复
.include "./src/HookInOrigin/main.s"            //随机数生成SeedRNG修复
.include "./src/HookInOrigin/graphics.s"        //图片（具体包含内容详见对应文件）

;新功能函数
.org HackFunctionAddresses
.thumb
.include "./src/HackFunction/text.s"            //汉字字库程序
.include "./src/HackFunction/pokedex.s"         //图鉴汉字位置调整
.include "./src/HackFunction/SeedRNGFix.s"      //随机数生成SeedRNG修复
.include "./src/HackFunction/graphics.s"        //图片（具体包含内容详见对应文件）

;测试文本
.include "./strings/testText.s"

.close
