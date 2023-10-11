RenderTextChinese:
    ldr r0,[r6,0]
    ldrb r3,[r0,0]
    add r0,1
    str r0,[r6,0]
    mov r0,r3

Ifischinese:
    cmp r0,0x1e
    bgt backtoorigin
    cmp r0,0
    beq backtoorigin
    cmp r0,6
    beq backtoorigin
    b calc_1Bh

backtoorigin:
    sub r0,0xF8                     ;0xF8-0xFE
    cmp r0,7                        ;0x0-0x6
    bls go_switch_currchar          ;goto switch (currChar)
    b go_switch_subStruct_glyphId   ;goto switch (subStruct->glyphId)

go_switch_currchar:
    ldr r1,=(RenderText + 0xC2);=0x08005852
    mov pc,r1

go_switch_subStruct_glyphId:
    ldr r0,=(RenderText + 0x3DC);=0x08005B6C
    mov pc,r0

subChsGlyphid:
    cmp r0,6
    bgt subcmp_1Bh
    b subChs_1h_5h

subChs_7h_1Ah:
    sub r0,1

subChs_1h_5h:
    sub r0,1
    b getChsFontGlyph
.pool

getChsFontGlyph:
    lsl r1,r0,8
    ldr r0,[r6,0]
    ldrb r3,[r0,0]
    add r0,1
    str r0,[r6,0]
    add r1,r3,r1
    ldr r0,=(RenderText + 0x451);=0x08005BE1;用于DecompressGlyph后跳转到CopyGlyphToWindow
    mov lr,r0
    push r4-r7,lr
    lsl r1,r1,6     ;1汉字字模占0x40字节，glyphId*0x40，以锁定汉字偏移地址
    ldr r5,[r4,0]
    lsl r5,r5,0x1c
    lsr r5,r5,0x1c
    cmp r5,FONT_SMALL_SHADOWED  ;fontId
    beq getChsSmallFont

getChsNormalFont:
    mov r6,1        ;gGlyphInfo.width = sFontMaleLatinGlyphWidths[1] = 0xC;         
    ldr r0,[pc,0]   ;=PokeFRLGEFontChsNormal
    b jumptoDecompressGlyph
.word PokeFRLGEFontChsNormal

jumptoDecompressGlyph:
    ldr r4,=(DecompressGlyph_Male + 0xE8);0x080068d4
    mov pc,r4
.pool

getChsSmallFont:
    mov r6,2        ;gGlyphInfo.width = sFontMaleLatinGlyphWidths[2] = 0xC;
    ldr r0,=PokeFRLGEFontChsSmall
    b jumptoDecompressGlyph
.pool

;疑似为3500字增益版扩容至6763汉字后，后续补充的判定代码。故在代码末尾补充，而非原位按顺序继续判定。
calc_1Bh:
    cmp r0,0x1B
    beq backtoorigin
    b subChsGlyphid

subcmp_1Bh:
    cmp r0,0x1b
    bls subChs_7h_1Ah

subChs_1Ch_1Eh:
    sub r0,1
    b subChs_7h_1Ah


