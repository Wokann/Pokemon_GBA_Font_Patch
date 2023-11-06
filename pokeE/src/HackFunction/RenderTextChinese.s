.func RenderTextChinese
    ldrb r3,[r0,0x0]
    add r0,0x1
    str r0,[r6,0x0]
    b @@IfIsJapanese

@@BackToOrigin:
    mov r0,r3
    sub r0,0xF8
    push r0
    ldr r0,=(RenderText + 0xD0)             ;0x08005884
    mov lr,r0
    pop r0
    mov pc,lr
.pool

@@IfIsJapanese:
    mov r0,r6
    add r0,0x21
    ldrb r0,[r0,0]
    lsl r0,r0,0x1C
    lsr r0,r0,0x1C
    cmp r0,LANGUAGE_JAPANESE
    beq @@BackToOrigin
@@IfIsBraille:
    ldrb r0,[r4,0]
    lsl r0,r0,0x1C
    lsr r0,r0,0x1C
    cmp r0,FONT_BRAILLE
    beq @@BackToOrigin

@@IfIsChinesePunctuation:
    cmp r3,0x36
    blt @@IfisChinese
    cmp r3,0x3E
    bgt @@BackToOrigin
    mov r1,0x36
    sub r1,r3,r1
    ldrb r0,[r4,0]
    lsl r0,r0,0x1C
    lsr r0,r0,0x1C
    cmp r0,FONT_SMALL
    beq @@GetChsSmallPunctuation
    cmp r0,FONT_SMALL_NARROW
    beq @@GetChsSmallPunctuation
    b @@GetChsNormalPunctuation

@@GetChsNormalPunctuation:
    ldr r0,=PokePunctuationChsNormal
    lsl r1,r1,4
    mov r2,11
    mov r3,1
    b @@JumpToDecompressGlyph

@@GetChsSmallPunctuation:
    ldr r0,=PokePunctuationChsSmall
    mov r2,0xB
    mul r1,r2
    mov r2,9
    mov r3,2
    b @@JumpToDecompressGlyph

@@IfisChinese:
    cmp r3,0x1
    blt @@BackToOrigin
    cmp r3,0x1E
    bgt @@BackToOrigin
    cmp r3,0x6
    beq @@BackToOrigin
    cmp r3,0x1B
    beq @@BackToOrigin
    ldr r0,[r6,0x0]
    ldrb r0,[r0,0x0]
    cmp r0,0xF7
    bge @@BackToOrigin
@@SubChsGlyphIdHi:
    mov r1,r0
    ldr r0,[r6,0x0]
    add r0,0x1
    str r0,[r6,0x0]
    cmp r3,0x6
    blt @@SubChs_1h_5h
    cmp r3,0x1b
    blt @@SubChs_7h_1Ah
@@SubChs_1Ch_1Eh:
    sub r3,0x1
@@SubChs_7h_1Ah:
    sub r3,0x1
@@SubChs_1h_5h:
    sub r3,0x1
@@CombineChsGlyphId:
    mov r0,0xF7
    mul r3,r0
    add r1,r3,r1            ;r1 = SubedCharId
    ldrb r0,[r4,0]
    lsl r0,r0,0x1C
    lsr r0,r0,0x1C
    cmp r0,FONT_SMALL
    beq @@GetChsSmallFont
    cmp r0,FONT_SMALL_NARROW
    beq @@GetChsSmallFont
    b @@GetChsNormalFont

@@GetChsNormalFont:
    ldr r0,=PokeFontChsNormal
    lsl r1,r1,4
    mov r2,11
    mov r3,1
    b @@JumpToDecompressGlyph

@@GetChsSmallFont:
    ldr r0,=PokeFontChsSmall
    mov r2,0xB
    mul r1,r2
    mov r2,9
    mov r3,2
    b @@JumpToDecompressGlyph

@@JumpToDecompressGlyph:
    bl Convert1bppTo2bpp
    push r4
    ldr r4,=(RenderText + 0x433)            ;0x08005BE7
    mov lr,r4
    pop r4
    push r4-r6,lr
    ldr r6,=(DecompressGlyph_Normal + 0x50) ;0x08006890
    mov pc,r6
.pool
.endfunc
