local lang = {}


-- ui
function lang.ui_level_choice(Num, Name)	return "<\tレベル" .. Num .. " " .. Name .. "\t>"	end
lang.ui_key_start_and_move	= "←→ 選ぶ\tA 開始"
lang.ui_key_keyTips			= "X ボタンの説明"
lang.ui_player_stuck		= "player stuck"
lang.ui_level_finish		= "ミッション完了！"
lang.ui_key_continue		= "A 続ける"
lang.ui_key_credits			= "Y メインメニューに戻る"
lang.ui_key_keyTipsList = {
	"\t方向のボタン - 移動\t\t",
	"\tY - 次元のスイッチ\t\t",
	"\tStart - 再起動\t\t",
	"\tSelect - 音楽のスイッチ\t\t",
	"\tB(ホールド) - メインメニューに戻る\t\t"
}
lang.ui_thank_you_for_playing = "Thank you for playing!"
lang.ui_credits = {
	"企画|レベル\tYaolaotou",
	"プログラム|アート|音楽|レベル\tNoto",
	"翻訳❤特別感谢\tHannibal",
}


-- level
lang.level_BlockLaser		= "私は受け止めます"
lang.level_Contour			= "等高線"
lang.level_Cross			= "十字架"
lang.level_CrossTheRiver	= "川を渡る"
lang.level_DonkeyKong		= "ドンキーコング"
lang.level_Invisible		= "見えない"
lang.level_OneShot			= "一回の機会"
lang.level_RockClimbing		= "岩を攀じる"
lang.level_Skull			= "どくろ"
lang.level_StandStraight	= "立つ"
lang.level_SuperLaser		= "ミッションインポッシブル"
lang.level_Tunnel			= "トンネル"
lang.level_Tutorial_Ball	= "ローリングストーンズ"
lang.level_Tutorial_Move	= "教学"
lang.level_Tutorial_MoveCuboid = "ニードフォースピード"
lang.level_Tutorial_Laser	= "バイツァダスト"


-- tips
lang.tips_use_arrows_to_move	= "方向のボタン 移動"
lang.tips_touch_the_green_goal	= "緑色の ゴール"
lang.tips_wait_not_teach_yet	= "まだあなたにそのやり方を教えていません"
lang.tips_mayoiba_yabureru		= "迷えば 破れる"
lang.tips_save_us				= "助けて"
lang.tips_congratulations		= "mission accomplished"
lang.tips_pressed_Y_to_shift	= "Y 次元のスイッチ"
lang.tips_left_and_right_to_move = "←→ 移動"
lang.tips_yellow_means_danger 	= "黄色の 危険"


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