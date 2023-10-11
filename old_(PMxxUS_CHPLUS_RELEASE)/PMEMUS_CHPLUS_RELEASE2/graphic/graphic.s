.org PokeEFontChsNormal
.incbin "./graphic/fonts/PokeEFontChsNormal(0x70000).bin"

.org PokeEFontChsSmall
.incbin "./graphic/fonts/PokeEFontChsSmall(0x70000).bin"

;gfx，修改图鉴界面右侧滑块所在的条的位置，往右偏移
.org gPokedexMenu_Gfx
.incbin "./graphic/gPokedexMenu_Gfx_Chs(0xA18).4bpp.lz"

;tilemap，修改图鉴界面当前选择白底的宽度，往右扩容
.org gPokedexListUnderlay_Tilemap
.incbin "./graphic/gPokedexListUnderlay_Tilemap_Chs(0xC0).bin.lz"
