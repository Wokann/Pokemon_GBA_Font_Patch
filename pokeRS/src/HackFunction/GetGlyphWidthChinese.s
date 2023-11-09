GetGlyphWidthChinese:
    ldrb r2, [r0, 2]            ;win->language
    cmp r2, LANGUAGE_JAPANESE   ;if(win->language != LANGUAGE_JAPANESE)
    beq backtoorigin2
    ldrb r2, [r0, 0xE]          ;width = win->spacing
    cmp r2, 0                   ;if(!win->spacing)
    bne backtoorigin2
    ldrb r2, [r0, 1]            ;win->fontNum
    cmp r2, FONT_BRAILLE        ;if(win->fontNum != FONT_BRAILLE)
    bne Ifischinese2

backtoorigin2:
    mov r2, r0                  ;r2 = *win
    mov r3, r1                  ;r3 = glyph
    bx lr

Ifischinese2:
    cmp r1, 1
    blt backtoorigin2            ;glyph < 0x01
    cmp r1, 0x1E
    bgt backtoorigin2            ;glyph > 0x1E
    cmp r1, 6
    beq backtoorigin2            ;glyph == 0x6
    cmp r1, 0x1B
    beq backtoorigin2            ;glyph == 0x1B

    push r1
    ldr r3, [r0, 0x20]          ;r3 = win->*text
    ldrh r1, [r0, 0x1E]         ;r1 = win->*text[win->textIndex]
    add r3,r3,r1
    ldrb r3,[r3,0]
    pop r1
    cmp r3,0xF6
    bgt backtoorigin2

getchinesewidth:
    cmp r2, FONT_NORMAL_UNSHADOWED  ;win->fontNum == 0
    beq getnormalfontwidth
    cmp r2, FONT_NORMAL_SHADOWED    ;win->fontNum == 3
    beq getnormalfontwidth

getsmallfontwidth:                  ;1,2,4,5
    mov r2, 0x2
    b end1
    
getnormalfontwidth:                 ;0,3
    mov r2, 0x4

end1:
    mov r3, r1                      ;r3 = glyph
    mov r1, r2                      ;r1 = width
    mov r2, r0                      ;r2 = *win
    mov r0, r1                      ;r0 = width
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