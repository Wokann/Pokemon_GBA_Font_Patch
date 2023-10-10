DrawGlyphTilesChinese:
    sub sp, 0x1C
    ldrb r6, [r0, 1]            ;win->fontNum
    cmp r6, FONT_BRAILLE        ;if(win->fontNum != FONT_BRAILLE)
    beq backtoorigin
    ldrb r6, [r0, 2]            ;win->language
    cmp r6, LANGUAGE_JAPANESE   ;if(win->language != LANGUAGE_JAPANESE)
    bne Ifischinese

backtoorigin:
    mov r6, r0
    bx lr

Ifischinese:
    cmp r1, 1
    blt backtoorigin            ;glyph < 0x01
    cmp r1, 0x1E
    bgt backtoorigin            ;glyph > 0x1E
    cmp r1, 6
    beq backtoorigin            ;glyph == 0x6
    cmp r1, 0x1B
    beq backtoorigin            ;glyph == 0x1B

    push r1
    ldr r6, [r0, 0x20]          ;r6 = win->*text
    ldrh r1, [r0, 0x1E]         ;r1 = win->*text[win->textIndex]
    add r6,r6,r1
    ldrb r6,[r6,0]
    pop r1
    cmp r6,0xF6
    bgt backtoorigin

Ischinese:
    mov r6, r0
    ldr r0, [r6, 0x20]          ;r0 = win->*text
    mov r5, r2
    ldrh r2, [r6, 0x1E]         ;r2 = win->textIndex
    add r0, r0, r2
    ldrb r0, [r0, 0]
    add r2, 1                   ;win->textIndex++
    strh r2, [r6, 0x1E]         ;
    cmp r1, 6                   ;0x01-0x05: glyph -1
    blt sub1
    cmp r1, 0x1B                ;0x07-0x1A: glyph -1 -1
    blt sub2

sub3:                           ;0x1C-0x1E: glyph -1 -1 -1
    sub r1, 1

sub2:
    sub r1, 1

sub1:
    sub r1, 1

getgylphid:
    lsl r1, r1, 8
    add r1, r1, r0
    ldrb r3, [r6, 1]                ;win->fontNum
    cmp r3, FONT_NORMAL_UNSHADOWED  ;0
    beq getnormalfont
    cmp r3, FONT_NORMAL_SHADOWED    ;3
    beq getnormalfont

getsmallfont:                       ;1,2,4,5
    ldr r0, =PokeRSFontChsSmall
    b loadfontglyph

getnormalfont:                      ;0,3
    ldr r0, =PokeRSFontChsNormal

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

/*
原函数
static s32 DrawGlyphTiles(struct Window *win, u32 glyph, u32 glyphWidth)
{
    struct GlyphTileInfo glyphTileInfo;
    u8 *upperTile;
    u8 *lowerTile;
    s32 retVal = 0;

    GetGlyphTilePointers(win->fontNum, win->language, glyph, &upperTile, &lowerTile);
    glyphTileInfo.textMode = win->textMode;
    glyphTileInfo.startPixel = (win->left + win->cursorX) & 7;
    glyphTileInfo.width = glyphWidth;
    glyphTileInfo.src = upperTile;
    glyphTileInfo.dest = (u32 *)(win->tileData + 32 * GetCursorTileNum(win, 0, 0));
    glyphTileInfo.colors = sGlyphBuffer.colors;

    switch (win->fontNum)
    {
    case 0:
    case 1:
    case 2:
    case 6:
        DrawGlyphTile_UnshadowedFont(&glyphTileInfo);
        glyphTileInfo.src = lowerTile;
        glyphTileInfo.dest = (u32 *)(win->tileData + 32 * GetCursorTileNum(win, 0, 1));
        retVal = DrawGlyphTile_UnshadowedFont(&glyphTileInfo);
        break;
    case 3:
    case 4:
    case 5:
        DrawGlyphTile_ShadowedFont(&glyphTileInfo);
        glyphTileInfo.src = lowerTile;
        glyphTileInfo.dest = (u32 *)(win->tileData + 32 * GetCursorTileNum(win, 0, 1));
        retVal = DrawGlyphTile_ShadowedFont(&glyphTileInfo);
        break;
    }

    return retVal;
}
 */