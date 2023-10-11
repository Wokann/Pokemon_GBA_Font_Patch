;用于汉字单字宽度计算
.org GetGlyphWidth + 2                              ;0x080048ea
    bl GetGlyphWidthChinese

;用于输出汉字显示
.org DrawGlyphTiles + 2                             ;0x08006876
    bl DrawGlyphTilesChinese

;用于对战HP框，宝可梦名字的完整显示
.org UpdateNickInHealthbox + 0x1EA                  ;0x0804538A
    ldr r7,[pc,0xC8];=0x04000008
.skip 0x3C
    .word 0x04000006                                ;0x080453C8
