;用于计算含汉字的句子宽度
.org GetStringWidth + 0x20C               ;0x080060e0
    ldr r0,=GetStringWidthChinese       ;default
    mov pc,r0
.pool