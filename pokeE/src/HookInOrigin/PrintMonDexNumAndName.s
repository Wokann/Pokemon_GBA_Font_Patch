;用于修改宝可梦图鉴界面，宝可梦名的位置，往左偏移4像素
.org PrintMonDexNumAndName + 0x1C        ;0x080BCE48
   ldr r5,=PrintMonDexNumAndNameChinese
   mov pc,r5
.pool

;用于修改宝可梦图鉴界面，右侧滑块所在的位置，往右偏移2像素
.org CreateInterfaceSprites + 0x5C      ;0x080BDBD8
    mov r1,0xE8         ;CreateSprite(&sScrollBarSpriteTemplate, 232, 20, 0); //230->232