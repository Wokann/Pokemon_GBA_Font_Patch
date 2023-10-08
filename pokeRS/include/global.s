;OriginFunctionAddress
DrawGlyphTile_ShadowedFont      equ 0x08005680
GetCursorTileNum                equ 0x080069D8
UpdateTilemap                   equ 0x08006954
gMiscBlank_Gfx                  equ 0x082089DC
/* 
.definelabel DrawGlyphTile_ShadowedFont ,0x08005680
.definelabel GetCursorTileNum           ,0x080069D8
.definelabel UpdateTilemap              ,0x08006954
*/

;HackInOriginAddress
GetGlyphWidthjump               equ 0x080048EA
DrawGlyphTilesjump              equ 0x08006876
changeRam1                      equ 0x0804538A
changeRam2                      equ 0x080453C8

;HackFunctionAddress
DrawGlyphTilesChineseAddress    equ 0x082089DC
GetGlyphWidthChineseAddress     equ 0x08208C00
PokeRSFontChsSymAddress         equ 0x08EA39C0
PokeRSFontChsAddress            equ 0x09000000


