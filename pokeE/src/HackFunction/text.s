.include "./include/text.h"
.include "./include/graphics.h"
.include "./include/gba/defines.h"
.include "./include/constants/global.h"

//RenderTextChinese;
//ChineseCodeCheck(currChar,textPrinter,fontid);
//DecompressGlyph_Chinese(currChar,fontid,gCurGlyph);
//Convert1bppTo2bpp(GlyphAddress,CharOffset,width,LineOffset);
//GetStringWidthPrepare;
//GetStringWidthChinese;


.func RenderTextChinese
    ;原函数内容
    ldr r0,[r6,0x0]                         ;r6为textPrinter，r3为currChar
    ldrb r3,[r0,0x0]                        ;currChar = *textPrinter->printerTemplate.currentChar;
    add r0,0x1                              ;字符编码地址移至下一字节
    str r0,[r6,0x0]                         ;textPrinter->printerTemplate.currentChar++;

    ;检查是否要进入中文程序
    push r2-r6
    ldrb r1,[r0,0x0]                         ;r1为currChar++，下一字节编码
    mov r0,r3                                ;r0为currChar，当前字符编码
    ldrb r2,[r4,0]                           ;r2为substruct->fontid
    mov r3,r6
    add r3,0x21                              ;textPrinter->japanese
    ldrb r3,[r3,0]                           ;r3为isJapanese
    bl ChineseCodeCheck
    cmp r1,TRUE
    beq @@CheckSuccess

    ;检查不通过，返回原程序
 @@CheckFailure:
    pop r2-r6
    mov r0,r3                               ;原函数内容
    sub r0,0xF8                             ;用于检测是否属于0xF8-0xFF控制符区间(0xF7也为控制符，在别处有检测)
    push r0
    ldr r0,=(RenderText + 0xD0)             ;0x08005884
    mov lr,r0
    pop r0
    mov pc,lr
    .pool

    ;检查通过，进入中文程序后，再返回原程序后续内容
 @@CheckSuccess:
    ;r0为currChar，中文符号或中文汉字编码
    cmp r0,0x3E
    ble @@DoNotJumpChineseDoubleChar
 @@JumpChineseDoubleChar:                   ;中文汉字时按双字节计，中文符号仍按单字节计
    push r0
    ldr r0,[r6,0x0]                         ;r6为textPrinter
    add r0,0x1                              ;字符编码地址移至下一字节
    str r0,[r6,0x0]                         ;textPrinter->printerTemplate.currentChar++;
    pop r0
 @@DoNotJumpChineseDoubleChar:
    mov r1,r2                               ;r1为fontid
    ldr r2,=gCurGlyph                       ;r2为03区字符字模、宽、高数据存储位置
    bl DecompressGlyph_Chinese
    pop r2-r6
    ldr r0,=(RenderText + 0x45C)            ;0x08005C10 ;CopyGlyphToWindow(textPrinter);
    mov pc,r0
    .pool
.endfunc

;中文编码检查
;输入为 r0为currChar,r1为currChar++,r2为fontid,r3为isJapanese
;输出为 r0原字符编码或中文符号或中文汉字编码,r1(0检查不通过,1检查通过),r2为fontid,r3为isJapanese
.func ChineseCodeCheck  
    push lr

    ;检查是否是日文文本
 @@IfIsJapanese:
    cmp r3,TRUE                             ;bool32 isJapanese == TRUE
    beq @@NotChinese

    ;检查是否是盲文文本
 @@IfIsBraille:
    cmp r2,FONT_BRAILLE
    beq @@NotChinese

    ;检查是否是中文符号(0x36~0x3E)
 @@IfIsChinesePunctuation:
    cmp r0,0x36
    blt @@IfisChineseChar
    cmp r0,0x3E
    bgt @@NotChinese
    b @@HasChineseCode

    ;检查是否是中文汉字(hi:0x01~0x05,0x07~0x1A,0x1C~0x1E)(lo:0x00~0xF6)
 @@IfisChineseChar:
    cmp r0,0x1
    blt @@NotChinese
    cmp r0,0x1E
    bgt @@NotChinese
    cmp r0,0x6
    beq @@NotChinese
    cmp r0,0x1B
    beq @@NotChinese                         ;检查高位是否满足要求
    cmp r1,0xF7                              ;检查低位是否满足要求
    bge @@NotChinese
    lsl r0,r0,8                              ;高位左移并合并低位
    add r0,r0,r1                             ;r0记录中文汉字双字节编码

    ;中文检查通过
 @@HasChineseCode:
    mov r1,TRUE                              ;r1为是否通过中文检查      
    b @@Return
    ;中文检查不通过
 @@NotChinese:
    mov r1,FALSE                             ;r1为是否通过中文检查
 @@Return:
    pop lr
.endfunc

;输入为 r0为currChar中文符号或中文汉字编码 ,r1为fontid, r2为gCurGlyph
.func DecompressGlyph_Chinese
    push r4-r6,lr
    mov r4,r0
    mov r6,r2

    ;根据fontid确定大小字库（火叶绿不完全一致），并存入宽高数据
    mov r0,r1                          ;r0为fontid
    bl GetChineseFontWidthFunc         ;返回r0为glyphwidth，r1为大小字库标识
    mov r2,r0                          ;r2为glyphwidth
    mov r5,0x80
    add r5,r6
    strb r2,[r5,0]                     ;gCurGlyph.width = 12/10;宽12/10
    add r2,3
    add r5,1
    strb r2,[r5,0]                     ;gCurGlyph.height = 15/13;高15/13

    ;根据编码确定字模索引编号
 @@GetGlyphId:
    mov r0,r4
    cmp r0,0x3E
    bgt @@CaluChineseChar
 @@CaluChinesePunctuation:                  ;0x36-0x3E→0x0-0x8(9个中文符号“；。—~、，！？：”)
    mov r2,0x36
    sub r2,r0,r2                            ;r2=glyphId索引编号
    mov r3,0                                ;r3为符号或汉字标识，0为符号，1为汉字
    b @@SelectGlyph
 @@CaluChineseChar:
    lsr r3,r0,0x8                           ;获取中文汉字编码高位
    lsl r2,r4,0x18
    lsr r2,r2,0x18                          ;获取中文汉字编码低位
    cmp r3,0x6
    blt @@SubChs_1h_5h
    cmp r3,0x1b
    blt @@SubChs_7h_1Ah
 @@SubChs_1Ch_1Eh:
    sub r3,0x1
 @@SubChs_7h_1Ah:
    sub r3,0x1
 @@SubChs_1h_5h:
    sub r3,0x1
 @@CombineChsCharGlyphId:                   ;此转化算法适用于连续不间隔字库，不适用于增益版带间隔字库
    mov r0,0xF7
    mul r3,r0
    add r2,r2,r3                            ;r2=glyphId=(hi*0xF7)+lo索引编号
    mov r3,1                                ;r3为符号或汉字标识，0为符号，1为汉字

    ;根据大小字库标识及符号汉字标识，选择对应的字库，并计算索引偏移地址
 @@SelectGlyph:
    cmp r1,0
    beq @@SelectBigGlyph
    b @@SelectSmallGlpyh
  @@SelectBigGlyph:
    mov r0,0x10
    mul r2,r0                               ;大字库单字大小0x10
    mov r0,11
    mov r1,1
    cmp r3,0
    beq @@BigGlyphPunctuation
    b @@BigGlyphChar
  @@SelectSmallGlpyh:
    mov r0,0xB
    mul r2,r0                               ;小字库单字大小0xB
    mov r0,9
    mov r1,2
    cmp r3,0
    beq @@SmallGlyphPunctuation
    b @@SmallGlyphChar
 @@BigGlyphPunctuation:
    ldr r5,=PokePunctuationChsNormal
    b @@GetGlyphAddress
 @@SmallGlyphPunctuation:
    ldr r5,=PokePunctuationChsSmall
    b @@GetGlyphAddress
 @@BigGlyphChar:
    ldr r5,=PokeFontChsNormal
    b @@GetGlyphAddress
 @@SmallGlyphChar:
    ldr r5,=PokeFontChsSmall
 @@GetGlyphAddress:
    ;add r0,r5,r2                            ;offset = glyph + glpyhId * sizeOfSinglefont
    mov r3,r1
    mov r1,r2
    mov r2,r0
    mov r0,r5
    bl Convert1bppTo2bpp
    mov r5,r0
 @@t1:
    mov r0,r5
    mov r1,r6
    ldr r3,=(DecompressGlyphTile|1)
    bl @@call_r3
 @@t2:
    add r5,0x10
    add r6,0x20
    mov r0,r5
    mov r1,r6
    ldr r3,=(DecompressGlyphTile|1)
    bl @@call_r3
 @@t3:
    add r5,0x10
    add r6,0x20
    mov r0,r5
    mov r1,r6
    ldr r3,=(DecompressGlyphTile|1)
    bl @@call_r3
 @@t4:
    add r5,0x10
    add r6,0x20
    mov r0,r5
    mov r1,r6
    ldr r3,=(DecompressGlyphTile|1)
    bl @@call_r3
 @@End:
    pop r4-r6
    pop lr
 @@call_r3:
    bx r3
    .pool
.endfunc

.func Convert1bppTo2bpp
    ;r0 = GlyphAdd, r1 = CharOffset, r2 = width, r3 = LineOffset
 @@Init:
    push r2-r7
    mov r7,r2           ;初始r2存入r7            ;初始r2已无用
    add r6,r0,r1        ;r6=AddOfFontGlyph      ;初始r0,r1已无用
    ldr r5,=0x0203FF40  ;r5=StoreFont16x161bpp

 @@InitCleanTile:
    mov r0,0
    mov r2,0
 @@LoopInitClean:
    str r0,[r5,r2]
    add r2,4
    cmp r2,0xC0
    blt @@LoopInitClean   ;清理0x0203FF40-0x0203FFFF空间共3个0x40的块

 @@Convert11x111bppTo16x161bpp:
 @@DrawEmptyLine:
    mov r0,0
 @@LoopEmptyLine:
    cmp r0,r3
    bge @@DrawGlyphTile   ;初始r3已无用
    add r5,r5,2
    add r0,r0,1
    b @@LoopEmptyLine     ;根据给定的初始行偏移位置进行定位
 @@DrawGlyphTile:
    mov r2,0            ;初始积累宽度
    mov r4,0            ;初始残留数，用于与后续字节合并，从中取出对应宽度的字节
    mov r3,0            ;循环计数
 @@LoopDrawGlyphTile:
 @@SubLoopAddByte:
    lsl r4,r4,8
    ldrb r0,[r6,0]      ;r6=AddOfFontGlyph
    add r6,r6,1
    orr r4,r0
    mov r0,r4
    add r2,8
    cmp r2,r7           ;检查积累宽度是否足够，若不满足字符宽度，则继续读取下一字节
    blt @@SubLoopAddByte
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
    blt @@LoopDrawGlyphTile       ;r0-r7已无用
    b @@Convert16x161bppTo16x162bpp

 @@Convert16x161bppTo16x162bpp:
    ldr r7,=0x0203FF40  ;r7=StoreFont16x161bpp
    ldr r6,=0x0203FF80  ;r6=StoreFont16x162bpp
    mov r5,0
 @@Loop16x162bpp:
    mov r4,8*2-1        ;用于1bpp16位定位
    mov r3,8*4          ;用于2bpp32位定位
    mov r2,0            ;用于主字体暂存
    mov r1,0            ;用于阴影暂存
 @@SubLoop16x162bppLinePiexl:
    sub r3,r3,1
    ldrh r0,[r7,0]      ;r7=StoreFont16x161bpp Line n
    push r1
    mov r1,1
    lsl r1,r4           
    and r0,r1           ;从高至低取位1bpp
    lsr r0,r4
    pop r1
    cmp r0,0
    beq @@SkipDraw
 @@TempStoreMainAndNextLineShadow:
    lsl r0,r3           ;左移r3 置于32位2bpp处
    orr r1,r0           ;暂存下阴影
    lsr r0,r0,2         ;右移2
    orr r1,r0           ;暂存右下阴影
    lsl r0,r0,1         ;左移1
    orr r2,r0           ;暂存主字体
 @@IfMainAndShadowOverlap:
    push r1,r2
    mov r2,1
    lsl r2,r3
    ldr r1,[r6,0]       ;r6=StoreFont16x162bpp Line n
    and r1,r2
    cmp r1,0            ;检查是否有阴影
    beq @@NotOverlap
 @@Overlap:
    ldr r1,[r6,0]       ;r6=StoreFont16x162bpp Line n
    eor r1,r2
    str r1,[r6,0]       ;与主字体重叠，去除阴影
 @@NotOverlap:
    pop r1,r2
 @@SkipDraw:
    sub r4,r4,1
    sub r3,r3,1
    cmp r3,2
    bge @@SubLoop16x162bppLinePiexl
 @@StoreLine:
    str r1,[r6,4]       ;存入下一行阴影
    ldr r1,[r6,0]
    orr r2,r1           ;合并本行主字体和阴影
    str r2,[r6,0]       ;存入本行主字体和阴影
    add r5,r5,1
    add r6,r6,4
    add r7,r7,2
    cmp r5,16
    blt @@Loop16x162bpp
    b @@Cut16x16Tile

 @@Cut16x16Tile:
    ldr r4,=0x0203FF80  ;r4=StoreFont16x162bpp
    ldr r5,=0x0203FFC0  ;r5=StoreFont16x162bppCut
    mov r1,0
 @@LoopCut:
    mov r2,0
 @@SubLoopCutHalf:
    ldrh r0,[r4,2]
    strh r0,[r5,0]
    ldrh r0,[r4,0]
    strh r0,[r5,0x10]
    add r4,r4,4
    add r5,r5,2
    add r2,r2,1
    cmp r2,8
    blt @@SubLoopCutHalf
    add r5,0x10
    add r1,1
    cmp r1,2
    blt @@LoopCut

 @@BackToDrawTile:
    ldr r0,=0x0203FFC0
    mov r1,0
    pop r2-r7
    bx lr
    .pool
.endfunc

;含中文字符时句子宽度计算
.func GetStringWidthPrepare
 @@StoreFontId:
    ;在原函数sub sp,8基础上，再多加4字节,用于存储fontid。因其后续fontid会被清除。
    sub sp,0xC
    mov r4,r1
    lsl r0,r0,0x18
    lsr r0,r0,0x18
    mov r6,r0
    ;将fontid存入sp多出来的4字节处
    str r0,[sp,0x8]
    ;fontid存储完成，返回原函数
    ldr r0,=(GetStringWidth + 0x14)             ;0x08005eec
    mov pc,r0
    .pool
.endfunc

.func GetStringWidthChinese
    ;检查是否要进入中文程序
    push r1-r3
    push r5-r7
    mov r0,r1                          ;r0为*str，当前字符编码
    add r1,r4,1
    ldrb r1,[r1,0]                     ;r1为++*str，下一字节编码
    ldr r2,[sp,(8+6*4)]                ;r2为fonid
    mov r3,r9                          ;r3为isJapanese
    bl ChineseCodeCheck
    cmp r1,TRUE
    beq @@CheckSuccess

    ;检查不通过，返回原程序
 @@CheckFailure:
    pop r5-r7
    pop r1-r3
    mov r0,r1                          ;r0为*str
    mov r1,r9                          ;r1为isJapanese
    bl @@call_r8                       ;返回r0为glyphwidth
    b @@Return
 @@call_r8:
    bx r8

 @@CheckSuccess:
    cmp r0,0x3E                        ;r0为currChar，中文符号或中文汉字编码
    ble @@DoNotJumpChineseDoubleChar
 @@JumpChineseDoubleChar:              ;中文汉字时按双字节计，中文符号仍按单字节计
    add r4,1                           ;str++，跳过中文双字节编码低位
 @@DoNotJumpChineseDoubleChar:
    mov r0,r2                          ;r0为fontid
    bl GetChineseFontWidthFunc         ;返回r0为glyphwidth
    pop r5-r7
    pop r1-r3

 @@Return:
    cmp r7,0
    push r0
    ldr r0,=(GetStringWidth + 0x22A)   ;0x08006102
    mov lr,r0
    pop r0
    mov pc,lr
    .pool
.endfunc

;输入r0为fontid
;输出r0为glyphwidth,r1为大小字库标识
;大小字库顺序，火叶绿并不完全一致，不可直接套用
.func GetChineseFontWidthFunc
    push lr
    cmp r0,FONT_SMALL
    beq @@GetChsSmallWidth
    cmp r0,FONT_SMALL_NARROW
    beq @@GetChsSmallWidth
 @@GetChsNormalWidth:
    mov r0,0xC          ;宽度为12
    mov r1,0            ;大字库
    b @@Return
 @@GetChsSmallWidth:
    mov r0,0xA          ;宽度为10
    mov r1,1            ;小字库
 @@Return:
    pop lr
.endfunc