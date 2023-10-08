# Pokemon_GBA_Font_Patch
* 宝可梦3代GBA汉字字库补丁


# 介绍

本项目为宝可梦3代GBA游戏美版《红宝石/蓝宝石/火红/叶绿/绿宝石》的汉字字库程序。

采用**armips**方式编译。

适用于基于美版的上述游戏作品或改版作品的中文补丁插入。

（海外版非美版也可以使用，需自行修改函数地址定义）

# 功能

基于原有增益版基础上进行增添修改：

1.增添GetStringWidth函数对汉字的兼容。（待更新）

2.优化在部分西欧文字改版中，汉字及原码表的兼容性。（待更新）

3.调整红宝石部分场景的汉字显示不完全的情况。（待更新）

4.部分bug修正（如火叶培育屋bug）等内容。（待更新）

# 构建方法

1.将宝可梦英文原版`****.gba`重命名为`baserom_**.gba`；(**=R,S,FR,LG,E)

2.将`baserom_**.gba`分别置于对应版本的目录下，如红宝石，即`Pokemon_GBA_Font_Patch/pokeRS/baserom_R.gba`；

3.点击`build.bat`即可自动生成插入了汉字字库的rom，如红宝石为 `chsfontrom_R.gba`。

data文件夹内附带了一份测试汉化文本。

# credit

## armips

作者：Kingcom

地址：https://github.com/Kingcom/armips

## 宝可梦反编译工程

组织：pret

地址：https://github.com/pret

## 红宝石、火红、绿宝石美版中字增益版

作者及鸣谢人员：enler,liuyanghejerry,Roy,luojingmin,飞眼,某位嵌入式开发的圈外人

地址：

《美版火红中字增益版发布》：https://www.poketb.com/bbs/thread-14340-1-1.html

《口袋妖怪 红宝石·绿宝石 美版中字增益版发布》：https://www.poketb.com/bbs/thread-17152-1-1.html

## ArmIPS下的宝可梦脚本编辑

代码写法参考及相关脚本宏文件作者：本站第一萌新

地址：

《ASM杂项集合【802/绿宝石】》：https://www.pmcenter.cn/forum.php?mod=viewthread&tid=111388