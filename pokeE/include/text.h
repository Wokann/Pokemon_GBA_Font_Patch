.ifndef TEXT_H
.definelabel TEXT_H,0

.definelabel gCurGlyph,                 0x03002F90

.definelabel DecompressGlyphTile,       0x08004C10
.definelabel RenderText,                0x080057b4
.definelabel GetStringWidth,            0x08005ED8
.definelabel DecompressGlyph_Normal,    0x08006840
.definelabel gFontNormalLatinGlyphWidths,0x086542e4

.definelabel FONT_SMALL,            0
.definelabel FONT_NORMAL,           1
.definelabel FONT_SHORT,            2
.definelabel FONT_SHORT_COPY_1,     3
.definelabel FONT_SHORT_COPY_2,     4
.definelabel FONT_SHORT_COPY_3,     5
.definelabel FONT_BRAILLE,          6
.definelabel FONT_NARROW,           7
.definelabel FONT_SMALL_NARROW,     8 //Very similar to FONT_SMALL, some glyphs are narrower
.definelabel FONT_BOLD,             9 //JP glyph set only

.endif //TEXT_H