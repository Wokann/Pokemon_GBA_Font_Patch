//红蓝宝石seed生成机制：
//----1、开机后根据RTC生成初始seed，调用SeedRngWithRtc
//火红叶绿seed生成机制：
//----0、初始化主角命名界面、标题界面时，开启timer1计时
//----1、新游戏建档主角命名时提取timer1值作为初始seed，调用SeedRngAndSetTrainerId
//----2、在检验存档情况时提取timer1值作为初始seed，调用SeedRngAndSetTrainerId
//-------火红叶绿检测存档情况函数位于封面兽按start键后
//绿宝石seed生成机制：
//----0、初始化主角命名界面时，开启timer1计时
//----1、新游戏建档主角命名时提取timer1值作为初始seed，调用SeedRngAndSetTrainerId
//----2、其他时候初始seed均为0x0000

//绿宝石转红蓝宝石风格seed生成机制：
//----1、补充开机根据RTC生成初始seed
//----2、删除新游戏建档主角命名生成初始seed
.org AgbMain + 0x5C     ;0x08000400
    ldr r0,=SeedRNGFix_RS
    mov pc,r0
.pool

.org MainState_Exit + 0x20    ;0x080E349C
    nop
    nop
