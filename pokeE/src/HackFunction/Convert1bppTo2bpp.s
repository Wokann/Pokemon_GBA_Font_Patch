.func Convert1bppTo2bpp
    ;r0 = GlyphAdd, r1 = CharOffset, r2 = width, r3 = LineOffset
Init:
    push r2-r7
    mov r7,r2           ;初始r2存入r7            ;初始r2已无用
    add r6,r0,r1        ;r6=AddOfFontGlyph      ;初始r0,r1已无用
    ldr r5,=0x0203FF40  ;r5=StoreFont16x161bpp

InitCleanTile:
    mov r0,0
    mov r2,0
LoopInitClean:
    str r0,[r5,r2]
    add r2,4
    cmp r2,0xC0
    blt LoopInitClean   ;清理0x0203FF40-0x0203FFFF空间共3个0x40的块

Convert11x111bppTo16x161bpp:
DrawEmptyLine:
    mov r0,0
LoopEmptyLine:
    cmp r0,r3
    bge DrawGlyphTile   ;初始r3已无用
    add r5,r5,2
    add r0,r0,1
    b LoopEmptyLine     ;根据给定的初始行偏移位置进行定位
DrawGlyphTile:
    mov r2,0            ;初始积累宽度
    mov r4,0            ;初始残留数，用于与后续字节合并，从中取出对应宽度的字节
    mov r3,0            ;循环计数
LoopDrawGlyphTile:
SubLoopAddByte:
    lsl r4,r4,8
    ldrb r0,[r6,0]      ;r6=AddOfFontGlyph
    add r6,r6,1
    orr r4,r0
    mov r0,r4
    add r2,8
    cmp r2,r7           ;检查积累宽度是否足够，若不满足字符宽度，则继续读取下一字节
    blt SubLoopAddByte
    sub r2,r2,r7        ;当前右移数（及残留数的宽度）
    lsr r0,r2
    mov r1,16
    sub r1,r1,r7
    lsl r0,r1           ;计算归位左移数
    strh r0,[r5,0]      ;r5=StoreFont16x161bpp Line n
    add r5,r5,2
    mov r1,1            
    lsl r1,r2
    sub r1,r1,1
    and r4,r1           ;得到残留数
    add r3,r3,1
    cmp r3,r7
    blt LoopDrawGlyphTile       ;r0-r7已无用
    b Convert16x161bppTo16x162bpp

Convert16x161bppTo16x162bpp:
    ldr r7,=0x0203FF40  ;r7=StoreFont16x161bpp
    ldr r6,=0x0203FF80  ;r6=StoreFont16x162bpp
    mov r5,0
Loop16x162bpp:
    mov r4,8*2-1        ;用于1bpp16位定位
    mov r3,8*4          ;用于2bpp32位定位
    mov r2,0            ;用于主字体暂存
    mov r1,0            ;用于阴影暂存
SubLoop16x162bppLinePiexl:
    sub r3,r3,1
    ldrh r0,[r7,0]      ;r7=StoreFont16x161bpp Line n
    push r1
    mov r1,1
    lsl r1,r4           
    and r0,r1           ;从高至低取位1bpp
    lsr r0,r4
    pop r1
    cmp r0,0
    beq SkipDraw
TempStoreMainAndNextLineShadow:
    lsl r0,r3           ;左移r3 置于32位2bpp处
    orr r1,r0           ;暂存下阴影
    lsr r0,r0,2         ;右移2
    orr r1,r0           ;暂存右下阴影
    lsl r0,r0,1         ;左移1
    orr r2,r0           ;暂存主字体
IfMainAndShadowOverlap:
    push r1,r2
    mov r2,1
    lsl r2,r3
    ldr r1,[r6,0]       ;r6=StoreFont16x162bpp Line n
    and r1,r2
    cmp r1,0            ;检查是否有阴影
    beq NotOverlap
Overlap:
    ldr r1,[r6,0]       ;r6=StoreFont16x162bpp Line n
    eor r1,r2
    str r1,[r6,0]       ;与主字体重叠，去除阴影
NotOverlap:
    pop r1,r2
SkipDraw:
    sub r4,r4,1
    sub r3,r3,1
    cmp r3,2
    bge SubLoop16x162bppLinePiexl
StoreLine:
    str r1,[r6,4]       ;存入下一行阴影
    ldr r1,[r6,0]
    orr r2,r1           ;合并本行主字体和阴影
    str r2,[r6,0]       ;存入本行主字体和阴影
    add r5,r5,1
    add r6,r6,4
    add r7,r7,2
    cmp r5,16
    blt Loop16x162bpp
    b Cut16x16Tile

Cut16x16Tile:
    ldr r4,=0x0203FF80  ;r4=StoreFont16x162bpp
    ldr r5,=0x0203FFC0  ;r5=StoreFont16x162bppCut
    mov r1,0
LoopCut:
    mov r2,0
SubLoopCutHalf:
    ldrh r0,[r4,2]
    strh r0,[r5,0]
    ldrh r0,[r4,0]
    strh r0,[r5,0x10]
    add r4,r4,4
    add r5,r5,2
    add r2,r2,1
    cmp r2,8
    blt SubLoopCutHalf
    add r5,0x10
    add r1,1
    cmp r1,2
    blt LoopCut

BackToDrawTile:
    ldr r0,=0x0203FFC0
    mov r1,0
    pop r2-r7
    bx lr
.pool
.endfunc
