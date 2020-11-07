local Lang = {}


-- ui
function Lang.ui_level_choice(Num, Name)	return '<\tlevel ' .. Num .. ' ' .. Name .. '\t>'	end
Lang.ui_key_start_and_move	= '←→ selct\tA start'
Lang.ui_key_keyTips			= 'X control tips'
Lang.ui_player_stuck		= 'player stuck'
Lang.ui_level_finish		= 'level finish!'
Lang.ui_key_continue		= 'A continue'
Lang.ui_key_credits			= 'Y go MainMenu'
Lang.ui_key_keyTipsList = {
	'\tArrows - Move\t\t',
	'\tY - Shift Dimensions\t\t',
	'\tStart - Reset Level\t\t',
	'\tSelect - ♫Off/On\t\t',
	'\tB(hold) - go MainMenu\t\t'
}
Lang.ui_thank_you_for_playing = 'Thank you for playing!'
Lang.ui_credits = {
	'design|level\tYaolaotou',
	'code|art|music|level\tNoto',
	'translate\tHannibal',
}


--level
Lang.level_BlockLaser          = 'Block'
Lang.level_Contour             = 'Contour'
Lang.level_Cross               = 'Cross'
Lang.level_CrossTheRiver       = 'Cross The River'
Lang.level_DonkeyKong          = 'Donkey Kong'
Lang.level_Invisible           = 'Invisible'
Lang.level_OneShot             = 'OneShot'
Lang.level_RockClimbing        = 'Rock Climbing'
Lang.level_Skull               = 'Skull'
Lang.level_StandStraight       = 'Stand Straight'
Lang.level_SuperLaser          = 'Mission Impossible'
Lang.level_Tunnel              = 'Tunnel'
Lang.level_Tutorial_Ball       = 'Rolling Stones'
Lang.level_Tutorial_Move       = 'Tutorial'
Lang.level_Tutorial_MoveCuboid = 'Need For Speed'
Lang.level_Tutorial_Laser      = 'Bit The Dust'


-- tips
Lang.tips_use_arrows_to_move     = 'use arrows to move'
Lang.tips_touch_the_green_goal   = 'green is goal'
Lang.tips_wait_not_teach_yet     = 'i didnt teach that yet'
Lang.tips_mayoiba_yabureru       = 'mayoiba yabureru'
Lang.tips_save_us                = 'SAVE US'
Lang.tips_congratulations        = 'mission accomplished'
Lang.tips_pressed_Y_to_shift     = 'Y shift dimensions'
Lang.tips_left_and_right_to_move = '←→ move'
Lang.tips_yellow_means_danger    = 'yellow means danger'


-- ending dialogue
Lang.tips_conPolygon = {
	'Congratulations',
	'time to your ending',
	'just like your kind'
}
Lang.tips_polygon = {
	'you didn\'t fall into their trap',
	'they don\'t believe in circle',
	'concave shap got SHIFT first',
	'same as you have',
	'we plan to get out',
	'get ready',
	'pressed Y'
}


return Lang