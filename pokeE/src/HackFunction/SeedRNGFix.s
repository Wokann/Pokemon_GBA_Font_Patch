.func SeedRNGFix
    bl SeedRngWithRtc
    ldr r0,=0x03002700
    mov r4,0
    strb r4,[r0,0]
    ldr r0,=0x03005D88
    ldr r1,=(AgbMain + 0x64)
    mov pc,r1
.pool
.endfunc

.func SeedRngWithRtc
    push lr
    ldr r1,=(RtcGetMinuteCount|1)
    bl call_bx1
    mov r2,r0
    lsr r0,r2,0x10
    ldr r1,=0xFFFF
    and r1,r2
    eor r0,r1
    ldr r1,=(SeedRng|1)
    bl call_bx1
    pop r1
call_bx1:
    bx r1
.pool
.endfunc