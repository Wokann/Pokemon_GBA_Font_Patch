GetGlyphWidthChinese:
    ldrb r2, [r0, 2]
    cmp r2, 2
    bne backtoorigin2
    ldrb r2, [r0, 0xE]
    cmp r2, 0
    bne backtoorigin2
    ldrb r2, [r0, 1]
    cmp r2, 3
    beq checkchinese2
    cmp r2, 4
    beq checkchinese2

backtoorigin2:
    mov r2, r0
    mov r3, r1
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
    mov r3, r1
    mov r1, r2
    mov r2, r0
    mov r0, r1
    pop r1
    bx r1

/*
原函数
static u8 GetGlyphWidth(struct Window *win, u32 glyph)
{
    u8 width = 8;

#ifdef BUGFIX_GLYPHWIDTH
    if (win->language != LANGUAGE_JAPANESE)
#else
    if (win->language == LANGUAGE_ENGLISH)
#endif
    {
        width = win->spacing;
        if (!win->spacing)
        {
            switch (win->fontNum)
            {
            case 3:
                width = sFont3Widths[glyph];
                break;
            case 4:
            case 5:
                width = sFont4Widths[sFontType1Map[2 * glyph + 1]];
                break;
            case 0:
                width = sFont0Widths[glyph];
                break;
            case 1:
            case 2:
                width = sFont1Widths[sFontType1Map[2 * glyph + 1]];
                break;
            case 6:
                width = 8;
                break;
            default:
                width = 8;
            }
        }
    }

    return width;
}
 */