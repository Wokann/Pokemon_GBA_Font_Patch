;用于含汉字的句子宽度计算
.org GetStringWidth + 0x100                         ;0x08004ccc
    push lr
    bl GetStringWidthChinese
    pop r0
    mov r14,r0
    b GetStringWidth + 0x112