.func PrintMonDexNumAndNameChinese
    add r5,r4,0
    mov r4,0xF
    strb r4,[r5,1]
    mov r4,3
    strb r4,[r5,2]
    mov r4,r8
    lsl r4,r4,0x1B
    lsr r4,r4,0x18

CheckIfIsName:
    cmp r4,0xB0             ;图鉴编号为0x12 * 8，宝可梦名为0x16 * 8
    bne BackToOrigin
    sub r4,4                ;宝可梦名时 0x16 * 8 - 4

BackToOrigin:
    push r4
    ldr r4,=PrintMonDexNumAndName + 0x2C    ;0x08BCE58
    mov r8,r4
    pop r4
    mov pc,r8
.pool
.endfunc

/*
原函数
static void PrintMonDexNumAndName(u8 windowId, u8 fontId, const u8* str, u8 left, u8 top)
{
    u8 color[3];

    color[0] = TEXT_COLOR_TRANSPARENT;  //=0x0
    color[1] = TEXT_DYNAMIC_COLOR_6;    //=0xF
    color[2] = TEXT_COLOR_LIGHT_GRAY;   //=0x3
    AddTextPrinterParameterized4(windowId, fontId, left * 8, (top * 8) + 1, 0, 0, color, TEXT_SKIP_DRAW, str);
}
 */