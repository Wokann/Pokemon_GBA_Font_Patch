//// Compare operands
Equals equ 0x0
Not_Equal_To equ 0x1
Less_Than equ 0x2
Greater_Than equ 0x3
Has_One_Bit_Common equ 0x4

//banks
bank_target equ 0x0
bank_attacker equ 0x1
bank_partner_def equ 0x2
bank_scripting_active equ 10
bank_newstruct equ 15

//script locations
MOVE_FAILED equ 0x082D9F1A
MOVE_MISSED equ 0x082D8A5E
ENDTURN equ 0x82D8A4E
StatChanger equ 0x0202448E
HitMarker equ 0x2024280
MultiStringChooser equ 0x2024337
AnimDecider equ 0x202448C
MoveOutcome equ 0x202427C
OutcomeMissed equ 1
OutcomeNotaffected equ 8
OutcomeFailed equ 0x20
OutcomeSturdied equ 0x100
BankScriptingActive equ 0x0202448B

STAT_SELF_INFLICTED equ 0x40

// callasm defines
//////macros for callasms
.macro jumpifsubstituteaffects, jumpifsubstituteaffects_address
.byte 0x83
.halfword 26
.word jumpifsubstituteaffects_address
.endmacro

.macro jumpifcantconfuseandchangestats, jumpifcantconfuseandchangestats_address
.byte 0x83
.halfword 31
.word jumpifcantconfuseandchangestats_address
.endmacro

.macro jumpifonlyonepokemoninteam, jumpifonlyonepokemoninteam_address
.byte 0x83
.halfword 38
.word jumpifonlyonepokemoninteam_address
.endmacro

.macro weatherhpheal, weatherhphealbank
.byte 0x83
.halfword 40
.byte weatherhphealbank
.endmacro

.macro jumpifnoally, jumpifnoally_address
.byte 0x83
.halfword 59
.word jumpifnoally_address
.endmacro

.macro jumpifuserhasnoHP, jumpifuserhasnoHP_address
.byte 0x83
.halfword 91
.word jumpifuserhasnoHP_address
.endmacro

//JeremyZ
.macro jumpifuserheadblown, jumpifuserheadblown_address
.byte 0x83
.halfword 170
.word jumpifuserheadblown_address
.endmacro

//JeremyZ
.macro jumpifnostockpile, jumpifnostockpile_address
.byte 0x83
.halfword 172
.word jumpifnostockpile_address
.endmacro

////////////////////////////////// Macro

//// Delay
.macro DELAY_HALFSECOND
.byte 0x20
.endmacro

.macro DELAY_1SECOND
.byte 0x40
.endmacro

//// Super commands
.macro calculatedamage
.word 0x7060504
.endmacro

.macro jumpiftypenotaffected, jumpiftypenotaffected_address
.byte 5 //damage calc 
jumpifbyte 0x4, 0x202427C, 0x29, jumpiftypenotaffected_address
.endmacro

//// Index commands
.macro attackcanceler
.byte 0
.endmacro

.macro accuracycheck, accuracycheck_address, accuracycheck_parameter1
.byte 1
.word accuracycheck_address
.halfword accuracycheck_parameter1
.endmacro

.macro attackstring
.byte 2
.endmacro

.macro ppreduce
.byte 3
.endmacro

.macro critcalc
.byte 4
.endmacro


.macro cmd5
.byte 5
.endmacro

.macro damagecalc
.byte 5
.endmacro

.macro cmd6
.byte 6
.endmacro

.macro cmd7
.byte 7
.endmacro

.macro damageadjustment
.byte 7
.endmacro

.macro cmd8
.byte 8
.endmacro

.macro attackanimation
.byte 9
.endmacro

.macro waitanimation
.byte 0xA
.endmacro

.macro graphicalhpupdate, graphicalhpupdate_bank
.byte 0xB
.byte graphicalhpupdate_bank
.endmacro

.macro datahpupdate, datahpupdate_bank
.byte 0xC
.byte datahpupdate_bank
.endmacro

.macro critmessage
.byte 0xD
.endmacro

.macro effectiveness_sound
.byte 0xE
.endmacro

.macro resultmessage
.byte 0xF
.endmacro

.macro printstring, printstring_string
.byte 0x10
.halfword printstring_string
.endmacro

.macro printstring2, printstring2_string
.byte 0x11
.halfword printstring2_string
.endmacro

.macro waitmessage, waitmessage_delay
.byte 0x12
.halfword waitmessage_delay
.endmacro

.macro printfromtable, printfromtable_table
.byte 0x13
.word printfromtable_table
.endmacro

.macro printfromtable2, printfromtable2_table
.byte 0x14
.word printfromtable2_table
.endmacro

.macro seteffectwithchance
.byte 0x15
.endmacro

.macro seteffectprimary
.byte 0x16
.endmacro

.macro seteffectsecondary
.byte 0x17
.endmacro

.macro clearstatus, clearstatus_bank
.byte 0x18
.byte clearstatus_bank
.endmacro

.macro faintpokemon, faintpokemon_parameter1, faintpokemon_parameter2, faintpokemon_parameter3
.byte 0x19
.byte faintpokemon_parameter1
.byte faintpokemon_parameter2
.word faintpokemon_parameter3
.endmacro

.macro cmd1a, cmd1abank
.byte 0x1A
.byte cmd1abank
.endmacro

.macro cmd1b, cmd1b_bank
.byte 0x1B
.byte cmd1b_bank
.endmacro

.macro jumpifstatus, jumpifstatus_bank, jumpifstatus_status, jumpifstatus_address
.byte 0x1C
.byte jumpifstatus_bank
.word jumpifstatus_status
.word jumpifstatus_address
.endmacro

.macro jumpifsecondarystatus, jumpifsecondarytstatus_bank, jumpifsecondarytstatus_status, jumpifsecondarytstatus_address
.byte 0x1D
.byte jumpifsecondarytstatus_bank
.word jumpifsecondarytstatus_status
.word jumpifsecondarytstatus_address
.endmacro

.macro jumpifability, jumpifability_bank, jumpifability_ability, jumpifability_address
.byte 0x1E
.byte jumpifability_bank
.byte jumpifability_ability
.word jumpifability_address
.endmacro

.macro jumpifhalverset, jumpifhalverset_bank, jumpifhalverset_status, jumpifhalverset_address
.byte 0x1F
.byte jumpifhalverset_bank
.halfword jumpifhalverset_status
.word jumpifhalverset_address
.endmacro

.macro jumpifstat, jumpifstat_bank, jumpifstat_flag, jumpifstat_quantity, jumpifstat_statid, jumpifstat_address
.byte 0x20
.byte jumpifstat_bank
.byte jumpifstat_flag
.byte jumpifstat_quantity
.byte jumpifstat_statid
.word jumpifstat_address
.endmacro

.macro jumpifspecialstatus3, jumpifspecialstatusflag_bank, jumpifspecialstatusflag_word_to_and, jumpifspecialstatusflag_statut, jumpifspecialstatusflag_address
.byte 0x21
.byte jumpifspecialstatusflag_bank
.word jumpifspecialstatusflag_word_to_and
.byte jumpifspecialstatusflag_statut
.word jumpifspecialstatusflag_address
.endmacro

.macro jumpiftype, jumpiftype_bank, jumpiftype_type, jumpiftype_address
.byte 0x22
.byte jumpiftype_bank
.byte jumpiftype_type
.word jumpiftype_address
.endmacro

.macro giveexp, cmd23_side_or_bank
.byte 0x23
.byte cmd23_side_or_bank
.endmacro

.macro gotoandsomething, gotoandsomething_address
.byte 0x24
.word gotoandsomething_address
.endmacro

.macro cmd25
.byte 0x25
.endmacro

.macro cmd26, cmd26_param1
.byte 0x26
.byte cmd26_param1
.endmacro

.macro cmd27, cmd27_address
.byte 0x27
.word cmd27_address
.endmacro

.macro jumpifmultihitcontinues, jumpifmultihitcontinues_address
.byte 0x27
.word jumpifmultihitcontinues_address
.endmacro

.macro goto_cmd, goto_address
.byte 0x28
.word goto_address
.endmacro

.macro jumpifbyte, jumpifbyte_ifflag, jumpifbyte_checkaddr, jumpifbyte_compare, jumpifbyte_address
.byte 0x29
.byte jumpifbyte_ifflag
.word jumpifbyte_checkaddr
.byte jumpifbyte_compare
.word jumpifbyte_address
.endmacro

.macro jumpifhalfword, jumpifhalfword_ifflag, jumpifhalfword_checkaddr, jumpifhalfword_compare, jumpifhalfword_address
.byte 0x2A
.byte jumpifhalfword_ifflag
.word jumpifhalfword_checkaddr
.halfword jumpifhalfword_compare
.word jumpifhalfword_address
.endmacro

.macro jumpifword, jumpifword_ifflag, jumpifword_checkaddr, jumpifword_compare, jumpifword_address
.byte 0x2B
.byte jumpifword_ifflag
.word jumpifword_checkaddr
.word jumpifword_compare
.word jumpifword_address
.endmacro

.macro jumpifarrayequal, jumpifarrayequal_mem1, jumpifarrayequal_mem2, jumpifarrayequal_size, jumpifarrayequal_address
.byte 0x2C
.word jumpifarrayequal_mem1
.word jumpifarrayequal_mem2
.byte jumpifarrayequal_size
.word jumpifarrayequal_address
.endmacro

.macro jumpifarraynotequal, jumpifarraynotequal_mem1, jumpifarraynotequal_mem2, jumpifarraynotequal_size, jumpifarraynotequal_address
.byte 0x2D
.word jumpifarraynotequal_mem1
.word jumpifarraynotequal_mem2
.byte jumpifarraynotequal_size
.word jumpifarraynotequal_address
.endmacro

.macro setbyte, setbyte_pointer, setbyte_value
.byte 0x2E
.word setbyte_pointer
.byte setbyte_value
.endmacro

.macro addbyte, addbyte_pointer, addbyte_value
.byte 0x2F
.word addbyte_pointer
.byte addbyte_value
.endmacro

.macro subtractbyte, subtractbyte_pointer, subtractbyte_value
.byte 0x30
.word subtractbyte_pointer
.byte subtractbyte_value
.endmacro

.macro copyarray, copyarray_destination, copyarray_source, copyarray_size
.byte 0x31
.word copyarray_destination
.word copyarray_source
.byte copyarray_size
.endmacro

.macro cmd32, cmd32_param1, cmd32_param2, cmd32_param3, cmd32_byte
.byte 0x32
.word cmd32_param1
.word cmd32_param2
.word cmd32_param3
.byte cmd32_byte
.endmacro

.macro orbyte, orbyte_pointer, orbyte_value
.byte 0x33
.word orbyte_pointer
.byte orbyte_value
.endmacro

.macro orhalfword, orhalfword_pointer, orhalfword_value
.byte 0x34
.word orhalfword_pointer
.halfword orhalfword_value
.endmacro

.macro orword, orword_pointer, orword_value
.byte 0x35
.word orword_pointer
.word orword_value
.endmacro

.macro bicbyte, bicbyte_pointer, bicbyte_value
.byte 0x36
.word bicbyte_pointer
.byte bicbyte_value
.endmacro

.macro bichalfword, bichalfword_pointer, bichalfword_value
.byte 0x37
.word bichalfword_pointer
.halfword bichalfword_value
.endmacro

.macro bicword, bicword_pointer, bicword_value
.byte 0x38
.word bicword_pointer
.word bicword_value
.endmacro

.macro pause_cmd, pause_duration
.byte 0x39
.halfword pause_duration
.endmacro

.macro waitstate
.byte 0x3A
.endmacro

.macro somethinghealcmd3b, somethinghealcmd3b_bank
.byte 0x3B
.byte somethinghealcmd3b_bank
.endmacro

.macro return_cmd
.byte 0x3C
.endmacro

.macro end_cmd
.byte 0x3D
.endmacro

.macro end2
.byte 0x3E
.endmacro

.macro end3
.byte 0x3F
.endmacro

.macro cmd40, cmd40_address
.byte 0x40
.word cmd40_address
.endmacro

.macro call, call_address
.byte 0x41
.word call_address
.endmacro

.macro jumpiftype2, jumpiftype2_bank, jumpiftype2_type, jumpiftype2_address
.byte 0x42
.byte jumpiftype2_bank
.byte jumpiftype2_type
.word jumpiftype2_address
.endmacro

.macro jumpifabilitypresent, jumpifabilitypresent_ability, jumpifabilitypresent_address
.byte 0x43
.byte jumpifabilitypresent_ability
.word jumpifabilitypresent_address
.endmacro

.macro cmd44
.byte 0x44
.endmacro

.macro playanimation, playanimation_bank playanimation_animation, playanimation_word
.byte 0x45
.byte playanimation_bank
.byte playanimation_animation
.word playanimation_word
.endmacro

.macro cmd46, cmd46_bank, cmd46_address, cmd46_word
.byte 0x46
.byte cmd46_bank
.word cmd46_address
.word cmd46_word
.endmacro

.macro set_statchange_values
.byte 0x47
.endmacro

.macro playstatchangeanimation, playstatchangeanimation_bank, playstatchangeanimation_colour, playstatchangeanimation_byte
.byte 0x48
.byte playstatchangeanimation_bank
.byte playstatchangeanimation_colour
.byte playstatchangeanimation_byte
.endmacro

.macro cmd49, cmd49_byte1, cmd49_byte2
.byte 0x49
.byte cmd49_byte1
.byte cmd49_byte2
.endmacro

.macro damagecalc2
.byte 0x4A
.endmacro

.macro cmd4b
.byte 0x4B
.endmacro

.macro switch1, switch1_bank
.byte 0x4C
.byte switch1_bank
.endmacro

.macro switch2, switch2_bank
.byte 0x4D
.byte switch2_bank
.endmacro

.macro switch3, switch3_bank switch3_byte
.byte 0x4E
.byte switch3_bank
.byte switch3_byte
.endmacro

.macro jumpifcannotswitch, jumpifcannotswitch_bank, jumpifcannotswitch_address
.byte 0x4F
.byte jumpifcannotswitch_bank
.word jumpifcannotswitch_address
.endmacro

.macro openpartyscreen, openpartyscreen_bank, openpartyscreen_address
.byte 0x50
.byte openpartyscreen_bank
.word openpartyscreen_address
.endmacro

.macro switch_handle_order, cmd51_bank cmd51_param2
.byte 0x51
.byte cmd51_bank
.byte cmd51_param2
.endmacro

.macro switchineffects, cmd52_bank
.byte 0x52
.byte cmd52_bank
.endmacro

.macro trainer_slide, cmd53_bank
.byte 0x53
.byte cmd53_bank
.endmacro

.macro cmd54, cmd54_halfword
.byte 0x54
.halfword cmd54_halfword
.endmacro

.macro cmd55, cmd55_word
.byte 0x55
.word cmd55_word
.endmacro

.macro playfaintingcry, playfaintingcrybank
.byte 0x56
.byte playfaintingcrybank
.endmacro

.macro cmd57
.byte 0x57
.endmacro

.macro return_to_ball, cmd58_bank
.byte 0x58
.byte cmd58_bank
.endmacro

.macro checkiflearnmoveinbattle, checkiflearnmoveinbattle_param1, checkiflearnmoveinbattle_param2, checkiflearnmoveinbattle_bank_maybe
.byte 0x59
.word checkiflearnmoveinbattle_param1
.word checkiflearnmoveinbattle_param2
.byte checkiflearnmoveinbattle_bank_maybe
.endmacro

.macro cmd5a, cmd5a_address
.byte 0x5A
.word cmd5a_address
.endmacro

.macro cmd5b, cmd5b_address
.byte 0x5B
.word cmd5b_address
.endmacro

.macro cmd5c, cmd5c_bank
.byte 0x5C
.byte cmd5c_bank
.endmacro

.macro hitanim, hitanim_bank
.byte 0x5C
.byte hitanim_bank
.endmacro

.macro cmd5d
.byte 0x5D
.endmacro

.macro cmd5e, cmd5e_bank
.byte 0x5E
.byte cmd5e_bank
.endmacro

.macro cmd5f
.byte 0x5F
.endmacro

.macro cmd60, cmd60_byte
.byte 0x60
.byte cmd60_byte
.endmacro

.macro cmd61, cmd61_bank_or_side
.byte 0x61
.byte cmd61_bank_or_side
.endmacro

.macro cmd62, cmd62_bank_or_side
.byte 0x62
.byte cmd62_bank_or_side
.endmacro

.macro jumptoattack, jumptoattack_bank
.byte 0x63
.byte jumptoattack_bank
.endmacro

.macro statusanimation, statusanimation_bank
.byte 0x64
.byte statusanimation_bank
.endmacro

.macro status2animation, status2animationbank, status2animationstatus
.byte 0x65
.byte status2animationbank
.word status2animationstatus
.endmacro

.macro chosenstatusanimation, chosenstatusanimationbank, chosenstatusanimationbankstatus, chosenstatusanimationbankaddress
.byte 0x66
.byte chosenstatusanimationbank
.byte chosenstatusanimationbankstatus
.word chosenstatusanimationbankaddress
.endmacro

.macro cmd67
.byte 0x67
.endmacro

.macro cmd68
.byte 0x68
.endmacro

.macro cmd69
.byte 0x69
.endmacro

.macro removeitem, removeitem_bank
.byte 0x6A
.byte removeitem_bank
.endmacro

.macro cmd6b
.byte 0x6B
.endmacro

.macro cmd6c
.byte 0x6C
.endmacro

.macro cmd6d
.byte 0x6D
.endmacro

.macro cmd6e
.byte 0x6E
.endmacro

.macro cmd6f, cmd6f_bank
.byte 0x6F
.byte cmd6f_bank
.endmacro

.macro recordability, cmd70_bank
.byte 0x70
.byte cmd70_bank
.endmacro

.macro cmd71
.byte 0x71
.endmacro

.macro cmd72, cmd72_address
.byte 0x72
.word cmd72_address
.endmacro

.macro cmd73, cmd73_bank
.byte 0x73
.byte cmd73_bank
.endmacro

.macro cmd74, cmd74_bank
.byte 0x74
.byte cmd74_bank
.endmacro

.macro cmd75
.byte 0x75
.endmacro

.macro cmd76, cmd76_bank cmd76_byte
.byte 0x76
.byte cmd76_bank
.byte cmd76_byte
.endmacro

.macro setprotect
.byte 0x77
.endmacro

.macro faintifabilitynotdamp
.byte 0x78
.endmacro

.macro setuserhptozero
.byte 0x79
.endmacro

.macro jumpwhiletargetvalid, jumpwhiletargetvalid_address
.byte 0x7A
.word jumpwhiletargetvalid_address
.endmacro

.macro setdamageasrestorehalfmaxhp, setdamageasrestorehalfmaxhp_address, setdamageasrestorehalfmaxhp_byte
.byte 0x7B
.word setdamageasrestorehalfmaxhp_address
.byte setdamageasrestorehalfmaxhp_byte
.endmacro

.macro jumptolastusedattack
.byte 0x7C
.endmacro

.macro setrain
.byte 0x7D
.endmacro

.macro setreflect
.byte 0x7E
.endmacro

.macro setleechseed
.byte 0x7F
.endmacro

.macro manipulatedamage, manipulatedamage_id
.byte 0x80
.byte manipulatedamage_id
.endmacro

.macro setrest, setrest_address
.byte 0x81
.word setrest_address
.endmacro

.macro jumpifnotfirstturn, jumpifnotfirstturn_address
.byte 0x82
.word jumpifnotfirstturn_address
.endmacro

.macro callasm_cmd, callasm_index
.byte 0x83
.halfword callasm_index
.endmacro

.macro setnewmoveeffect, setnewmoveeffect_fail
.byte 0x83
.halfword 23
.word setnewmoveeffect_fail
.endmacro

.macro jumpifcannotsleep, jumpifcannotsleep_address
.byte 0x84
.word jumpifcannotsleep_address
.endmacro

.macro stockpile
.byte 0x85
.endmacro

.macro stockpiletobasedamage, stockpiletobasedamage_address
.byte 0x86
.word stockpiletobasedamage_address
.endmacro

.macro stockpiletohprecovery, stockpiletohprecovery_address
.byte 0x87
.word stockpiletohprecovery_address
.endmacro

.macro draindamage
.byte 0x88
.endmacro

No_Override equ 0x0
Override equ 0x40
.macro statbuffchange, statbuffchange_target, statbuffchange_address
.byte 0x89
.byte statbuffchange_target
.word statbuffchange_address
.endmacro

.macro normalisebuffs
.byte 0x8A
.endmacro

.macro setbide
.byte 0x8B
.endmacro

.macro confuseifrepeatingattackends
.byte 0x8C
.endmacro

.macro setloopcounter, setloopcounter_number_of_loop
.byte 0x8D
.byte setloopcounter_number_of_loop
.endmacro

.macro cmd8e
.byte 0x8E
.endmacro

.macro preparemultihit
.byte 0x8E
.endmacro

.macro forcerandomswitch, forcerandomswitch_address
.byte 0x8F
.word forcerandomswitch_address
.endmacro

.macro changetypestoenemyattacktype, changetypestoenemyattacktype_address
.byte 0x90
.word changetypestoenemyattacktype_address
.endmacro

.macro givemoney
.byte 0x91
.endmacro

.macro setlightscreen
.byte 0x92
.endmacro

.macro koplussomethings, koplussomethings_address
.byte 0x93
.word koplussomethings_address
.endmacro

.macro gethalfcurrentenemyhp
.byte 0x94
.endmacro

.macro setsandstorm
.byte 0x95
.endmacro

.macro weatherdamage
.byte 0x96
.endmacro

.macro tryinfatuatetarget, tryinfatuatetarget_address
.byte 0x97
.word tryinfatuatetarget_address
.endmacro

.macro statusiconeupdate, statusiconeupdate_bank
.byte 0x98
.byte statusiconeupdate_bank
.endmacro

.macro setmisteffect
.byte 0x99
.endmacro

.macro setincreasedcriticalchance
.byte 0x9A
.endmacro

.macro transformdataexecution
.byte 0x9B
.endmacro

.macro setsubstituteeffect
.byte 0x9C
.endmacro

.macro copyattack, copyattack_address
.byte 0x9D
.word copyattack_address
.endmacro

.macro metronomeeffect
.byte 0x9E
.endmacro

.macro nightshadedamageeffect
.byte 0x9F
.endmacro

.macro psywavedamageeffect
.byte 0xA0
.endmacro

.macro counterdamagecalculator, counterdamagecalculator_address
.byte 0xA1
.word counterdamagecalculator_address
.endmacro

.macro mirrorcoatdamagecalculator, mirrorcoatdamagecalculator_address
.byte 0xA2
.word mirrorcoatdamagecalculator_address
.endmacro

.macro disablelastusedattack, disablelastusedattack_address
.byte 0xA3
.word disablelastusedattack_address
.endmacro

.macro setencore setencore_address
.byte 0xA4
.word setencore_address
.endmacro

.macro painsplitdamagecalculator, painsplitdamagecalculator_address
.byte 0xA5
.word painsplitdamagecalculator_address
.endmacro

.macro settypetorandomresistance, settypetorandomresistance_address
.byte 0xA6
.word settypetorandomresistance_address
.endmacro

.macro setalwayshitflag
.byte 0xA7
.endmacro

.macro copymovepermanently, copymovepermanently_address
.byte 0xA8
.word copymovepermanently_address
.endmacro

.macro selectrandommovefromusermoves, selectrandommovefromusermoves_address
.byte 0xA9
.word selectrandommovefromusermoves_address
.endmacro

.macro destinybondeffect
.byte 0xAA
.endmacro

.macro cmdab
.byte 0xAB
.endmacro

.macro remaininghptopower
.byte 0xAC
.endmacro

.macro reducepprandom, reducepprandom_address
.byte 0xAD
.word reducepprandom_address
.endmacro

.macro clearstatusifnotsoundproofed
.byte 0xAE
.endmacro

.macro cursetarget, cursetarget_address
.byte 0xAF
.word cursetarget_address
.endmacro

.macro setspikes, setspikes_address
.byte 0xB0
.word setspikes_address
.endmacro

.macro setforesight
.byte 0xB1
.endmacro

.macro setperishsong, setperishsong_address
.byte 0xB2
.word setperishsong_address
.endmacro

.macro rolloutdamagecalculation
.byte 0xB3
.endmacro

.macro jumpifconfusedandattackmaxed, jumpifconfusedandattackmaxed_bank, jumpifconfusedandattackmaxed_address
.byte 0xB4
.byte jumpifconfusedandattackmaxed_bank
.word jumpifconfusedandattackmaxed_address
.endmacro

.macro furycutterdamagecalculation
.byte 0xB5
.endmacro

.macro happinesstodamagecalculation
.byte 0xB6
.endmacro

.macro presentdamagecalculation
.byte 0xB7
.endmacro

.macro setsafeguard
.byte 0xB8
.endmacro

.macro magnitudedamagecalculation
.byte 0xB9
.endmacro

.macro cmdba, cmdba_address
.byte 0xBA
.word cmdba_address
.endmacro

.macro setsunny
.byte 0xBB
.endmacro

.macro maxattackhalvehp, maxattackhalvehp_address
.byte 0xBC
.word maxattackhalvehp_address
.endmacro

.macro copyfoestats, copyfoestats_address
.byte 0xBD
.word copyfoestats_address
.endmacro

.macro breakfree
.byte 0xBE
.endmacro

.macro setcurled
.byte 0xBF
.endmacro

.macro recoverbasedonsunlight
.byte 0xC0
.endmacro

.macro hiddenpowerdamagecalculation
.byte 0xC1
.endmacro

.macro selectnexttarget
.byte 0xC2
.endmacro

.macro setfutureattack, setfutureattack_address
.byte 0xC3
.word setfutureattack_address
.endmacro

.macro beatupcalculation, beatupcalculation_address1, beatupcalculation_address2
.byte 0xC4
.word beatupcalculation_address1
.word beatupcalculation_address2
.endmacro

.macro hidepreattack
.byte 0xC5
.endmacro

.macro unhidepostattack
.byte 0xC6
.endmacro

.macro setminimize
.byte 0xC7
.endmacro

.macro sethail
.byte 0xC8
.endmacro

.macro jumpifattackandspecialattackcannotfall, jumpifattackandspecialattackcannotfall_address
.byte 0xC9
.word jumpifattackandspecialattackcannotfall_address
.endmacro

.macro setforcedtarget
.byte 0xCA
.endmacro

.macro setcharge
.byte 0xCB
.endmacro

.macro callterrainattack
.byte 0xCC
.endmacro

.macro cureifburnedparalysedorpoisoned, cureifburnedparalysedorpoisoned_address
.byte 0xCD
.word cureifburnedparalysedorpoisoned_address
.endmacro

.macro settorment, settorment_address
.byte 0xCE
.word settorment_address
.endmacro

.macro jumpifnodamage, jumpifnodamage_address
.byte 0xCF
.word jumpifnodamage_address
.endmacro

.macro settaunt, settaunt_address
.byte 0xD0
.word settaunt_address
.endmacro

.macro sethelpinghand, sethelpinghand_address
.byte 0xD1
.word sethelpinghand_address
.endmacro

.macro itemswap, itemswap_address
.byte 0xD2
.word itemswap_address
.endmacro

.macro copyability, copyability_address
.byte 0xD3
.word copyability_address
.endmacro

.macro cmdd4, cmdd4_byte cmdd4_address
.byte 0xD4
.byte cmdd4_byte
.word cmdd4_address
.endmacro

.macro setroots, setroots_address
.byte 0xD5
.word setroots_address
.endmacro

.macro doubledamagedealtifdamaged
.byte 0xD6
.endmacro

.macro setyawn, setyawn_address
.byte 0xD7
.word setyawn_address
.endmacro

.macro setdamagetohealthdifference, setdamagetohealthdifference_address
.byte 0xD8
.word setdamagetohealthdifference_address
.endmacro

.macro scaledamagebyhealthratio
.byte 0xD9
.endmacro

.macro abilityswap, abilityswap_address
.byte 0xDA
.word abilityswap_address
.endmacro

.macro imprisoneffect, imprisoneffect_address
.byte 0xDB
.word imprisoneffect_address
.endmacro

.macro setgrudge, setgrudge_address
.byte 0xDC
.word setgrudge_address
.endmacro

.macro weightdamagecalculation
.byte 0xDD
.endmacro

.macro assistattackselect, assistattackselect_address
.byte 0xDE
.word assistattackselect_address
.endmacro

.macro setmagiccoat, setmagiccoat_address
.byte 0xDF
.word setmagiccoat_address
.endmacro

.macro setstealstatchange, setstealstatchange_address
.byte 0xE0
.word setstealstatchange_address
.endmacro

.macro cmde1, cmde1_address
.byte 0xE1
.word cmde1_address
.endmacro

.macro swithchoutabilities, cmde2_bank
.byte 0xE2
.byte cmde2_bank
.endmacro

.macro jumpiffainted, jumpiffainted_bank, jumpiffainted_address
.byte 0xE3
.byte jumpiffainted_bank
.word jumpiffainted_address
.endmacro

.macro secretpowereffect
.byte 0xE4
.endmacro

.macro pickupitemcalculation
.byte 0xE5
.endmacro

.macro castformchangeanim
.byte 0xE6
.endmacro

.macro checkcastform
.byte 0xE7
.endmacro

.macro settypebasedhalvers, settypebasedhalvers_address
.byte 0xE8
.word settypebasedhalvers_address
.endmacro

.macro seteffectbyweather
.byte 0xE9
.endmacro

.macro recycleitem, recycleitem_address
.byte 0xEA
.word recycleitem_address
.endmacro

.macro settypetoterrain, settypetoterrain_address
.byte 0xEB
.word settypetoterrain_address
.endmacro

.macro pursuitwhenswitched, pursuitwhenswitched_address
.byte 0xEC
.word pursuitwhenswitched_address
.endmacro

.macro snatchmove
.byte 0xED
.endmacro

.macro removereflectlightscreen
.byte 0xEE
.endmacro

.macro pokemoncatchfunction
.byte 0xEF
.endmacro

.macro catchpoke
.byte 0xF0
.endmacro

.macro capturesomethingf1, capturesomethingf1_address
.byte 0xF1
.word capturesomethingf1_address
.endmacro

.macro capturesomethingf2
.byte 0xF2
.endmacro

.macro capturesomethingf3, capturesomethingf3_address
.byte 0xF3
.word capturesomethingf3_address
.endmacro

.macro removehp
.byte 0xF4
.endmacro

.macro curestatutfirstword
.byte 0xF5
.endmacro

.macro cmdf6
.byte 0xF6
.endmacro

.macro activesidesomething
.byte 0xF7
.endmacro

.macro trainer_back_slide, cmdf8_bank
.byte 0xF8
.byte cmdf8_bank
.endmacro

//a new move setter callasm_cmd
.macro seteffect1, seteffecteffect
callasm_cmd 145
.halfword seteffecteffect
.endmacro

//JeremyZ
.macro pollenpuffdamagecalculation
.byte 0xF9
.endmacro

//JeremyZ
.macro blowifabilitynotdamp
.byte 0xFA
.endmacro
