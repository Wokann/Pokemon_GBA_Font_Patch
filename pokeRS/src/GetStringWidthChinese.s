
GetStringWidthChinese:
    ldrb r0, [r5, 1]            ;win->fontNum
    cmp r0, FONT_BRAILLE        ;if(win->fontNum != FONT_BRAILLE)
    beq originwidth
    ldrb r0, [r5, 2]            ;win->language
    cmp r0, LANGUAGE_JAPANESE   ;if(win->language != LANGUAGE_JAPANESE)
    beq originwidth
    
Ifischinese3:
    add r0, r7, r6              ;r0 = *s
    ldrb r1, [r0]                ;r1 = s[i]
    cmp r1, 1
    blt originwidth            ;glyph < 0x01
    cmp r1, 0x1E
    bgt originwidth            ;glyph > 0x1E
    cmp r1, 6
    beq originwidth            ;glyph == 0x6
    cmp r1, 0x1B
    beq originwidth            ;glyph == 0x1B
    add r0, r0, 1       
    ldrb r0, [r0]               ;r0 = s[i+1]
    cmp r0,0xF6
    bgt originwidth

addchinesewidth:
    add r6, 2
    ldrb r0, [r5, 1]            ;win->fontNum
    cmp r0, FONT_NORMAL_UNSHADOWED  ;win->fontNum == 0
    beq getnormalfontwidth2
    cmp r0, FONT_NORMAL_SHADOWED    ;win->fontNum == 3
    beq getnormalfontwidth2

getsmallfontwidth2:                  ;1,2,4,5
    mov r0, 0xA
    b add2all
    
getnormalfontwidth2:                 ;0,3
    mov r0, 0xC
    b add2all

originwidth:
    add r6, 1
    add r0, r5, 0
    str r2, [sp]
    push lr
    bl GetGlyphWidth
    pop r2
    mov r14,r2
    ldr r2, [sp]

add2all:
    add r0, r2, r0
    lsl r0, r0, 0x18
    lsr r2, r0, 0x18
    bx lr

/*
GetStringWidth:
    push {r4, r5, r6, r7, lr}
    mov r7, r10
    mov r6, r9
    mov r5, r8
    push {r5, r6, r7}
    sub sp, 4
    adds r5, r0, 0
    adds r7, r1, 0
    movs r2, 0
    ldrb r0, [r5, 1]
    mov r10, r0
    ldrb r1, [r5, 2]
    mov r9, r1
    ldrb r0, [r5, 0xe]
    mov r8, r0
    movs r6, 0
    ldrb r0, [r7]
    cmp r0, 0xff
    beq continue

loop2:
    adds r0, r7, r6
    ldrb r1, [r0]
    cmp r1, 0xfc
    beq EXT_CTRL_CODE_BEGIN
    cmp r1, 0xfd
    bne default

PLACEHOLDER_BEGIN:
    adds r6, 1
    ldrb r4, [r5, 2]
    adds r0, r7, r6
    ldrb r0, [r0]
    str r2, [sp]
    bl GetExpandedPlaceholder
    adds r1, r0, 0
    adds r0, r5, 0
    bl GetStringWidthChinese
    ldr r2, [sp]
    adds r0, r2, r0
    lsl r0, r0, 0x18
    lsrs r2, r0, 0x18
    strb r4, [r5, 2]
    adds r6, 1
    b loop2check

EXT_CTRL_CODE_BEGIN:
    adds r6, 1
    adds r0, r7, r6
    ldrb r0, [r0]
    subs r0, 6
    cmp r0, 0x10
    bhi EXT_CTRL_CODE_end
    lsl r0, r0, 2
    ldr r1, [pc, 4]
    adds r0, r0, r1
    ldr r0, [r0]
    mov pc, r0
.jumptable


    adds r0, r6, r7
    ldrb r0, [r0, 1]
    strb r0, [r5, 1]
    b EXT_CTRL_CODE_end

    ldr r0, [r5, 0x2c]
    ldrb r0, [r0, 8]
    strb r0, [r5, 1]
    b EXT_CTRL_CODE_end

    adds r0, r6, r7
    ldrb r0, [r0, 1]
    adds r0, r2, r0
    lsl r0, r0, 0x18
    lsrs r2, r0, 0x18
    b EXT_CTRL_CODE_end

    adds r0, r6, r7
    ldrb r1, [r0, 1]
    cmp r2, r1
    bhs EXT_CTRL_CODE_end

    ldrb r2, [r0, 1]
    b EXT_CTRL_CODE_end

    adds r0, r6, r7
    ldrb r0, [r0, 1]
    strb r0, [r5, 0xe]
    b EXT_CTRL_CODE_end

EXT_15_JAP:
    movs r0, 1
    b language
EXT_16_ENG:
    movs r0, 2
language:
    strb r0, [r5, 2]

EXT_CTRL_CODE_end:
    adds r0, r7, r6
    ldrb r0, [r0]
    str r2, [sp]
    bl 0x800496c
    lsl r0, r0, 0x18
    lsrs r0, r0, 0x18
    adds r6, r6, r0
    ldr r2, [sp]
    b loop2check

default:    ;0x08004ccc
    adds r6, 1
    adds r0, r5, 0
    str r2, [sp]
    bl GetGlyphWidth
    ldr r2, [sp]
    adds r0, r2, r0     ;0x08004cd8
    lsls r0, r0, 0x18
    lsrs r2, r0, 0x18


loop2check:
    adds r0, r7, r6
    ldrb r0, [r0]
    cmp r0, 0xff
    bne loop2

continue:
    mov r0, r8
    strb r0, [r5, 0xe]
    mov r1, r9
    strb r1, [r5, 2]
    mov r0, r10
    strb r0, [r5, 1]
    adds r0, r2, 0
    add sp, 4
    pop {r3, r4, r5}
    mov r8, r3
    mov r9, r4
    mov r10, r5
    pop {r4, r5, r6, r7}
    pop {r1}
    bx r1
*/


/*
u8 GetStringWidth(struct Window *win, const u8 *s)
{
    u8 width = 0;
    u8 savedFontNum = win->fontNum;
    u8 savedLanguage = win->language;
    u8 savedSpacing = win->spacing;
    s32 i = 0;

    while (s[i] != EOS)
    {
        u8 c = s[i];
        switch (c)
        {
        case PLACEHOLDER_BEGIN:
        {
            u8 temp;
            i++;
            temp = win->language;
            width += GetStringWidth(win, GetExpandedPlaceholder(s[i]));
            win->language = temp;
            i++;
            break;
        }
        case EXT_CTRL_CODE_BEGIN:
            i++;
            switch (s[i])
            {
            case 6:
                win->fontNum = s[i + 1];
                break;
            case 7:
                win->fontNum = win->template->fontNum;
                break;
            case 0x11:
                width += s[i + 1];
                break;
            case 0x12:
            case 0x13:
                if (width < s[i + 1])
                    width = s[i + 1];
                break;
            case 0x14:
                win->spacing = s[i + 1];
                break;
            case 0x15:
                win->language = LANGUAGE_JAPANESE;
                break;
            case 0x16:
                win->language = GAME_LANGUAGE;
                break;
            }

            i += GetExtCtrlCodeLength(s[i]);
            break;
        default:
            i++;
            if (win->language != LANGUAGE_JAPANESE && win->fontNum != FONT_BRAILLE)
            {    
                if( c >= 0x01 && c <= 0x1E && c != 0x06 && c != 0x1B)
                {    
                    if(s[i+1] <= 0xF6)
                    {    
                        if(savedFontNum == 0||savedFontNum ==3)
                            width += 12;
                        else //1,2,4,5
                            width += 10;
                            i++;
                    }
                }
            }
            else
                width += GetGlyphWidth(win, c);
        }
    }

    win->spacing = savedSpacing;
    win->language = savedLanguage;
    win->fontNum = savedFontNum;

    return width;
}
 */