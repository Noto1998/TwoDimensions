local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local border = 40
	local cubeZ = base.guiHeight/2
	local cubeLenX = base.guiWidth-border*2
	local cubeLenY = base.guiHeight-border*2
	local cubeLenZ = 50
	---
	
	-- levelName
	local levelName = lang.level_Tutorial_Move
	-- player location
	local playerX = 80-base.player.len/2
	local playerY = base.guiHeight/2-base.player.len/2
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = base.guiWidth-playerX-base.lenDestination
	local destinationY = playerY
	local destinationZ = -base.lenDestination-10
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName, true)--Tutorial
	
	--- here to create shape
	self:addShapeList(Cuboid,		border, border, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)

	--- here to create tips
	self:addTipsList(lang.tips_use_arrows_to_move,		base.guiBorder, base.guiHeight/2+40, playerZ-50)
	self:addTipsList(lang.tips_touch_the_green_goal,	base.guiWidth-base.guiBorder, base.guiHeight/2-40, destinationZ-50, "right", "bottom")
	self:addTipsList(lang.tips_wait_not_teach_yet,		base.guiWidth/2, 300, base.guiHeight/2+50, "center", "center")
end


return Screen