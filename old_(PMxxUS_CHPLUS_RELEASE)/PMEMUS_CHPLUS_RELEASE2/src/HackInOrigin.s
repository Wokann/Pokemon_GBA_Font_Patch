;用于输出汉字显示
.org RenderText + 0xC6                  ;0x0800587A
    ldr r3,=RenderTextChinese
    mov pc,r3
    nop
.pool

;用于修改宝可梦图鉴界面，宝可梦名的位置，往左偏移4像素
.org PrintMonDexNumAndName + 0x8        ;0x080BCE34
    bl PrintMonDexNumAndNameChinese

;用于修改宝可梦图鉴界面，右侧滑块所在的位置，往右偏移2像素
.org CreateInterfaceSprites + 0x5C      ;0x080BDBD8
    mov r1,0xE8 ;CreateSprite(&sScrollBarSpriteTemplate, 232, 20, 0); //230->232

;用于汉字宽度计算
.org gFontNormalLatinGlyphWidths + 0x1  ;0x086542E5
    .byte 0x0C  ;gFontNormalLatinGlyphWidths[1] = 0x0C
    .byte 0x0A  ;gFontNormalLatinGlyphWidths[2] = 0x0A

