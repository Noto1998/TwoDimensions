local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local reLenX = Base.guiWidth-1*2
	local reLenY = 100
	local reLenZ = 50
	local reX = Base.guiWidth
	local reY = Base.guiHeight/2-reLenY/2
	local reZ = Base.guiHeight-50
	-- Ball
	local bR = 20
	---
	
	-- levelName
	local levelName = Lang.level_Tutorial_Ball
	-- player location
	local playerX = Base.guiWidth/4
	local playerY = Base.guiHeight/2-Base.player.len/2
	local playerZ = 50
	-- destination location
	local destinationX = Base.guiWidth-50/2
	local destinationY = Base.guiWidth+50
	local destinationZ = reZ-50
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	self:addShapeList(Rectangle,	reX, reY, reZ,		reLenX, reLenY,		-math.pi+math.pi/10)
	self:addShapeList(Cuboid,		Base.guiWidth/2-25/2, reY, 1,		25, reLenY, 25)
	self:addShapeList(Ball,			bR, Base.guiHeight/2, 50,			bR)
end

return Screen