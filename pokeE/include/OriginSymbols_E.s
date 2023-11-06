;OriginFunctionAddress
RenderText                              equ 0x080057b4
DecompressGlyph_Normal                  equ 0x08006840
PrintMonDexNumAndName                   equ 0x080bce2c
CreateInterfaceSprites                  equ 0x080bdb7c  ;用于宝可梦图鉴内的，而非同名函数用于抽奖的
gFontNormalLatinGlyphWidths             equ 0x086542e4
GetStringWidth                          equ 0x08005ED8

;strings


;graphic
gFontNormalLatinGlyphs                  equ 0x0864c2e4
gPokedexMenu_Gfx                        equ 0x08dc1934
gPokedexListUnderlay_Tilemap            equ 0x08dc2dac

;define
FONT_SMALL                              equ 0
FONT_NORMAL                             equ 1
FONT_SHORT                              equ 2
FONT_SHORT_COPY_1                       equ 3
FONT_SHORT_COPY_2                       equ 4
FONT_SHORT_COPY_3                       equ 5
FONT_BRAILLE                            equ 6
FONT_NARROW                             equ 7
FONT_SMALL_NARROW                       equ 8 ;Very similar to FONT_SMALL, some glyphs are narrower
FONT_BOLD                               equ 9 ;JP glyph set only

LANGUAGE_JAPANESE                       equ 1
LANGUAGE_ENGLISH                        equ 2
LANGUAGE_FRENCH                         equ 3
LANGUAGE_ITALIAN                        equ 4
LANGUAGE_GERMAN                         equ 5
LANGUAGE_KOREAN                         equ 6 ;unused
LANGUAGE_SPANISH                        equ 7
NUM_LANGUAGES                           equ 7
