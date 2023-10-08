MSG_OBTAIN equ 0x0
MSG_FIND equ 0x1
MSG_FACE equ 0x2
MSG_SIGN equ 0x3
MSG_KEEPOPEN equ 0x4
MSG_YESNO equ 0x5
MSG_NORMAL equ 0x6
MSG_POKENAV equ 0xA

//applymovement
MOVE_PLAYER equ 0xFF
MOVE_CAMERA equ 0x7F

//vars
LASTRESULT equ 0x800D
LASTTALKED equ 0x800F

//Compare values
lessthan equ 0x0 //A is less than B
equal equ 0x1 //A is equal to B
greaterthan equ 0x2 //A is more than B
lessorequal equ 0x3 //A is less than or equal to B
greaterorequal equ 0x4 //A is greater than or equal to B
notequal equ 0x5 //A is not equal to B

//azuril13's if command becuase it's nice
_goto equ	0x06
_call equ	0x07


.macro if, condition, goto_or_call, script
.byte goto_or_call
.byte condition
.word script
.endmacro

.macro msgbox, msgbox_pointer, msgbox_type
.byte 0xF
.byte 0x0
.word msgbox_pointer
.byte 0x9
.byte msgbox_type
.endmacro

.macro giveitem, giveitem_item, giveitem_amount, giveitem_msgtype
.byte 0x1A
.halfword 0x8000
.halfword giveitem_item
.byte 0x1A
.halfword 0x8001
.halfword giveitem_amount
.byte 0x9
.byte giveitem_msgtype
.endmacro

.macro giveitem2, giveitem2_item, giveitem2_amount, giveitem2_song
.byte 0x1A
.halfword 0x8000
.halfword giveitem2_item
.byte 0x1A
.halfword 0x8001
.halfword giveitem2_amount
.byte 0x1A
.halfword 0x8002
.halfword giveitem2_song
.byte 0x9
.byte 0x9
.endmacro

.macro giveitem3, giveitem3_decoration
.byte 0x1A
.word 0x8000
.halfword giveitem3_decoration
.byte 0x9
.byte 0x7
.endmacro

.macro wildbattle, wildbattle_species, wildbattle_level, wildbattle_item
.byte 0xB6
.halfword wildbattle_species
.byte wildbattle_level
.halfword wildbattle_item
.byte 0xB7
.endmacro

.macro registernav, registernav_trainer
.byte 0x1A
.halfword 0x8000
.halfword registernav_trainer
.byte 0x9
.byte 0x8
.endmacro

//Commands
.macro nop
.byte 0x0
.endmacro

.macro nop1
.byte 0x1
.endmacro

.macro end
.byte 0x2
.endmacro

.macro return
.byte 0x3
.endmacro

.macro call, call_destination
.byte 0x4
.word call_destination
.endmacro

.macro goto, goto_destination
.byte 0x5
.word goto_destination
.endmacro

.macro if1, if1_condition, if1_goto_destination
.byte 0x6
.byte if1_condition
.word if1_goto_destination
.endmacro

.macro if2, if2_condition, if2_call_destination
.byte 0x7
.byte if2_condition
.word if2_call_destination
.endmacro

.macro gotostd, gotostd_param1
.byte 0x8
.byte gotostd_param1
.endmacro

.macro callstd, callstd_param1
.byte 0x9
.byte callstd_param1
.endmacro

.macro gotostdif, gotostdif_cond, gotostdif_param1
.byte 0xA
.byte gotostdif_cond
.byte gotostdif_param1
.endmacro

.macro callstdif, callstdif_cond, callstdif_param1
.byte 0xB
.byte callstdif_cond
.byte callstdif_param1
.endmacro

//jumpram's documentation may not be complete
.macro jumpram
.byte 0xC
.endmacro

.macro killscript
.byte 0xD
.endmacro

.macro setbyte, setbyte_value
.byte 0xE
.byte setbyte_value
.endmacro

.macro loadpointer, loadpointer_bank, loadpointer_pointer
.byte 0xF
.byte loadpointer_bank
.word loadpointer_pointer
.endmacro

.macro setbyte2, setbyte2_bank, setbyte2_value
.byte 0x10
.byte setbyte2_bank
.byte setbyte2_value
.endmacro

.macro writebytetooffset, wbto_byte, wbto_pointer
.byte 0x11
.byte wbto_byte
.word wbto_pointer
.endmacro

.macro loadbytefrompointer, lbfp_bank_dest, lbfp_pointer
.byte 0x12
.byte lbfp_bank_dest
.word lbfp_pointer
.endmacro

.macro setfarbyte, setfarbyte_bank, setfarbyte_pointer
.byte 0x13
.byte setfarbyte_bank
.word setfarbyte_pointer
.endmacro

.macro copyscriptbanks, copyscriptbanks_bank_destination, copyscriptbanks_bank_source
.byte 0x14
.byte copyscriptbanks_bank_destination
.byte copyscriptbanks_bank_source
.endmacro

.macro copybyte, copybyte_dest, copybyte_source
.byte 0x15
.word copybyte_dest
.word copybyte_source
.endmacro

.macro setvar, setvar_var, setvar_value
.byte 0x16
.halfword setvar_var
.halfword setvar_value
.endmacro

.macro addvar, addvar_var, addvar_value
.byte 0x17
.halfword addvar_var
.halfword addvar_value
.endmacro

.macro subvar, subvar_var, subvar_value
.byte 0x18
.halfword subvar_var
.halfword subvar_value
.endmacro

.macro copyvar, copyvar_destination, copyvar_source
.byte 0x19
.halfword copyvar_destination
.halfword copyvar_source
.endmacro

.macro copyvarifnotzero, copyvarifnotzero_var, copyvarifnotzero_source
.byte 0x1A
.halfword copyvarifnotzero_var
.halfword copyvarifnotzero_source
.endmacro

.macro comparebanks, comparebanks_a, comparebanks_b
.byte 0x1B
.byte comparebanks_a
.byte comparebanks_b
.endmacro

.macro comparebanktobyte, comparebanktobyte_bank, comparebanktobyte_byte
.byte 0x1C
.byte comparebanktobyte_bank
.byte comparebanktobyte_byte
.endmacro

.macro comparebanktofarbyte, comparebbanktofarbyte_bank, comparebanktofarbyte_pointer
.byte 0x1D
.byte comparebanktofarbyte_bank
.word comparebanktofarbyte_pointer
.endmacro

.macro comparefarbytetobank, comparefarbytetobank_pointer, comparefarbytetobank_bank
.byte 0x1E
.word comparefarbytetobank_pointer
.byte comparefarbytetobank_bank
.endmacro

.macro comparefarbytetobyte, comparefarbytetobyte_pointer, comparefarbytetobyte_byte
.byte 0x1F
.word comparefarbytetobyte_pointer
.byte comparefarbytetobyte_byte
.endmacro

.macro comparefarbytes, comparefarbytes_param1, comparefarbytes_param2
.byte 0x20
.word comparefarbytes_param1
.word comparefarbytes_param2
.endmacro

.macro compare, compare_var, compare_value
.byte 0x21
.halfword compare_var
.halfword compare_value
.endmacro

.macro comparevars, comparevars_var1, comparevars_var2
.byte 0x22
.halfword comparevars_var1
.halfword comparevars_var2
.endmacro

.macro callasm, callasm_pointer
.byte 0x23
.word callasm_pointer
.endmacro

.macro cmd24, cmd24_pointer
.byte 0x24
.word cmd24_pointer
.endmacro

.macro special, special_param
.byte 0x25
.halfword special_param
.endmacro

.macro special2, special2_outputvar, special2_function
.byte 0x26
.halfword special2_outputvar
.halfword special2_function
.endmacro

.macro waitstate
.byte 0x27
.endmacro

.macro pause, pause_time
.byte 0x28
.halfword pause_time
.endmacro

.macro setflag, setflag_flag
.byte 0x29
.halfword setflag_flag
.endmacro

.macro clearflag, clearflag_flag
.byte 0x2A
.halfword clearflag_flag
.endmacro

.macro checkflag, checkflag_flag
.byte 0x2B
.halfword checkflag_flag
.endmacro

//nop in FR
.macro cmd2C
.byte 0x2C
.endmacro

//nop in FR, no other info right now.
.macro checkdailyflags
.byte 0x2D
.endmacro

.macro resetvars, gettime
.byte 0x2E
.endmacro

.macro sound, sound_id
.byte 0x2F
.halfword sound_id
.endmacro

.macro checksound
.byte 0x30
.endmacro

.macro fanfare, fanfare_id
.byte 0x31
.halfword fanfare_id
.endmacro

.macro waitfanfare
.byte 0x32
.endmacro

.macro playsong, playsong_songid, playsong_unknown
.byte 0x33
.halfword playsong_songid
.byte playsong_unknown
.endmacro

.macro playsong2, playsong2_song
.byte 0x34
.halfword playsong2_song
.endmacro

.macro fadedefault
.byte 0x35
.endmacro

.macro fadesong, fadesong_song
.byte 0x36
.halfword fadesong_song
.endmacro

.macro fadeout, fadeout_speed
.byte 0x37
.byte fadeout_speed
.endmacro

.macro fadein, fadein_speed
.byte 0x38
.byte fadein_speed
.endmacro

.macro warp, warp_bank, warp_map, warp_warp, warp_x_axis, warp_y_axis
.byte 0x39
.byte warp_bank
.byte warp_map
.byte warp_warp
.halfword warp_x_axis
.halfword warp_y_axis
.endmacro

.macro warpmuted, warpmuted_bank, warpmuted_map, warpmuted_warp, warpmuted_x_axis, warpmuted_y_axis
.byte 0x3A
.byte warpmuted_bank
.byte warpmuted_map
.byte warpmuted_warp
.halfword warpmuted_x_axis
.halfword warpmuted_y_axis
.endmacro

.macro warpwalk, warpwalk_bank, warpwalk_map, warpwalk_warp, warpwalk_x_axis, warpwalk_y_axis
.byte 0x3B
.byte warpwalk_bank
.byte warpwalk_map
.byte warpwalk_warp
.halfword warpwalk_x_axis
.halfword warpwalk_y_axis
.endmacro

.macro warphole, warphole_bank, warphole_map
.byte 0x3C
.byte warphole_bank
.byte warphole_map
.endmacro

.macro warpteleport, warpteleport_bank, warpteleport_map, warpteleport_warp, warpteleport_x_axis, warpteleport_y_axis
.byte 0x3D
.byte warpteleport_bank
.byte warpteleport_map
.byte warpteleport_warp
.halfword warpteleport_x_axis
.halfword warpteleport_y_axis
.endmacro

.macro warp3, warp3_bank, warp3_map, warp3_warp, warp3_x_axis, warp3_y_axis
.byte 0x3E
.byte warp3_bank
.byte warp3_map
.byte warp3_warp
.halfword warp3_x_axis
.halfword warp3_y_axis
.endmacro

.macro setwarpplace, setwarpplace_bank, setwarpplace_map, setwarpplace_warp, setwarpplace_x_axis, setwarpplace_y_axis
.byte 0x3F
.byte setwarpplace_bank
.byte setwarpplace_map
.byte setwarpplace_warp
.halfword setwarpplace_x_axis
.halfword setwarpplace_y_axis
.endmacro

.macro warp4, warp4_bank, warp4_map, warp4_warp, warp4_x_axis, warp4_y_axis
.byte 0x40
.byte warp4_bank
.byte warp4_map
.byte warp4_warp
.halfword warp4_x_axis
.halfword warp4_y_axis
.endmacro

.macro warp5, warp5_bank, warp5_map, warp5_warp, warp5_x_axis, warp5_y_axis
.byte 0x41
.byte warp5_bank
.byte warp5_map
.byte warp5_warp
.halfword warp5_x_axis
.halfword warp5_y_axis
.endmacro

.macro getplayerpos, getplayerpos_x_var, getplayerpos_y_var
.byte 0x42
.halfword getplayerpos_x_var
.halfword getplayerpos_y_var
.endmacro

.macro countpokemon
.byte 0x43
.endmacro

.macro additem, additem_index, additem_quantity
.byte 0x44
.halfword additem_index
.halfword additem_quantity
.endmacro

.macro removeitem, removeitem_index, removeitem_quantity
.byte 0x45
.halfword removeitem_index
.halfword removeitem_quantity
.endmacro

.macro checkitemroom, checkitemroom_index, checkitemroom_quantity
.byte 0x46
.halfword checkitemroom_index
.halfword checkitemroom_quantity
.endmacro

.macro checkitem, checkitem_index, checkitem_quantity
.byte 0x47
.halfword checkitem_index
.halfword checkitem_quantity
.endmacro

.macro checkitemtype, checkitemtype_index
.byte 0x48
.halfword checkitemtype_index
.endmacro

.macro addpcitem, addpcitem_index, addpcitem_quantity
.byte 0x49
.halfword addpcitem_index
.halfword addpcitem_quantity
.endmacro

.macro checkpcitem, checkpcitem_index, checkpcitem_quantity
.byte 0x4A
.halfword checkpcitem_index
.halfword checkpcitem_quantity
.endmacro

.macro adddecoration, adddecoration_decoration
.byte 0x4B
.halfword adddecoration_decoration
.endmacro

.macro removedecoration, removedecoration_decoration
.byte 0x4C
.halfword removedecoration_decoration
.endmacro

.macro testdecoration, testdecoration_decoration
.byte 0x4D
.halfword testdecoration_decoration
.endmacro

.macro checkdecoration, checkdecoration_decoration
.byte 0x4E
.halfword checkdecoration_decoration
.endmacro

.macro applymovement, applymovement_person_id, applymovement_pointer
.byte 0x4F
.halfword applymovement_person_id
.word applymovement_pointer
.endmacro

.macro applymovementpos, applymovementpos_var, applymovementpos_pointer
.byte 0x50
.halfword applymovementpos_var
.word applymovementpos_pointer
.endmacro

.macro waitmovement, waitmovement_index
.byte 0x51
.halfword waitmovement_index
.endmacro

.macro waitmovementpos, waitmovementpos_index, waitmovementpos_x, waitmovementpos_y
.byte 0x52
.halfword waitmovementpos_index
.byte waitmovementpos_x
.byte waitmovementpos_y
.endmacro

.macro hidesprite, hidesprite_param
.byte 0x53
.halfword hidesprite_param
.endmacro

.macro hidespritepos, hidespritepos_index, hidespritepos_x, hidespritepos_y
.byte 0x54
.halfword hidespritepos_index
.byte hidespritepos_x
.byte hidespritepos_y
.endmacro

.macro showsprite, showsprite_id
.byte 0x55
.halfword showsprite_id
.endmacro

.macro movesprite, movesprite_person, movesprite_x, movesprite_y
.byte 0x57
.halfword movesprite_person
.halfword movesprite_x
.halfword movesprite_y
.endmacro

.macro faceplayer
.byte 0x5A
.endmacro

.macro trainerbattle0, trainerbattle0_index, trainerbattle0_intro, trainerbattle0_loss
.byte 0x5C
.byte 0x0
.halfword trainerbattle0_index
.halfword 0
.word trainerbattle0_intro
.word trainerbattle0_loss
.endmacro

.macro trainerbattle1, trainerbattle1_index, trainerbattle1_intro, trainerbattle1_loss, trainerbattle1_extra
.byte 0x5C
.byte 0x1
.halfword trainerbattle1_index
.halfword 0
.word trainerbattle1_intro
.word trainerbattle1_loss
.word trainerbattle1_extra
.endmacro

.macro trainerbattle2, trainerbattle2_index, trainerbattle2_intro, trainerbattle2_loss, trainerbattle2_extra
.byte 0x5C
.byte 0x2
.halfword trainerbattle2_index
.halfword 0
.word trainerbattle2_intro
.word trainerbattle2_loss
.word trainerbattle2_extra
.endmacro

.macro trainerbattle3, trainerbattle3_index, trainerbattle3_intro
.byte 0x5C
.byte 0x3
.halfword trainerbattle3_index
.halfword 0
.word trainerbattle3_intro
.endmacro

.macro trainerbattle4, trainerbattle4_index, trainerbattle4_intro, trainerbattle4_loss, trainerbattle4_extra
.byte 0x5C
.byte 0x4
.halfword trainerbattle4_index
.halfword 0
.word trainerbattle4_intro
.word trainerbattle4_loss
.word trainerbattle4_extra
.endmacro

.macro trainerbattle5, trainerbattle5_index, trainerbattle5_intro, trainerbattle5_loss
.byte 0x5C
.byte 0x5
.halfword trainerbattle5_index
.halfword 0
.word trainerbattle5_intro
.word trainerbattle5_loss
.endmacro

.macro trainerbattle6, trainerbattle6_index, trainerbattle6_intro, trainerbattle6_loss, trainerbattle6_extra, trainerbattle6_extra2
.byte 0x5C
.byte 0x6
.halfword trainerbattle6_index
.halfword 0
.word trainerbattle6_intro
.word trainerbattle6_loss
.word trainerbattle6_extra
.word trainerbattle6_extra2
.endmacro

.macro trainerbattle7, trainerbattle7_index, trainerbattle7_intro, trainerbattle7_loss, trainerbattle7_extra
.byte 0x5C
.byte 0x7
.halfword trainerbattle7_index
.halfword 0
.word trainerbattle7_intro
.word trainerbattle7_loss
.word trainerbattle7_extra
.endmacro

.macro trainerbattle8, trainerbattle8_index, trainerbattle8_intro, trainerbattle8_loss, trainerbattle8_extra, trainerbattle8_extra2
.byte 0x5C
.byte 0x8
.halfword trainerbattle8_index
.halfword 0
.word trainerbattle8_intro
.word trainerbattle8_loss
.word trainerbattle8_extra
.word trainerbattle8_extra2
.endmacro

.macro trainerbattle9, trainerbattle9_index, trainerbattle9_intro, trainerbattle9_loss
.byte 0x5C
.byte 0x9
.halfword trainerbattle9_index
.halfword 0
.word trainerbattle9_intro
.word trainerbattle9_loss
.endmacro

.macro repeattrainerbattle
.byte 0x5D
.endmacro

.macro endtrainerbattle
.byte 0x5E
.endmacro

.macro endtrainerbattle2
.byte 0x5F
.endmacro

.macro checktrainerflag, checktrainerflag_trainer
.byte 0x60
.halfword checktrainerflag_trainer
.endmacro

//XSE had it wrong, i'm correcting them
.macro settrainerflag, settrainerflag_trainer
.byte 0x61
.halfword settrainerflag_trainer
.endmacro

.macro cleartrainerflag, cleartrainerflag_trainer
.byte 0x62
.halfword cleartrainerflag_trainer
.endmacro

.macro movesprite2, movesprite2_person, movesprite2_x, movesprite2_y
.byte 0x63
.halfword movesprite2_person
.halfword movesprite2_x
.halfword movesprite2_y
.endmacro

.macro moveoffscreen,moveoffscreen_person
.byte 0x64
.halfword moveoffscreen_person
.endmacro

.macro spritebehave,spritebehave_person,spritebehave_behaviour
.byte 0x65
.halfword spritebehave_person
.byte spritebehave_behavior
.endmacro

.macro waitmsg
.byte 0x66
.endmacro

.macro preparemsg,preparemsg_text
.byte 0x67
.word preparemsg_text
.endmacro

.macro closeonkeypress
.byte 0x68
.endmacro

.macro lockall
.byte 0x69
.endmacro

.macro lock
.byte 0x6A
.endmacro

.macro releaseall
.byte 0x6B
.endmacro

.macro release
.byte 0x6C
.endmacro

.macro waitkeypress
.byte 0x6D
.endmacro

.macro yesnobox, yesnobox_x, yesnobox_y
.byte 0x6E
.byte yesnobox_x
.byte yesnobox_y
.endmacro

.macro multichoice, multichoice_x, multichoice_y, multichoice_list, multichoice_b_enabled
.byte 0x6F
.byte multichoice_x
.byte multichoice_y
.byte multichoice_list
.byte multichoice_b_enabled
.endmacro

.macro multichoice2, multichoice2_x, multichoice2_y, multichoice2_list, multichoice2_default_pos, multichoice2_b_enabled
.byte 0x70
.byte multichoice2_x
.byte multichoice2_y
.byte multichoice2_list
.byte multichoice2_default_pos
.byte multichoice2_b_enabled
.endmacro

.macro multichoice3, multichoice3_x, multichoice3_y, multichoice3_list, multichoice3_item_per_row, multichoice3_b_enabled
.byte 0x71
.byte multichoice3_x
.byte multichoice3_y
.byte multichoice3_list
.byte multichoice3_items_per_row
.byte multichoice3_b_enabled
.endmacro

.macro showbox, showbox_left_pos, showbox_top_pos, showbox_width, showbox_height
.byte 0x72
.byte showbox_left_pos
.byte showbox_top_pos
.byte showbox_width
.byte showbox_height
.endmacro

.macro hidebox, hidebox_left_pos, hidebox_top_pos, hidebox_width, hidebox_height
.byte 0x73
.byte hidebox_left_pos
.byte hidebox_top_pos
.byte hidebox_width
.byte hidebox_height
.endmacro

.macro clearbox, clearbox_left_pos, clearbox_top_pos, clearbox_width, clearbox_height
.byte 0x74
.byte clearbox_left_pos
.byte clearbox_top_pos
.byte clearbox_width
.byte clearbox_height
.endmacro

.macro showpokepic, showpokepic_species, showpokepic_x, showpokepic_y
.byte 0x75
.halfword showpokepic_species
.byte showpokepic_x
.byte showpokepic_y
.endmacro

.macro hidepokepic
.byte 0x76
.endmacro

.macro showcontestwinner, showcontestwinner_byte
.byte 0x77
.byte showcontestwinner_byte
.endmacro

.macro braille, braille_text
.byte 0x78
.word braille_text
.endmacro

.macro givepokemon, givepokemon_species, givepokemon_level, givepokemon_item, givepokemon_unknown1, givepokemon_unknown2, givepokemon_unknown3
.byte 0x79
.halfword givepokemon_species
.byte givepokemon_level
.halfword givepokemon_item
.word givepokemon_unknown1
.word givepokemon_unknown2
.byte givepokemon_unknown3
.endmacro

.macro giveegg, giveegg_species
.byte 0x7A
.halfword giveegg_species
.endmacro

.macro setpkmnpp, setpkmnpp_party_slot, setpkmnpp_attk_slot, setpkmnpp_amount, setpkmnmove
.byte 0x7B
.byte setpkmnpp_party_slot
.byte setpkmnpp_attk_slot
.byte setpkmnpp_new_attk
.endmacro

.macro checkattack, checkattack_attack
.byte 0x7C
.halfword checkattack_attack
.endmacro

.macro bufferpokemon, bufferpokemon_buffer, bufferpokemon_species
.byte 0x7D
.byte bufferpokemon_buffer
.halfword bufferpokemon_species
.endmacro

.macro bufferfirstpokemon, bufferfirstpokemon_buffer
.byte 0x7E
.byte bufferfirstpokemon_buffer
.endmacro

.macro bufferpartypokemon, bufferpartypokemon_buffer, bufferpartypokemon_slot
.byte 0x7F
.byte bufferpartypokemon_buffer
.halfword bufferpartypokemon_slot
.endmacro

.macro bufferitem, bufferitem_buffer, bufferitem_item
.byte 0x80
.byte bufferitem_buffer
.halfword bufferitem_item
.endmacro

.macro bufferdecoration, bufferdecoration_buffer, bufferdecoration_decoration
.byte 0x81
.byte bufferdecoration_buffer
.halfword bufferdecoration_decoration
.endmacro

.macro bufferattack, bufferattack_buffer, bufferattack_attack
.byte 0x82
.byte bufferattack_buffer
.halfword bufferattack_attack
.endmacro

.macro buffernumber, buffernumber_buffer, buffernumber_number
.byte 0x83
.byte buffernumber_buffer
.halfword buffernumber_number
.endmacro

.macro bufferstd, bufferstd_buffer, bufferstd_string
.byte 0x84
.byte bufferstd_buffer
.halfword bufferstd_string
.endmacro

.macro bufferstring, bufferstring_buffer, bufferstring_pointer
.byte 0x85
.byte bufferstring_buffer
.halfword bufferstring_pointer
.endmacro

.macro pokemart, pokemart_pointer
.byte 0x86
.word pokemart_pointer
.endmacro

.macro pokemart2, pokemart2_pointer
.byte 0x87
.word pokemart2_pointer
.endmacro

.macro pokemart3, pokemart3_pointer
.byte 0x88
.word pokemart3_pointer
.endmacro

.macro pokecasino, pokecasino_param1
.byte 0x89
.halfword pokecasino_param1
.endmacro

.macro createplantedberry, plantID, berryID, berryState
.byte 0x8A
.byte plantID
.byte berryID
.byte berryState
.endmacro

.macro choosecontestpokemon
.byte 0x8B
.endmacro

.macro startcontest
.byte 0x8C
.endmacro

.macro showcontestresults
.byte 0x8D
.endmacro

.macro contestlinktransfer
.byte 0x8E
.endmacro

.macro random, random_limit
.byte 0x8F
.halfword random_limit
.endmacro

.macro givemoney, givemoney_value, givemoney_byte
.byte 0x90
.word givemoney_value
.byte givemoney_byte
.endmacro

.macro paymoney, paymoney_value, paymoney_byte
.byte 0x91
.word paymoney_value
.byte paymoney_byte
.endmacro

.macro checkmoney, checkmoney_value, checkmoney_byte
.byte 0x92
.word checkmoney_value
.byte checkmoney_byte
.endmacro

.macro showmoney, showmoney_x, showmoney_y
.byte 0x93
.byte showmoney_x
.byte showmoney_y
.endmacro

.macro hidemoney, hidemoney_x, hidemoney_y
.byte 0x94
.byte hidemoney_x
.byte hidemoney_y
.endmacro

.macro updatemoney, updatemoney_x, updatemoney_y
.byte 0x95
.byte updatemoney_x
.byte updatemoney_y
.endmacro

.macro checkpokenewsfor, reportID
.byte 0x96
.halfword reportID
.endmacro

.macro fadescreen, fadescreen_effect
.byte 0x97
.byte fadescreen_effect
.endmacro

.macro fadescreendelay, fadescreendelay_effect, fadescreendelay_time
.byte 0x98
.byte fadescreendelay_effect
.byte fadescreendelay_time
.endmacro

.macro darken, darken_size
.byte 0x99
.halfword darken_size
.endmacro

.macro lighten, lighten_size
.byte 0x9A
.byte lighten_size
.endmacro

.macro preparmsg2, preparemsg2_pointer
.byte 0x9B
.word preparemsg2_pointer
.endmacro

.macro doanimation, doanimation_param
.byte 0x9C
.halfword doanimation_param
.endmacro

.macro setanimation, setanimation_anim, setanimation_slot
.byte 0x9D
.byte setanimation_anim
.halfword setanimation_slot
.endmacro

.macro checkanimation, checkanimation_param
.byte 0x9E
.halfword checkanimation_param
.endmacro

.macro sethealingplace, sethealingplace_param
.byte 0x9F
.halfword sethealingplace_param
.endmacro

.macro checkgender
.byte 0xA0
.endmacro

.macro cry, cry_species, cry_effect
.byte 0xA1
.halfword cry_species
.halfword cry_effect
.endmacro

.macro setmaptile, setmaptile_x, setmaptile_y, setmaptile_tile, setmaptile_attrib
.byte 0xA2
.halfword setmaptile_x
.halfword setmaptile_y
.halfword setmaptile_tile
.halfword setmaptile_attrib
.endmacro

.macro resetweather
.byte 0xA3
.endmacro

.macro setweather,setweather_type
.byte 0xA4
.halfword setweather_type
.endmacro

.macro doweather
.byte 0xA5
.endmacro

.macro activate_per_step_task,caseID
.byte 0xA6
.byte caseID
.endmacro

.macro setmapfooter, setmapfooter_param
.byte 0xA7
.halfword setmapfooter_param
.endmacro

.macro spritelevelup, spritelevelup_person, spritelevelup_bank, spritelevelup_map, spritelevelup_unknown
.byte 0xA8
.halfword spritelevelup_person
.byte spritelevelup_bank
.byte spritelevelup_map
.byte spritelevelup_unknown
.endmacro

.macro restorespritelevel, restorespritelevel_person, restorespritelevel_bank, restorespritelevel_map
.byte 0xA9
.halfword restorespritelevel_person
.byte restorespritelevel_bank
.byte restorespritelevel_map
.endmacro

.macro createsprite, createsprite_sprite, createsprite_person, createsprite_x, createsprite_y, createsprite_behave, createsprite_face
.byte 0xAA
.byte createsprite_sprite
.byte createsprite_person
.halfword createsprite_x
.halfword createsprite_y
.byte createsprite_behave
.byte createsprite_face
.endmacro

.macro spriteface2, spriteface2_person, spriteface2_face
.byte 0xAB
.byte spriteface2_person
.byte spriteface2_face
.endmacro

.macro setdooropened, setdooropened_x, setdooropened_y
.byte 0xAC
.halfword setdooropened_x
.halfword setdooropened_y
.endmacro

.macro setdoorclosed, setdoorclosed_x, setdoorclosed_y
.byte 0xAD
.halfword setdoorclosed_x
.halfword setdoorclosed_y
.endmacro

.macro doorchange
.byte 0xAE
.endmacro

.macro setdooropened2, setdooropened2_x, setdooropened2_y
.byte 0xAF
.halfword setdooropened2_x
.halfword setdooropened2_y
.endmacro

.macro setdoorclosed2, setdoorclosed2_x, setdoorclosed2_y
.byte 0xB0
.halfword setdoorclosed2_x
.halfword setdoorclosed2_y
.endmacro

.macro cmdB1
.byte 0xB1
.endmacro

.macro checkcoins, checkcoins_var
.byte 0xB3
.halfword checkcoins_var
.endmacro

.macro givecoins, givecoins_param
.byte 0xB4
.halfword givecoins_param
.endmacro

.macro removecoins, removecoins_param
.byte 0xB5
.halfword removecoins_param
.endmacro

.macro setwildbattle, setwildbattle_species, setwildbattle_level, setwildbattle_item
.byte 0xB6
.halfword setwildbattle_species
.byte setwildbattle_level
.halfword setwildbattle_item
.endmacro

.macro dowildbattle
.byte 0xB7
.endmacro

.macro setvirtualaddress, setvirtualaddress_param
.byte 0xB8
.word setvirtualaddress_param
.endmacro

.macro virtualgoto, virtualgoto_pointer
.byte 0xB9
.word virtualgoto_pointer
.endmacro

.macro virtualcall, virtualcall_pointer
.byte 0xBA
.word virtualcall_pointer
.endmacro

.macro virtualgotoif, virtualgotoif_condition, virtualgotoif_pointer
.byte 0xBB
.byte virtualgotoif_condition
.word virtualgotoif_pointer
.endmacro

.macro virtualcallif, virtualcallif_condition, virtualcallif_pointer
.byte 0xBC
.byte virtualcallif_condition
.word virtualcallif_pointer
.endmacro

.macro virtualmsgbox, virtualmsgbox_text
.byte 0xBD
.word virtualmsgbox_text
.endmacro

.macro virtualloadpointer, virtualloadpointer_pointer
.byte 0xBE
.word virtualloadpointer_pointer
.endmacro

.macro virtualbuffer, virtualbuffer_buffer, virtualbuffer_pointer
.byte 0xBF
.byte virtualbuffer_buffer
.word virtualbuffer_pointer
.endmacro

.macro showcoins, showcoins_x, showcoins_y
.byte 0xC0
.byte showcoins_x
.byte showcoins_y
.endmacro

.macro hidecoins, hidecoins_x, hidecoins_y
.byte 0xC1
.byte hidecoins_x
.byte hidecoins_y
.endmacro

.macro updatecoins, updatecoins_x, updatecoins_y
.byte 0xC2
.byte updatecoins_x
.byte updatecoins_y
.endmacro

.macro  increment_encrypted_counter, counterID
.byte 0xC3
.byte counterID
.endmacro

.macro warp6, warp6_bank, warp6_map, warp6_warp, warp6_x, warp6_y
.byte 0xC4
.byte warp6_bank
.byte warp6_map
.byte warp6_warp
.halfword warp6_x
.halfword warp6_y
.endmacro

.macro waitcry
.byte 0xC5
.endmacro

.macro bufferboxname, bufferboxname_buffer, bufferboxname_box
.byte 0xC6
.byte bufferboxname_buffer
.halfword bufferboxname_box
.endmacro

//.macro textcolor, textcolor_byte, nopC7
//.byte 0xC7
//.byte textcolor_byte Uncomment if FR.
//.endmacro

.macro cmdC8, cmdC8_param
.byte 0xC8
.word cmdC8_param
.endmacro

.macro cmdC9
.byte 0xC9
.endmacro

.macro signmsg
.byte 0xCA
.endmacro

.macro normalmsg
.byte 0xCB
.endmacro

//.macro comparehiddenvar, comparehiddenvar_byte, comparehiddenvar_value, nopCC
//.byte 0xCC
//.byte comparehiddenvar_byte Uncomment if FR.
//.word comparehiddenvar_value
//.endmacro

.macro setobedience, setobedience_slot
.byte 0xCD
.halfword setobedience_slot
.endmacro

.macro checkobedience, checkobedience_slot
.byte 0xCE
.halfword checkobedience_slot
.endmacro

.macro executeram
.byte 0xCF
.endmacro

//.macro setworldmapflag, setworldmapflag_param, nopD0
//.byte 0xD0
//.halfword setworldmapflag_param uncomment if FR.
//.endmacro

.macro warpteleport2
.byte 0xD1
.endmacro

.macro setcatchlocation, setcatchlocation_slot, setcatchlocation_map
.byte 0xD2
.halfword setcatchlocation_slot
.byte setcatchlocation_map
.endmacro

.macro braille2, braille2_text
.byte 0xD3
.word braille2_text
.endmacro

.macro bufferitems, bufferitems_buffer, bufferitems_item, bufferitems_amount
.byte bufferitems_buffer
.halfword bufferitems_item
.halfword bufferitems_amount
.endmacro

.macro cmdD5
.byte 0xD5
.endmacro

.macro cmdD6
.byte 0xD6
.endmacro

.macro warp7, warp7_bank, warp7_map, warp7_warp, warp7_x, warp7_y
.byte 0xD7
.byte warp7_bank
.byte warp7_map
.byte warp7_warp
.halfword warp7_x
.halfword warp7_y
.endmacro

.macro cmdD8
.byte 0xD8
.endmacro

.macro cmdD9
.byte 0xD9
.endmacro

.macro hidebox2
.byte 0xDA
.endmacro

.macro preparemsg3, preparemsg3_pointer
.byte 0xDB
.word preparemsg3_pointer
.endmacro

.macro fadescreen3, fadescreen3_param
.byte 0xDC
.byte fadescreen3_param
.endmacro

.macro buffertrainerclass, buffertrainerclass_buffer, buffertrainerclass_class
.byte 0xDD
.byte buffertrainerclass_buffer
.halfword buffertrainerclass_class
.endmacro

.macro buffertrainername, buffertrainername_buffer, buffertrainername_trainer
.byte 0xDE
.byte buffertrainername_buffer
.halfword buffertrainername_trainer
.endmacro

.macro pokenavcall, pokenavcall_text
.byte 0xDF
.word pokenavcall_text
.endmacro

.macro warp8, warp8_bank, warp8_map, warp8_warp, warp8_x, warp8_y
.byte 0xE0
.byte warp8_bank
.byte warp8_map
.byte warp8_warp
.halfword warp8_x
.halfword warp8_y
.endmacro

.macro buffercontesttype, buffercontesttype_param1, buffercontesttype_param2
.byte 0xE1
.byte buffercontesttype_param1
.halfword buffercontesttype_param2
.endmacro

.macro bufferitems2, bufferitems2_buffer, bufferitems2_item, bufferitems2_amount
.byte 0xE2
.byte bufferitems2_buffer
.halfword bufferitems2_item
.halfword bufferitems2_amount
.endmacro