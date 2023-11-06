;用于输出汉字显示
.org RenderText + 0xB2                              ;0x08005842
    ldr r3,=RenderTextChinese
    mov pc,r3
.pool
    
;用于汉字宽度计算
.org sFontMaleLatinGlyphWidths + 0x1                ;0x08217619
    .byte 0x0C  ;sFontMaleLatinGlyphWidths[1] = 0x0C
    .byte 0x0A  ;sFontMaleLatinGlyphWidths[2] = 0x0A