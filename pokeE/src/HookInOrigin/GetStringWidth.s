;用于计算含汉字的句子宽度
.org GetStringWidth + 0xA               ;0x08005ee2
    ldr r4,=GetStringWidthPrepare
    mov pc,r4
.pool

.org GetStringWidth + 0x220             ;0x080060F8
    ldr r0,=GetStringWidthChinese
    mov pc,r0
.pool

.org GetStringWidth + 0x256             ;0x0800612E
    add sp,0xC

