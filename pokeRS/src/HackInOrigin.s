;用于汉字单字宽度计算
.org GetGlyphWidth + 2                              ;0x080048ea
    bl GetGlyphWidthChinese

;用于含汉字的句子宽度计算
.org GetStringWidth + 0x100                         ;0x08004ccc
    push lr
    bl GetStringWidthChinese
    pop r0
    mov r14,r0
    b GetStringWidth + 0x112

;用于输出汉字显示
.org DrawGlyphTiles + 2                             ;0x08006876
    bl DrawGlyphTilesChinese

;用于对战HP框，宝可梦名字的完整显示
.org UpdateNickInHealthbox + 0x1EA                  ;0x0804538A
    ldr r7,[pc,0xC8];=0x04000008
.skip 0x3C
.word 0x04000006                                    ;0x080453C8

;用于狩猎地带HP框，狩猎球名字的完整显示
.org UpdateSafariBallsTextInHealthbox + 0x46        ;0x080458F6
    bl UpdateSafariBallsTextInHealthboxChinese
.skip 0x92
.word BattleText_SafariBalls                        ;0x0804598C

;用于狩猎地带HP框，剩余球数的完整显示
.org UpdateLeftNoOfBallsTextOnHealthbox + 0x5A      ;0x080459F2
    ldr r0, [pc,0x58];0x02000520
.skip 0x12
    push lr                                         ;0x08045A06
    bl UpdateLeftNoOfBallsTextOnHealthboxChinese
    pop r0
    mov r14,r0
    b UpdateLeftNoOfBallsTextOnHealthbox + 0x8C     ;=0x08045A24
.skip 0x2A
.word BattleText_SafariBallsLeft + 1                ;0x08045A3C
.skip 0x4
.word BattleText_HighlightRed                       ;0x08045A44

;用于宝可梦寄放系统内右侧的标记图形显示位置
.org sub_8097F58 + 0x2E                             ;0x08097F86
    mov r0,0x9C
    
;用于宝可梦寄放系统内右侧的持有物文本显示位置
.org PrintDisplayMonInfo + 0x11A                    ;0x0809830A
    mov r3,0x12
.skip 0xA
    mov r2,0x11                                     ;0x08098316



/*
void UpdateNickInHealthbox(u8 healthboxSpriteId, struct Pokemon *pkmn)
{
    u8 nickname[POKEMON_NAME_LENGTH];
    u8 gender;
    u16 species;
    u8 language;
    u8 *ptr;
    s32 i;
    s32 _7;
    u8 *const *r1;

    StringCopy(gDisplayedStringBattle, gEmptyText_RedHighlight);
    GetMonData(pkmn, MON_DATA_NICKNAME, nickname);
    StringGetEnd10(nickname);
    ptr = StringCopy(gDisplayedStringBattle + 3, nickname);
    ptr[0] = EXT_CTRL_CODE_BEGIN;
    ptr[1] = EXT_CTRL_CODE_SHADOW;
    ptr[2] = 2;
    ptr[3] = EXT_CTRL_CODE_BEGIN;
    ptr[4] = EXT_CTRL_CODE_COLOR;
    ptr += 5;
    gender = GetMonGender(pkmn);
    species = GetMonData(pkmn, MON_DATA_SPECIES);
    language = GetMonData(pkmn, MON_DATA_LANGUAGE);
    if (ShouldHideGenderIconForLanguage(species, nickname, language))
        gender = 100;
    switch (gender)
    {
    default:
        ptr[0] = 0xB;
        ptr[1] = EOS;
        ptr += 1;
        break;
    case MON_MALE:
        ptr[0] = 0xB;
        ptr[1] = CHAR_MALE;
        ptr[2] = EOS;
        ptr += 2;
        break;
    case MON_FEMALE:
        ptr[0] = 0xA;
        ptr[1] = CHAR_FEMALE;
        ptr[2] = EOS;
        ptr += 2;
        break;
    }
    ptr[0] = EXT_CTRL_CODE_BEGIN;
    ptr[1] = EXT_CTRL_CODE_CLEAR_TO;
    ptr[2] = 0x37;
    ptr[3] = EOS;
    ptr = &eBattleInterfaceGfxBuffer[0x520 + GetBattlerPosition(gSprites[healthboxSpriteId].data[6]) * 0x180 ];
    TextPrintBattleInterfaceAndContestLink(ptr, gDisplayedStringBattle);//对战界面宝可梦名

    i = 0;
    _7 = 7;
    if (GetMonData(pkmn, MON_DATA_LANGUAGE) == 1
     && GetMonData(pkmn, MON_DATA_IS_EGG) == 0)
    {
        u8 *p = gDisplayedStringBattle;

        while (*p != EOS)
        {
            if (*p == EXT_CTRL_CODE_BEGIN)
            {
                p += GetExtCtrlCodeLength(p[1]) + 1;
            }
            else
            {
                u8 r0;

                if ((*p >= 0x37 && *p <= 0x4A) || (*p >= 0x87 && *p <= 0x9A))
                    r0 = 0x2C;
                else if ((*p >= 0x4B && *p <= 0x4F) || (*p >= 0x9B && *p <= 0x9F))
                    r0 = 0x2D;
                else
                    r0 = 0x2B;

                CpuCopy32(GetHealthboxElementGfxPtr(r0), ptr + 0x40 * i, 32);
                //32->20 此处为调用misc中间几块的部分，用于日文假名及遮罩，不改也可以，但由于与下一处共用0x04000008，所以会同步变更。增益版为改成24。
                i++;
                p++;
            }
        }
    }


    for (; i < _7; i++)
        CpuCopy32(GetHealthboxElementGfxPtr(0x2B), ptr + 0x40 * i, 20);
        //原函数
        //CpuCopy32(GetHealthboxElementGfxPtr(0x2B), ptr + 0x40 * i, 32);
        //32->20 此处为调用misc中间几块的部分，用于日文假名及遮罩，此处32会遮罩掉10px汉字字体上半部分，必须修改。增益版为改成24。

    if (GetBattlerSide(gSprites[healthboxSpriteId].data[6]) == 0 && !IsDoubleBattle())
    {
        r1 = (u8 *const *)gUnknown_0820A8B4;
        for (i = 0; i < _7; i++)
        {
            u8 *r4 = r1[i];

            r4 += gSprites[healthboxSpriteId].oam.tileNum * 32;
            CpuCopy32(ptr, r4, 32);
            ptr += 32;

            r4 += 0x100;
            CpuCopy32(ptr, r4, 32);
            ptr += 32;
        }
    }
    else
    {
        if (GetBattlerSide(gSprites[healthboxSpriteId].data[6]) == 0)
            r1 = (u8 *const *)gUnknown_0820A904;
        else
            r1 = (u8 *const *)gUnknown_0820A8DC;
        for (i = 0; i < _7; i++)
        {
            u8 *r4 = r1[i];

            r4 += gSprites[healthboxSpriteId].oam.tileNum * 32;
            CpuCopy32(ptr, r4, 32);
            ptr += 32;

            r4 += 0x100;
            CpuCopy32(ptr, r4, 32);
            ptr += 32;
        }
    }
}
*/
