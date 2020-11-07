local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local border = 40
	local cubeZ = Base.guiHeight/2
	local cubeLenX = Base.guiWidth-border*2
	local cubeLenY = Base.guiHeight-border*2
	local cubeLenZ = 50
	---
	
	-- levelName
	local levelName = Lang.level_Tutorial_Move
	-- player location
	local playerX = 80-Base.player.len/2
	local playerY = Base.guiHeight/2-Base.player.len/2
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = Base.guiWidth-playerX-Base.lenDestination
	local destinationY = playerY
	local destinationZ = -Base.lenDestination-10
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName, true)--Tutorial
	
	--- here to create shape
	self:addShapeList(Cuboid,		border, border, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)

	--- here to create tips
	self:addTipsList(Lang.tips_use_arrows_to_move,		Base.guiBorder, Base.guiHeight/2+40, playerZ-50)
	self:addTipsList(Lang.tips_touch_the_green_goal,	Base.guiWidth-Base.guiBorder, Base.guiHeight/2-40, destinationZ-50, "right", "bottom")
	self:addTipsList(Lang.tips_wait_not_teach_yet,		Base.guiWidth/2, 300, Base.guiHeight/2+50, "center", "center")
end


return Screen