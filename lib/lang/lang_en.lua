local lang = {}


-- ui
function lang.ui_level_choice(Num, Name)	return "<\tlevel " .. Num .. " " .. Name .. "\t>"	end
lang.ui_key_start_and_move	= "←→ selct\tA start"
lang.ui_key_keyTips			= "X control tips"
lang.ui_player_stuck		= "player stuck"
lang.ui_level_finish		= "level finish!"
lang.ui_key_continue		= "A continue"
lang.ui_key_credits			= "Y go MainMenu"
lang.ui_key_keyTipsList = {
	"\tArrows - Move\t\t",
	"\tY - Shift Dimensions\t\t",
	"\tStart - Reset Level\t\t",
	"\tSelect - ♫Off/On\t\t",
	"\tB(hold) - go MainMenu\t\t"
}
lang.ui_thank_you_for_playing = "Thank you for playing!"
lang.ui_credits = {
	"design|level\tYaolaotou",
	"code|art|music|level\tNoto",
	"translate\tHannibal",
}


--level
lang.level_BlockLaser		= "Block"
lang.level_Contour			= "Contour"
lang.level_Cross			= "Cross"
lang.level_CrossTheRiver	= "Cross The River"
lang.level_DonkeyKong		= "Donkey Kong"
lang.level_Invisible		= "Invisible"
lang.level_OneShot			= "OneShot"
lang.level_RockClimbing 	= "Rock Climbing"
lang.level_Skull			= "Skull"
lang.level_StandStraight	= "Stand Straight"
lang.level_SuperLaser		= "Mission Impossible"
lang.level_Tunnel			= "Tunnel"
lang.level_Tutorial_Ball	= "Rolling Stones"
lang.level_Tutorial_Move	= "Tutorial"
lang.level_Tutorial_MoveCuboid = "Need For Speed"
lang.level_Tutorial_Laser	= "Bit The Dust"


-- tips
lang.tips_use_arrows_to_move 	= "use arrows to move"
lang.tips_touch_the_green_goal	= "green is goal"
lang.tips_wait_not_teach_yet	= "i didnt teach that yet"
lang.tips_mayoiba_yabureru		= "mayoiba yabureru"
lang.tips_save_us				= "SAVE US"
lang.tips_congratulations		= "mission accomplished"
lang.tips_pressed_Y_to_shift	= "Y shift dimensions"
lang.tips_left_and_right_to_move = "←→ move"
lang.tips_yellow_means_danger 	= "yellow means danger"


-- ending dialogue
lang.tips_conPolygon = {
	"Congratulations",
	"time to your ending",
	"just like your kind"
}
lang.tips_polygon = {
	"you didn't fall into their trap",
	"they don't believe in circle",
	"concave shap got SHIFT first",
	"same as you have",
	"we plan to get out",
	"get ready",
	"pressed Y"
}


return lang