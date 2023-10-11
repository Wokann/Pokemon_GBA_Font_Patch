RenderTextChinese:
    ldrb r3,[r0,0x0]
    add r0,0x1

Ifischinese2:
    cmp r3,0x1
    blt backtoorigin2
    cmp r3,0x1E
    bgt backtoorigin2
    cmp r3,0x6
    beq backtoorigin2
    cmp r3,0x1B
    beq backtoorigin2

getchsglyphid:
    ldrb r1,[r0,0x0]
    add r0,0x1
    str r0,[r6,0x0]
    cmp r3,0x6
    blt subchs_1h_5h
    cmp r3,0x1b
    blt subchs_7h_1Ah

subchs_1Ch_1Eh:
    sub r3,0x1

subchs_7h_1Ah:
    sub r3,0x1

subchs_1h_5h:
    sub r3,0x1

getchsfontglyph:
    lsl r3,r3,0x8
    add r1,r1,r3
    lsl r1,r1,0x6
    ldrb r0,[r4,0x0]
    cmp r0,0x0
    beq getChsSmallFont

getChsNormalFont:
    ldr r0,=PokeEFontChsNormal
    mov r3,1    ;gGlyphInfo.width = gFontNormalLatinGlyphWidths[1] = 0x0C
    b jumptoDecompressGlyph

getChsSmallFont:
    ldr r0,=PokeEFontChsSmall
    mov r3,2    ;gGlyphInfo.width = gFontNormalLatinGlyphWidths[2] = 0x0A
    b jumptoDecompressGlyph
.pool

jumptoDecompressGlyph:
    push r4
    ldr r4,=(RenderText + 0x433)            ;0x08005BE7
    mov lr,r4
    pop r4
    push r4-r6,lr
    ldr r6,=(DecompressGlyph_Normal + 0x50) ;0x08006890
    mov pc,r6
.pool

backtoorigin2:
    str r0,[r6,0x0]
    mov r0,r3
    sub r0,0xF8
    push r0
    ldr r0,=(RenderText + 0xD0)             ;0x08005884
    mov lr,r0
    pop r0
    mov pc,lr
.pool