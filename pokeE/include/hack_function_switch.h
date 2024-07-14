.ifndef HACK_FUNCTION_SWITCH_H
.definelabel HACK_FUNCTION_SWITCH_H,0

//该指令用于控制切换是否启用seed随机数修复hack
//以下为切换选项（不修复、火叶风格修复、红蓝宝石风格修复）
.definelabel SeedRNGFix_CLOSE,  0
.definelabel SeedRNGFix_RS,     1
.definelabel SeedRNGFix_FRLG,   2
//默认不开启修复，请在下一行更改选项类型来切换
.definelabel SeedRNGFix_OPTION, SeedRNGFix_CLOSE

.endif //HACK_FUNCTION_SWITCH_H