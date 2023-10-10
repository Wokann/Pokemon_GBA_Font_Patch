UpdateSafariBallsTextInHealthboxChinese:
    add r1,r6,r1
    ldr r2,=0x04000005
    bx lr
.pool

/*
void UpdateSafariBallsTextInHealthbox(u8 a)
{
    u8 *r6;
    u8 r8;
    u8 i;
    s32 r7;
    u8 *addr;

    r6 = &eBattleInterfaceGfxBuffer[0x520 + GetBattlerPosition(gSprites[a].data[6]) * 0x180];
    r8 = 4;//7->4,狩猎球3个字仅占4个tile,不然末尾会显示错误
    TextPrintBattleInterfaceAndContestLink(r6, BattleText_SafariBalls);
    //狩猎对战界面血条第一行：狩猎球
    for (i = 0; i < r8; i++)
        CpuCopy32(GetHealthboxElementGfxPtr(0x2B), r6 + i * 64, 20);
        //原函数
        //CpuCopy32(GetHealthboxElementGfxPtr(0x2B), r6 + i * 64, 32);
        //32->20 非常重要，此处为调用misc中间几块的部分，原32会遮罩掉10px字体上半部分
        //增益版未设置此处内容
    for (r7 = 3; r7 < 3 + r8; r7++)
    {
        addr = OBJ_VRAM0 + (gSprites[a].oam.tileNum + MACRO1(r7)) * 32;
        CpuCopy32(r6, addr, 32);
        r6 += 32;

        addr = OBJ_VRAM0 + (8 + gSprites[a].oam.tileNum + MACRO1(r7)) * 32;
        CpuCopy32(r6, addr, 32);
        r6 += 32;
    }
}
 */