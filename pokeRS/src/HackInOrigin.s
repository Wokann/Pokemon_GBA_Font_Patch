.org GetGlyphWidth + 2
    bl GetGlyphWidthChinese

.org DrawGlyphTiles + 2
    bl DrawGlyphTilesChinese

.org UpdateNickInHealthbox + 0x1EA    ;0x084538A
    ldr r7,[pc,0xC8]        ;=0x04000008
;因为下面那个把0x04000008改成了0x04000006，所以此处换了pc的偏移位置，以保证读到的值始终为0x04000008

.org UpdateNickInHealthbox + 0x228    ;0x08453C8
.word 0x04000006
;用于对战时宝可梦汉字名字的完整显示