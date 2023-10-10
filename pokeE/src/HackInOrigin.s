;用于汉字单字宽度计算
;.org GetGlyphWidth + 2                              ;0x080048ea
;    bl GetGlyphWidthChinese

;用于含汉字的句子宽度计算
;.org GetStringWidth + 0x100                         ;0x08004ccc

;用于输出汉字显示
;.org DrawGlyphTiles + 2                             ;0x08006876
;    bl DrawGlyphTilesChinese