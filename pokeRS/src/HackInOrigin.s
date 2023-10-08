.org GetGlyphWidth + 2
    bl GetGlyphWidthChinese

.org DrawGlyphTiles + 2
    bl DrawGlyphTilesChinese

.org sub_80451A0 + 0x1EA
    ldr r7,[pc,0xC8]    ;=0x04000008

.org sub_80451A0 + 0x228
.word 0x04000006        ;.word 0x04000006
