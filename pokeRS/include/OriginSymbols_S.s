;OriginFunctionAddress
sub_80034D4                             equ 0x080034d4
sub_8003504                             equ 0x08003504
GetGlyphWidth                           equ 0x080048e8
GetStringWidth                          equ 0x08004bcc
DrawGlyphTile_ShadowedFont              equ 0x08005680
DrawGlyphTiles                          equ 0x08006874
GetExpandedPlaceholder                  equ 0x08006fcc
UpdateTilemap                           equ 0x08006954
GetCursorTileNum                        equ 0x080069D8
StringCopy                              equ 0x08006ab0
StringAppend                            equ 0x08006ad0
gMiscBlank_Gfx                          equ 0x0820896c
UpdateNickInHealthbox                   equ 0x080451A0
UpdateSafariBallsTextInHealthbox        equ 0x080458B0
UpdateLeftNoOfBallsTextOnHealthbox      equ 0x08045998
GetBattlerPosition                      equ 0x0807882C
sub_8097F58                             equ 0x08097F58
PrintDisplayMonInfo                     equ 0x080981f0
CpuSet                                  equ 0x081e077c

;strings
BattleText_SafariBalls                  equ 0x08400e2e
BattleText_SafariBallsLeft              equ 0x08400e3e
BattleText_HighlightRed                 equ 0x08400e48
gMainMenuString_NewGame                 equ 0x0840dd2c
PCText_PokeCenter                       equ 0x08410b77

;graphic
gPSSMenuHeader_Tilemap                  equ 0x08e8e128

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