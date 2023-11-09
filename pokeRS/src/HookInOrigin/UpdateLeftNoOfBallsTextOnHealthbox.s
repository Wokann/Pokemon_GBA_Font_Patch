;用于狩猎地带HP框，剩余球数的完整显示
.org UpdateLeftNoOfBallsTextOnHealthbox + 0x5A      ;0x080459F2
    ldr r0, [pc,0x58];0x02000520
.skip 0x12
    push lr                                         ;0x08045A06
    bl UpdateLeftNoOfBallsTextOnHealthboxChinese
    pop r0
    mov r14,r0
    b UpdateLeftNoOfBallsTextOnHealthbox + 0x8C     ;=0x08045A24
.skip 0x2A
    .word BattleText_SafariBallsLeft                ;0x08045A3C
.skip 0x4
    .word BattleText_HighlightRed                   ;0x08045A44
    