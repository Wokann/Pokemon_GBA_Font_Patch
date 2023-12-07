.func SeedRNGFix_FRLG_StartTimer1
    ldr r1,=(StartTimer1|1)
    bl call_bx1
    mov r0,0
    ldr r1,=(SetVBlankCallback|1)
    bl call_bx1
    mov r0,0x50
    ldr r1,=(CB2_InitTitleScreen + 0x44)
    mov pc,r1
.pool
.endfunc

.func SeedRNGFix_FRLG
    ldr r1,=(SeedRngAndSetTrainerId|1)
    bl call_bx1
    mov r0,4
    ldr r1,=(FadeOutBGM|1)
    bl call_bx1
    mov r0,1
    ldr r1,=(Task_TitleScreenPhase3 + 0x28)
    mov pc,r1
.pool
.endfunc

.func call_bx1
    bx r1
.endfunc