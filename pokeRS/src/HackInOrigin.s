.org GetGlyphWidthjump
    bl GetGlyphWidthChinese

.org DrawGlyphTilesjump
    bl DrawGlyphTilesChinese

.org changeRam1
.byte 0x32  ;32 4F ldr r7,[pc,0xC8];=0x04000008

.org changeRam2
.byte 0x06  ;.word 0x04000006
