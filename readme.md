# Pokemon_GBA_Font_Patch
* 宝可梦3代GBA汉字字库补丁（增益优化版）

增益优化版：红蓝宝石已完成，火红叶绿、绿宝石待更新

原始增益版：红宝石、火红、绿宝石，现已全部转写为armips代码格式

# 介绍

本项目为宝可梦3代GBA游戏美版《红宝石/蓝宝石/火红/叶绿/绿宝石》的汉字字库程序（增益优化版）。

采用**armips**方式编译。

适用于基于美版的上述游戏作品或改版作品的中文补丁插入。

（海外版非美版也可以使用，需自行修改函数地址定义）

# 功能

增益优化版，基于原有增益版基础上进行增添修改：

1.增添GetStringWidth函数对汉字的兼容。

2.优化在部分西欧文字改版中，汉字及原码表的兼容性。

3.调整红宝石部分场景（狩猎地带、电脑盒子持有物等）的汉字显示不完全的情况。

4.部分bug修正（如火叶培育屋bug）等内容。

# 增益优化版构建

1.将宝可梦英文rev1.0原版`****.gba`重命名为`baserom_**.gba`。
* 红宝石： `baserom_R.gba`。
* 蓝宝石： `baserom_S.gba`。
* 火　红： `baserom_FR.gba`。
* 叶　绿： `baserom_LG.gba`。
* 绿宝石： `baserom_E.gba`。

2.将`baserom_**.gba`分别置于对应版本的目录下，如红宝石，即

`Pokemon_GBA_Font_Patch/pokeRS/baserom_R.gba`。

3.点击`build.bat`即可自动生成增益优化版的rom。
* 红宝石： `chsfontrom_R.gba`。
* 蓝宝石： `chsfontrom_S.gba`。
* 火　红： `chsfontrom_FR.gba`。
* 叶　绿： `chsfontrom_LG.gba`。
* 绿宝石： `chsfontrom_E.gba`。

注：
* strings文件夹内附带了部分汉化测试文本。
* 可根据实际改版rom的情况，修改include内相关函数的地址定义，以适配不同改版rom插入中文补丁。
* 普通改版一般不会去修改汉化代码涉及的功能函数地址，故大多只需修改汉字字模的地址定义。

# 原始增益版构建

提供原始增益版的armips构建代码，及原始发布贴（见credit）附带的TBL码表及相关资料，位于文件夹：

`Pokemon_GBA_Font_Patch/old_(PMxxUS_CHPLUS_RELEASE)`

构建方法大致同增益优化版。

1.将宝可梦英文rev1.0原版`****.gba`重命名为`baserom_**.gba`。
* 红宝石： `baserom_R.gba`。
* 绿宝石： `baserom_E.gba`。
* 火　红： `baserom_FR.gba`。

2.将`baserom_**.gba`分别置于对应版本的目录下，如红宝石，即

`Pokemon_GBA_Font_Patch/old_(PMxxUS_CHPLUS_RELEASE)/PMRUS_CHPLUS_RELEASE1/baserom_R.gba`。

3.点击`build.bat`即可自动生成原始发布的增益版的rom。
* 红宝石： `PMRUS_CHPLUS_RELEASE1.gba`。
* 绿宝石： `PMEMUS_CHPLUS_RELEASE2.gba`。
* 火　红： `PMFRUS_CHPLUS_RELEASE3.gba`。

SHA1：
* 红宝石 PMRUS_CHPLUS_RELEASE1.gba：

`b8fbf478b8e923dfc4a80770f0f2781b0942ce2a`

* 绿宝石 PMEMUS_CHPLUS_RELEASE2.gba：

`d7ca85e7d52319fdc049bb3f376c93a637dfd760`

* 火　红 PMFRUS_CHPLUS_RELEASE3.gba：

`2f371567441333edd1be77c01e54f5430499da9b`

原始增益版各自文件夹内也提供对应rom的.sha1文件以供校验。

注：
* 原始增益版中，红宝石、绿宝石、火叶均不包含中文符号字模。
* 给改版rom打入原始增益版代码，方式同增益优化版，即根据实际情况，修改include内相关函数的地址定义即可。
* 普通改版一般不会去修改汉化代码涉及的功能函数地址，故大多只需修改汉字字模的地址定义。

# credit

## armips

作者：Kingcom

地址：https://github.com/Kingcom/armips

## 宝可梦反编译工程

组织：pret

地址：https://github.com/pret

## 红宝石、火红、绿宝石美版中字增益版

作者及鸣谢人员：enler, liuyanghejerry, Roy, luojingmin, 飞眼, 某位嵌入式开发的圈外人

地址：

《美版火红中字增益版发布》：https://www.poketb.com/bbs/thread-14340-1-1.html

《口袋妖怪 红宝石·绿宝石 美版中字增益版发布》：https://www.poketb.com/bbs/thread-17152-1-1.html

## ArmIPS下的宝可梦脚本编辑

代码写法参考及相关脚本宏文件作者：本站第一萌新

地址：

《ASM杂项集合【802/绿宝石】》：https://www.pmcenter.cn/forum.php?mod=viewthread&tid=111388
