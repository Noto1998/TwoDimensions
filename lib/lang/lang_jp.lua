local Lang = {}


-- ui
function Lang.ui_level_choice(Num, Name)	return '<\tレベル' .. Num .. ' ' .. Name .. '\t>'	end
Lang.ui_key_start_and_move	= '←→ 選ぶ\tA 開始'
Lang.ui_key_keyTips			= 'X ボタンの説明'
Lang.ui_player_stuck		= 'player stuck'
Lang.ui_level_finish		= 'ミッション完了！'
Lang.ui_key_continue		= 'A 続ける'
Lang.ui_key_credits			= 'Y メインメニューに戻る'
Lang.ui_key_keyTipsList = {
	'\t方向のボタン - 移動\t\t',
	'\tY - 次元のスイッチ\t\t',
	'\tStart - 再起動\t\t',
	'\tSelect - 音楽のスイッチ\t\t',
	'\tB(ホールド) - メインメニューに戻る\t\t'
}
Lang.ui_thank_you_for_playing = 'Thank you for playing!'
Lang.ui_credits = {
	'企画|レベル\tYaolaotou',
	'プログラム|アート|音楽|レベル\tNoto',
	'翻訳❤特別感谢\tHannibal',
}


-- level
Lang.level_BlockLaser		= '私は受け止めます'
Lang.level_Contour			= '等高線'
Lang.level_Cross			= '十字架'
Lang.level_CrossTheRiver	= '川を渡る'
Lang.level_DonkeyKong		= 'ドンキーコング'
Lang.level_Invisible		= '見えない'
Lang.level_OneShot			= '一回の機会'
Lang.level_RockClimbing		= '岩を攀じる'
Lang.level_Skull			= 'どくろ'
Lang.level_StandStraight	= '立つ'
Lang.level_SuperLaser		= 'ミッションインポッシブル'
Lang.level_Tunnel			= 'トンネル'
Lang.level_Tutorial_Ball	= 'ローリングストーンズ'
Lang.level_Tutorial_Move	= '教学'
Lang.level_Tutorial_MoveCuboid = 'ニードフォースピード'
Lang.level_Tutorial_Laser	= 'バイツァダスト'


-- tips
Lang.tips_use_arrows_to_move	= '方向のボタン 移動'
Lang.tips_touch_the_green_goal	= '緑色の ゴール'
Lang.tips_wait_not_teach_yet	= 'まだあなたにそのやり方を教えていません'
Lang.tips_mayoiba_yabureru		= '迷えば 破れる'
Lang.tips_save_us				= '助けて'
Lang.tips_congratulations		= 'mission accomplished'
Lang.tips_pressed_Y_to_shift	= 'Y 次元のスイッチ'
Lang.tips_left_and_right_to_move = '←→ 移動'
Lang.tips_yellow_means_danger 	= '黄色の 危険'


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