.func GetStringWidthPrepare
StoreFontId:
    sub sp,0xC
    mov r4,r1
    lsl r0,r0,0x18
    lsr r0,r0,0x18
    mov r6,r0
    str r0,[sp,0x8]
    ldr r0,=GetStringWidth + 0x14               ;0x08005eec
    mov pc,r0
.pool
.endfunc

.func GetStringWidthChinese
@@IfIsJapanese:
    mov r0,r9
    cmp r0,1
    beq @@GetOriginWidth
@@IfIsBraille:
    ldr r0,[sp,0x8]
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
    b @@GetChineseWidth

@@GetOriginWidth:
    mov r0,r1
    mov r1,r9
    bl GoToR8
    b @@AfterGetWidth

@@GetChineseWidth:
    ldr r0,[sp,0x8]
    lsl r0,r0,0x1C
    lsr r0,r0,0x1C
    cmp r0,FONT_SMALL
    beq @@GetChsSmallWidth
    cmp r0,FONT_SMALL_NARROW
    beq @@GetChsSmallWidth
@@GetChsNormalWidth:
    mov r0,0xC
    b @@AddChinesechar
@@GetChsSmallWidth:
    mov r0,0xA
@@AddChinesechar:
    add r4,1
    b @@AfterGetWidth

@@AfterGetWidth:
    push r0
    ldr r0,=GetStringWidth + 0x228               ;0x08006100
    mov lr,r0
    pop r0
    mov pc,lr
.pool
.endfunc

.func GoToR8
    bx r8
.endfunc
