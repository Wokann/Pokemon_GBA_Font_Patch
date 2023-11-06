;用于输出汉字显示
.org RenderText + 0xC6                  ;0x0800587A
    ldr r3,=RenderTextChinese
    mov pc,r3
.pool

;用于汉字宽度计算
.org gFontNormalLatinGlyphWidths + 0x1  ;0x086542E5
    .byte 0x0C  ;gFontNormalLatinGlyphWidths[1] = 0x0C
    .byte 0x0A  ;gFontNormalLatinGlyphWidths[2] = 0x0A