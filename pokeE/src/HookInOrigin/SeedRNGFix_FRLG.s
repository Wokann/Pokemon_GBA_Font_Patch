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

//绿宝石转火红叶绿风格seed生成机制：
//----1、保留新游戏建档主角命名时提取timer1值作为初始seed
//----2、由于绿宝石检测存档情况位于刚开机gamefreak界面前，
//-------在此处开启timer1计时及提取数值作为初始seed，将始终为定值，故不能仿照火叶对应的函数进行插入
//-------调整为初始化标题界面时，开启timer1计时，
//-------封面兽按start后提取timer1值作为初始seed，调用SeedRngAndSetTrainerId
.org CB2_InitTitleScreen + 0x3C                     ;0x08AA7E0
    ldr r0,=SeedRNGFix_FRLG_StartTimer1
    mov pc,r0
.pool

.org Task_TitleScreenPhase3 + 0x20                  ;0x080AAD84
    ldr r0,=SeedRNGFix_FRLG
    mov pc,r0
.pool

//.org MainState_Exit + 0x20    ;0x080E349C
//  bl SeedRngAndSetTrainerId