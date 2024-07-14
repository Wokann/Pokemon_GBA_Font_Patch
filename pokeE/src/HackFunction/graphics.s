.include "./include/graphics.h"

;(新字库总大小为0x2CA3C)
.align 0x4
PokePunctuationChsNormal:
    .incbin "./graphics/fonts/gba_chs_punctuation_11x11.bin"
PokeFontChsNormal:
    .incbin "./graphics/fonts/gba_chs_font_11x11.bin"
.align 0x4
PokePunctuationChsSmall:
    .incbin "./graphics/fonts/gba_chs_punctuation_9x9.bin"
PokeFontChsSmall:
    .incbin "./graphics/fonts/gba_chs_font_9x9.bin"
