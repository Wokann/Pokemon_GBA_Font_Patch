;用于输出汉字显示
.org RenderText + 0xB0                              ;0x08005840
    mov r0,0x10
    lsl r0,r0,8
    add r0,0xD6
    add r0,pc
    ldr r0,[r0,0]
    add r0,0x40
    mov pc,r0   ;jump to RenderTextChinese = (sFontMaleLatinGlyphs + 0x40) = 0x0820f658

;用于保存界面徽章后的文字乱码去除
.org SaveStatToString + 0x104                       ;0x080F80D0
    mov r0,0

;用于汉字宽度计算
.org sFontMaleLatinGlyphWidths + 0x1                ;0x08217619
    .byte 0x0C  ;sFontMaleLatinGlyphWidths[1] = 0x0C
    .byte 0x0A  ;sFontMaleLatinGlyphWidths[2] = 0x0A

;用于对战界面的字体从小字变为大字
.org sTextOnWindowsInfo_Normal + 0x25               ;0x083feb89
    .byte 0x01
    ;sTextOnWindowsInfo_Normal[3]->fontId = 0  对应对战界面-招式-fontId
.skip 0xb
    .byte 0x01                                          ;0x083feb95
    ;sTextOnWindowsInfo_Normal[4]->fontId = 0  对应对战界面-招式-fontId
.skip 0xb
    .byte 0x01                                          ;0x083feba1
    ;sTextOnWindowsInfo_Normal[5]->fontId = 0  对应对战界面-招式-fontId
.skip 0xb
    .byte 0x01                                          ;0x083febad
    ;sTextOnWindowsInfo_Normal[6]->fontId = 0  对应对战界面-招式-fontId
.skip 0xb
    .byte 0x01                                          ;0x083febb9
    ;sTextOnWindowsInfo_Normal[7]->fontId = 0  对应对战界面-PP-fontId
.skip 0xb
    .byte 0x01                                          ;0x083febc5
    ;sTextOnWindowsInfo_Normal[8]->fontId = 0  对应对战界面-属性-fontId