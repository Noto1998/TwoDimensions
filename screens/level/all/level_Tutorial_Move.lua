local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local border = 40
	local cubeZ = Base.gui.height/2
	local cubeLenX = Base.gui.width-border*2
	local cubeLenY = Base.gui.height-border*2
	local cubeLenZ = 50
	---

	-- levelName
	local levelName = Lang.level_Tutorial_Move
	-- player location
	local playerX = 80-Base.player.len/2
	local playerY = Base.gui.height/2-Base.player.len/2
	local playerZ = cubeZ - 1
	-- endCube location
	local endCubeX = Base.gui.width-playerX-Base.lenEndCube
	local endCubeY = playerY
	local endCubeZ = -Base.lenEndCube-10
	-- create player and endCube
	Screen.super.activate(self, playerX, playerY, playerZ, endCubeX, endCubeY, endCubeZ, levelName, true)--Tutorial

	--- here to create shape
	self:addShape(Cuboid,		border, border, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)

	--- here to create tips
	self:addTipsList(Lang.tips_use_arrows_to_move,		Base.gui.border, Base.gui.height/2+40, playerZ-50)
	self:addTipsList(Lang.tips_touch_the_green_goal,	Base.gui.width-Base.gui.border, Base.gui.height/2-40, endCubeZ-50, "right", "bottom")
	self:addTipsList(Lang.tips_wait_not_teach_yet,		Base.gui.width/2, 300, Base.gui.height/2+50, "center", "center")
end


return Screen