;OriginFunctionAddress
GetGlyphWidth                           equ 0x080048e8
DrawGlyphTile_ShadowedFont              equ 0x08005680
DrawGlyphTiles                          equ 0x08006874
UpdateTilemap                           equ 0x08006954
GetCursorTileNum                        equ 0x080069D8
gMiscBlank_Gfx                          equ 0x082089dC
UpdateNickInHealthbox                   equ 0x080451A0

;strings

;graphic
gFont3LatinGlyphs                       equ 0x08ea2c44

;define
FONT_NORMAL_UNSHADOWED                  equ 0
FONT_SMALL_UNSHADOWED                   equ 1
FONT_SMALL_COPY_UNSHADOWED              equ 2
FONT_NORMAL_SHADOWED                    equ 3
FONT_SMALL_SHADOWED                     equ 4
FONT_SMALL_COPY_SHADOWED                equ 5
FONT_BRAILLE                            equ 6

LANGUAGE_JAPANESE                       equ 1
LANGUAGE_ENGLISH                        equ 2
LANGUAGE_FRENCH                         equ 3
LANGUAGE_ITALIAN                        equ 4
LANGUAGE_GERMAN                         equ 5
LANGUAGE_KOREAN                         equ 6 ;unused
LANGUAGE_SPANISH                        equ 7
NUM_LANGUAGES                           equ 7
