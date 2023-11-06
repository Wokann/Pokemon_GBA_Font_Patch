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