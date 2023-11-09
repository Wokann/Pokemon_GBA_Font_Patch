;用于狩猎地带HP框，狩猎球名字的完整显示
.org UpdateSafariBallsTextInHealthbox + 0x30        ;0x080458E0
    mov r1,4    ;狩猎球3个字仅占4个tile
.skip 0x14
    bl UpdateSafariBallsTextInHealthboxChinese      ;0x080458F6
.skip 0x92
    .word BattleText_SafariBalls                    ;0x0804598C
