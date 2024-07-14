.include "./include/text.h"

;用于输出汉字显示
.org RenderText + 0xC4                  ;0x08005878
    ldr r0,=RenderTextChinese
    mov pc,r0
.pool

;用于计算含汉字的句子宽度
.org GetStringWidth + 0xA               ;0x08005ee2
    ;sub sp,8 从此处跳转，因为需要对栈空间进行修改
    ldr r4,=GetStringWidthPrepare
    mov pc,r4
.pool

.org GetStringWidth + 0x220             ;0x080060F8
    ;从default case的位置进行跳转 
    ;glyphWidth = func(*str, isJapanese);
    ldr r0,=GetStringWidthChinese
    mov pc,r0
.pool

.org GetStringWidth + 0x256             ;0x0800612E
    add sp,0xC

