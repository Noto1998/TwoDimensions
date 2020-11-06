local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local reLenX = base.guiWidth-1*2
	local reLenY = 100
	local reLenZ = 50
	local reX = base.guiWidth
	local reY = base.guiHeight/2-reLenY/2
	local reZ = base.guiHeight-50
	-- Ball
	local bR = 20
	---
	
	-- levelName
	local levelName = lang.level_Tutorial_Ball
	-- player location
	local playerX = base.guiWidth/4
	local playerY = base.guiHeight/2-base.player.len/2
	local playerZ = 50
	-- destination location
	local destinationX = base.guiWidth-50/2
	local destinationY = base.guiWidth+50
	local destinationZ = reZ-50
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	self:addShapeList(Rectangle,	reX, reY, reZ,		reLenX, reLenY,		-math.pi+math.pi/10)
	self:addShapeList(Cuboid,		base.guiWidth/2-25/2, reY, 1,		25, reLenY, 25)
	self:addShapeList(Ball,			bR, base.guiHeight/2, 50,			bR)
end

return Screen