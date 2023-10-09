;狩猎球后必须至少7个空格，不然显示出问题，但6个空格时已达原长度上限。
;{HIGHLIGHT}{RED}不可丢，会显示问题。
;故延后后一个文本的指针，以增加1个空格空间。
.org BattleText_SafariBalls
.strn "{HIGHLIGHT}{RED}狩猎球       $"

.org BattleText_SafariBallsLeft + 1
.strn "{HIGHLIGHT}{RED}剩余:$"

.org gMainMenuString_NewGame
.strn "新游戏$"

;盒子壁纸，可用于测试Getstringwidth函数是否正常
.org PCText_PokeCenter 
.strn "宝可梦中心$" 



/*
.org BattleText_SafariBalls
.strn "{HIGHLIGHT}{RED}SAFARI BALLS$"

.org BattleText_SafariBallsLeft
.strn "{HIGHLIGHT}{RED}Left: $"

.org gMainMenuString_NewGame
.strn "NEW GAME$"

.org PCText_PokeCenter 
.strn "POKéCENTER$"
*/