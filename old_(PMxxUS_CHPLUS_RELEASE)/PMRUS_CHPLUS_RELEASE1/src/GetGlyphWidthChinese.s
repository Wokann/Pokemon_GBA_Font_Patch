GetGlyphWidthChinese:
    ldrb r2, [r0, 2]
    cmp r2, LANGUAGE_ENGLISH
    bne backtoorigin2
    ldrb r2, [r0, 0xE]
    cmp r2, 0
    bne backtoorigin2
    ldrb r2, [r0, 1]
    cmp r2, FONT_NORMAL_SHADOWED
    beq checkchinese2
    cmp r2, FONT_SMALL_SHADOWED
    beq checkchinese2

backtoorigin2:
    .byte 0x02,0x46 ;mov r2, r0
    .byte 0x0B,0x46 ;mov r3, r1
    bx lr

checkchinese2:
    cmp r1, 1
    blt backtoorigin2
    cmp r1, 0x1E
    bgt backtoorigin2
    cmp r1, 6
    beq backtoorigin2
    cmp r1, 0x1B
    beq backtoorigin2

getchinesewidth:
    mov r3, 0xA
    lsl r2, r2, 1
    sub r2, r3, r2
    .byte 0x0B,0x46 ;mov r3, r1
    .byte 0x11,0x46 ;mov r1, r2
    .byte 0x02,0x46 ;mov r2, r0
    .byte 0x08,0x46 ;mov r0, r1
    pop r1
    bx r1
