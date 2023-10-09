UpdateLeftNoOfBallsTextOnHealthboxChinese:
    push r0-r2,lr
    asr r0, r0, 3
    lsl r1, r0, 3
    sub r1, r4, r1
    add r1, 0x10
    add r1, r2, r1
    lsl r0, r0, 6
    add r1, r1, r0
    lsl r1, r1, 5
    ldr r0, =0x06010000
    add r1, r1, r0
    add r0, r7, 0
    ldr r2, =0x04000008
    bl CpuSet
    add r7, 0x20

    pop r0-r2
    asr r0, r0, 3
    lsl r1, r0, 3
    sub r1, r4, r1
    add r1, 0x18
    add r1, r2, r1
    lsl r0, r0, 6
    add r1, r1, r0
    lsl r1, r1, 5
    ldr r0, =0x06010000
    add r1, r1, r0
    add r0, r7, 0
    ldr r2, =0x04000008
    bl CpuSet
    add r7, 0x20

    pop r0
    bx r0
.pool


/*
原函数
UpdateLeftNoOfBallsTextOnHealthbox:
    push {r4, r5, r6, r7, lr}
    mov r7, r8
    push {r7}
    adds r4, r0, 0
    lsls r4, r4, 0x18
    lsrs r4, r4, 0x18
    ldr r0, =0x020238cc
    mov r8, r0
    ldr r1, =BattleText_SafariBallsLeft
    bl StringCopy

    adds r7, r0, 0
    ldr r0, =0x02038808
    ldrb r1, [r0]
    adds r0, r7, 0
    movs r2, 0xa
    movs r3, 1
    bl sub_8003504

    adds r7, r0, 0
    ldr r1, =BattleText_HighlightRed
    bl StringAppend

    ldr r0, =0x02020004
    lsls r5, r4, 4
    adds r5, r5, r4
    lsls r5, r5, 2
    adds r5, r5, r0
    ldrh r0, [r5, 0x3a]
    lsls r0, r0, 0x18
    lsrs r0, r0, 0x18
    bl GetBattlerPosition

    lsls r0, r0, 0x18
    lsrs r0, r0, 0x18
    lsls r4, r0, 1
    adds r4, r4, r0
    lsls r4, r4, 7
    ldr r0, =0x02000520
    adds r7, r4, r0

    movs r6, 5

    adds r0, r7, 0
    mov r1, r8
    bl sub_80034D4

    ldr r0, =0x02000540
    adds r7, r4, r0

    movs r4, 6

loop:
    ldrh r0, [r5, 4]
    lsls r0, r0, 0x16
    lsrs r2, r0, 0x16
    adds r0, r4, 0
    cmp r4, 0
    bge loopadd
    adds r0, r4, 7

loopadd:
    asrs r0, r0, 3
    lsls r1, r0, 3
    subs r1, r4, r1
    adds r1, 0x18
    adds r1, r2, r1
    lsls r0, r0, 6
    adds r1, r1, r0
    lsls r1, r1, 5
    ldr r0, =0x06010000
    adds r1, r1, r0
    adds r0, r7, 0
    ldr r2, =0x04000008
    bl CpuSet

    adds r7, 0x40
    adds r4, 1
    adds r0, r6, 6
    cmp r4, r0
    blt loop

end2:
    pop r3
    mov r8, r3
    pop r4-r7
    pop r0
    bx r0
.pool
 */




/*
void UpdateLeftNoOfBallsTextOnHealthbox(u8 a)
{
    u8 *r7;
    u8 status;
    s32 r6;
    s32 i;

    r7 = StringCopy(gDisplayedStringBattle, BattleText_SafariBallsLeft);//狩猎地带  剩余：
    r7 = sub_8003504(r7, gNumSafariBalls, 10, 1);
    StringAppend(r7, BattleText_HighlightRed);
    status = GetBattlerPosition(gSprites[a].data[6]);
    r7 = &eBattleInterfaceGfxBuffer[0x520 + status * 0x180];
    r6 = 5;//图块长度
    TextPrintBattleInterfaceAndContestLink(r7, gDisplayedStringBattle);
    r7 = &eBattleInterfaceGfxBuffer[0x520 + status * 0x180];
    for (i = 6; i < 6 + r6; i++)//图块横坐标起点
    {
        CpuCopy32(r7, OBJ_VRAM0 + (gSprites[a].oam.tileNum + 0x10 + MACRO1(i)) * 32, 32);//0x18->0x10
        r7 += 32;//64->32

        CpuCopy32(r7, OBJ_VRAM0 + (gSprites[a].oam.tileNum + 0x18 + MACRO1(i)) * 32, 32);//新增
        r7 += 32;//新增
    }

    //原函数
    //TextPrintBattleInterfaceAndContestLink(r7, gDisplayedStringBattle);
    //r7 = &eBattleInterfaceGfxBuffer[0x520 + status * 0x180 + 0x20];
    //for (i = 6; i < 6 + r6; i++)
    //{
    //    CpuCopy32(r7, OBJ_VRAM0 + (gSprites[a].oam.tileNum + 0x18 + MACRO1(i)) * 32, 32);
    //    r7 += 64;
    //}
}
*/