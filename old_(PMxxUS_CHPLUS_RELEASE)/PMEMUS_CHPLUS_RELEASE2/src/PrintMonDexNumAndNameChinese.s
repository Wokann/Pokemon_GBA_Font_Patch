PrintMonDexNumAndNameChinese:
    cmp r3,0x16     ;left == 0x16
    beq continue

backtoorigin:
    mov r8,r3
    ldr r3,[sp,0x2c]
    bx lr

;Ifischinese1代码没有被任何指令调用，可被精简删去
Ifischinese1:
    ldrb r4,[r2,0x0]
    cmp r4,0x1
    blt backtoorigin
    cmp r4,0x1E
    bgt backtoorigin
    cmp r4,0x6
    beq backtoorigin + 4;bx lr
    cmp r4,0x1B
    beq backtoorigin

continue:
    mov r8,r3
    ldr r3,[sp,0x2c]
    lsl r0,r0,0x18
    lsr r0,r0,0x18
    lsl r1,r1,0x18
    lsr r1,r1,0x18
    lsl r3,r3,0x18
    add r4,sp,0x14
    mov r6,0x0
    strb r6,[r4,0x0]
    mov r5,r4
    mov r4,0xF
    strb r4,[r5,0x1]
    mov r4,0x3
    strb r4,[r5,0x2]
    mov r4,r8
    lsl r4,r4,0x1B
    lsr r4,r4,0x18
    mov r8,r4
    lsr r3,r3,0x15
    add r3,0x1
    lsl r3,r3,0x18
    lsr r3,r3,0x18
    str r6,[sp,0x0]
    str r6,[sp,0x4]
    str r5,[sp,0x8]
    mov r4,0x1
    neg r4,r4
    str r4,[sp,0xC]
    str r2,[sp,0x10]
    mov r2,r8
    sub r2,0x4  ;用于图鉴界面宝可梦名左移4像素，其余函数同原函数
    bl AddTextPrinterParameterized4
    add sp,0x18
    pop r3
    mov r8,r3
    pop r4-r6
    pop r0
    bx r0

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