.org DrawGlyphTilesChineseAddress
DrawGlyphTilesChinese:
    ldrb r6, [r0, 1]
    sub sp, 0x1C
    cmp r6, 3
    beq checkchinese
    cmp r6, 4
    beq checkchinese

backtoorigin:
    mov r6, r0
    bx lr

checkchinese:
    cmp r1, 1
    blt backtoorigin
    cmp r1, 0x1E
    bgt backtoorigin
    cmp r1, 6
    beq backtoorigin
    cmp r1, 0x1B
    beq backtoorigin
    ldrb r6, [r0, 2]
    cmp r6, 2
    bne backtoorigin
    nop

ischinese:
    mov r6, r0
    ldr r0, [r6, 0x20]
    mov r5, r2
    ldrh r2, [r6, 0x1E]
    add r0, r0, r2
    ldrb r0, [r0, 0]
    add r2, 1
    strh r2, [r6, 0x1E]
    cmp r1, 6
    blt sub1
    cmp r1, 0x1B
    blt sub2

sub3:
    sub r1, 1

sub2:
    sub r1, 1

sub1:
    sub r1, 1

getgylphid:
    lsl r1, r1, 8
    add r1, r1, r0
    ldrb r3, [r6, 1]
    cmp r3, 4
    beq getsmallfont

getnormalfont:
    ldr r0, =0x09000000
    b loadfontglyph

getsmallfont:
    ldr r0, =0x09100000

loadfontglyph:
    lsl r1, r1, 7
    add r0, r0, r1
    add r1, sp, 4
    ldrb r2, [r6, 0]
    strb r2, [r1, 0]
    str r0, [r1, 4]
    ldrb r0, [r6, 0x10]
    ldrb r2, [r6, 0x12]
    add r0, r0, r2
    mov r2, 7
    and r0, r2
    strb r0, [r1, 1]
    mov r0, 8
    strb r0, [r1, 2]
    mov r0, r6
    mov r1, 0
    mov r2, 0
    bl GetCursorTileNum
    lsl r0, r0, 5
    ldr r1, [r6, 0x24]
    add r1, r1, r0
    str r1, [sp, 0xC]
    ldr r0, =0x030003A4
    str r0, [sp, 0x10]
    add r0, sp, 4
    bl DrawGlyphTile_ShadowedFont
    b conituefont
.pool

conituefont:
    ldr r0, [sp, 8]
    add r0, 0x20
    str r0, [sp, 8]
    mov r0, r6
    mov r1, 0
    mov r2, 1
    bl GetCursorTileNum
    lsl r0, r0, 5
    ldr r1, [r6, 0x24]
    add r1, r1, r0
    str r1, [sp, 0xC]
    add r0, sp, 4
    bl DrawGlyphTile_ShadowedFont
    mov r1, r0
    mov r0, r6
    bl UpdateTilemap
    ldr r0, [sp, 8]
    add r0, 0x20
    str r0, [sp, 8]
    add r1, sp, 4
    strb r5, [r1, 2]
    ldrb r0, [r6, 0x10]
    add r0, 8
    strb r0, [r6, 0x10]
    ldrb r0, [r6, 0]
    cmp r0, 2
    beq continue2
    ldrh r0, [r6, 0x1C]
    add r0, 2
    strh r0, [r6, 0x1C]

continue2:
    mov r0, r6
    mov r1, 0
    mov r2, 0
    bl GetCursorTileNum
    lsl r0, r0, 5
    ldr r1, [r6, 0x24]
    add r1, r1, r0
    str r1, [sp, 0xC]
    add r0, sp, 4
    bl DrawGlyphTile_ShadowedFont
    ldr r0, [sp, 8]
    add r0, 0x20
    str r0, [sp, 8]
    mov r0, r6
    mov r1, 0
    mov r2, 1
    bl GetCursorTileNum
    lsl r0, r0, 5
    ldr r1, [r6, 0x24]
    add r1, r1, r0
    str r1, [sp, 0xC]
    add r0, sp, 4
    bl DrawGlyphTile_ShadowedFont
    add sp, 0x1C
    pop r4-r7
    pop r1
    bx r1
