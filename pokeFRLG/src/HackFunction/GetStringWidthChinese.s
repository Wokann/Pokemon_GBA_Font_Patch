.func GetStringWidthChinese
@@IfIsJapanese:
    mov r0,r9
    cmp r0,1
    beq @@GetOriginWidth
@@IfIsBraille:
    ldr r0,[sp,0];mov r0,r11
    cmp r0,FONT_BRAILLE
    beq @@GetOriginWidth
@@IfIsChinesePunctuation:
    mov r0,r1
    cmp r0,0x36
    blt @@IfisChineseChar
    cmp r0,0x3E
    bgt @@GetOriginWidth
    b @@GetChineseWidth
@@IfisChineseChar:
    cmp r0,0x1
    blt @@GetOriginWidth
    cmp r0,0x1E
    bgt @@GetOriginWidth
    cmp r0,0x6
    beq @@GetOriginWidth
    cmp r0,0x1B
    beq @@GetOriginWidth
    ldrb r0,[r4,1]
    cmp r0,0xF7
    bge @@GetOriginWidth
    add r4,1
    b @@GetChineseWidth

@@GetOriginWidth:
    mov r0,r1
    mov r1,r9
    bl GoToR8
    b @@AfterGetWidth

@@GetChineseWidth:
    ldr r0,[sp,0];mov r0,r11
    lsl r0,r0,0x1C
    lsr r0,r0,0x1C
    cmp r0,FONT_SMALL_SHADOWED
    beq @@GetChsSmallWidth
@@GetChsNormalWidth:
    mov r0,0xC
    b @@AfterGetWidth
@@GetChsSmallWidth:
    mov r0,0xA

@@AfterGetWidth:
    push r0
    ldr r0,=GetStringWidth + 0x214               ;0x080060e8
    mov lr,r0
    pop r0
    mov pc,lr
.pool
.endfunc

.func GoToR8
    bx r8
.endfunc
