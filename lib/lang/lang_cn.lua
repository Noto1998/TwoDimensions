local lang = {}


-- ui
function lang.ui_level_choice(Num, Name)	return "<\t第" .. Num .. "关 " .. Name .. "\t>"	end
lang.ui_key_start_and_move	= "←→ 选择\tA 开始"
lang.ui_key_keyTips			= "X 按键说明"
lang.ui_player_stuck		= "玩家卡住"
lang.ui_level_finish		= "关卡完成！"
lang.ui_key_continue		= "A 继续"
lang.ui_key_credits			= "Y 返回主界面"
lang.ui_key_keyTipsList = {
	"\t方向键 - 移动\t\t",
	"\tY - 维度切换\t\t",
	"\tStart - 重置关卡\t\t",
	"\tSelect - 音乐开关\t\t",
	"\tB(长按) - 返回主界面\t\t"
}
lang.ui_thank_you_for_playing = "感谢游玩！"
lang.ui_credits = {
	"策划|关卡\tYaolaotou",
	"程序|美术|音乐|关卡\tNoto",
	"翻译♥特别感谢\tHannibal",
}


-- level
lang.level_BlockLaser		= "我来挡住"
lang.level_Contour			= "等高线"
lang.level_Cross			= "十字架"
lang.level_CrossTheRiver	= "过河"
lang.level_DonkeyKong		= "大金刚"
lang.level_Invisible		= "隐形"
lang.level_OneShot			= "一次机会"
lang.level_RockClimbing		= "攀岩"
lang.level_Skull			= "骷髅"
lang.level_StandStraight	= "站直"
lang.level_SuperLaser		= "不可能的任务"
lang.level_Tunnel			= "隧道"
lang.level_Tutorial_Ball	= "滚石"
lang.level_Tutorial_Move	= "教学"
lang.level_Tutorial_MoveCuboid = "速度的活儿"
lang.level_Tutorial_Laser	= "败者食尘"


-- tips
lang.tips_use_arrows_to_move	= "方向键 移动"
lang.tips_touch_the_green_goal	= "绿色 是 终点"
lang.tips_wait_not_teach_yet	= "我还没教你这招"
lang.tips_mayoiba_yabureru		= "犹豫就会败北"
lang.tips_save_us				= "救救我们"
lang.tips_congratulations		= "你完成了任务"
lang.tips_pressed_Y_to_shift	= "Y 切换维度"
lang.tips_left_and_right_to_move = "←→ 移动"
lang.tips_yellow_means_danger 	= "黄色 很危险"


-- ending dialogue
lang.tips_conPolygon = {
	"恭喜你到达了这里",
	"该迎接你的结局了",
	"就像你的同胞一样"
}
lang.tips_polygon = {
	"你没中他们的陷阱 好样的",
	"凹多边形不相信圆",
	"他们最先得到了SHIFT",
	"和你拥有的一样",
	"我们要逃出去",
	"做好准备",
	"按下Y"
}


return lang