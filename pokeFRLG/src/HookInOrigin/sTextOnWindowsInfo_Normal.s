;用于对战界面的字体从小字变为大字
.org sTextOnWindowsInfo_Normal + 0x25               ;FR_0x083feb89 LG_0x083fe9c5
    .byte 0x01
    ;sTextOnWindowsInfo_Normal[3]->fontId = 0  对应对战界面-招式-fontId
.skip 0xb
    .byte 0x01                                          ;FR_0x083feb95 LG_0x083fe9d1
    ;sTextOnWindowsInfo_Normal[4]->fontId = 0  对应对战界面-招式-fontId
.skip 0xb
    .byte 0x01                                          ;FR_0x083feba1 LG_0x083fe9dd
    ;sTextOnWindowsInfo_Normal[5]->fontId = 0  对应对战界面-招式-fontId
.skip 0xb
    .byte 0x01                                          ;FR_0x083febad LG_0x083fe9e9
    ;sTextOnWindowsInfo_Normal[6]->fontId = 0  对应对战界面-招式-fontId
.skip 0xb
    .byte 0x01                                          ;FR_0x083febb9 LG_0x083fe9f5
    ;sTextOnWindowsInfo_Normal[7]->fontId = 0  对应对战界面-PP-fontId
.skip 0xb
    .byte 0x01                                          ;FR_0x083febc5 LG_0x083fea01
    ;sTextOnWindowsInfo_Normal[8]->fontId = 0  对应对战界面-属性-fontId