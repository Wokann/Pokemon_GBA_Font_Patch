.include "./include/main.h"
.include "./include/rtc.h"
.include "./include/random.h"
.include "./include/title_screen.h"
.include "./include/sound.h"
.include "./include/hack_function_switch.h"

//【绿宝石转红蓝宝石风格seed生成机制】
.if     (SeedRNGFix_OPTION == SeedRNGFix_RS)
//SeedRNGFix_RS;
//SeedRngWithRtc;

.func SeedRNGFix_RS
    bl SeedRngWithRtc
    ldr r0,=0x03002700
    mov r4,0
    strb r4,[r0,0]
    ldr r0,=0x03005D88
    ldr r1,=(AgbMain + 0x64)
    mov pc,r1
    .pool
.endfunc

.func SeedRngWithRtc
    push lr
    ldr r1,=(RtcGetMinuteCount|1)
    bl @@call_r1
    mov r2,r0
    lsr r0,r2,0x10
    ldr r1,=0xFFFF
    and r1,r2
    eor r0,r1
    ldr r1,=(SeedRng|1)
    bl @@call_r1
    pop r1
 @@call_r1:
    bx r1
    .pool
.endfunc

//【绿宝石转火红叶绿风格seed生成机制】：
.elseif (SeedRNGFix_OPTION == SeedRNGFix_FRLG)
//SeedRNGFix_FRLG_StartTimer1;
//SeedRNGFix_FRLG;

.func SeedRNGFix_FRLG_StartTimer1
    ldr r1,=(StartTimer1|1)
    bl @@call_r1
    mov r0,0
    ldr r1,=(SetVBlankCallback|1)
    bl @@call_r1
    mov r0,0x50
    ldr r1,=(CB2_InitTitleScreen + 0x44)
    mov pc,r1
    .pool
.endfunc

.func SeedRNGFix_FRLG
    ldr r1,=(SeedRngAndSetTrainerId|1)
    bl @@call_r1
    mov r0,4
    ldr r1,=(FadeOutBGM|1)
    bl @@call_r1
    mov r0,1
    ldr r1,=(Task_TitleScreenPhase3 + 0x28)
    mov pc,r1
 @@call_r1:
    bx r1
    .pool
.endfunc

.endif