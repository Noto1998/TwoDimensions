local Screen = Level:extend()

function Screen:activate()
	--- shape value
	-- Rectangle
	local reZ = 100
	local reLenX = base.guiWidth-75
	local reLenY = base.guiHeight/2
	local reDir = math.pi/18
	local reBorder = 80
	-- Ball
	local bR = 20
	---

	-- levelName
	local levelName = lang.level_DonkeyKong
	-- player location
	local playerX = base.guiWidth/2-base.player.len/2
	local playerY = base.guiHeight/4*3-base.player.len/2
	local playerZ = 100
	-- destination location
	local destinationX = base.guiWidth-base.lenDestination
	local destinationY = base.guiHeight/4*3-base.lenDestination/2
	local destinationZ = base.guiHeight+10
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	self:addShapeList(Ball,		base.guiWidth-reBorder, base.guiHeight/4, 0,			bR)

	self:addShapeList(Rectangle, reBorder, 0, reZ,								reLenX, reLenY,			-reDir)
	self:addShapeList(Rectangle, base.guiWidth-reBorder, reLenY, reZ+50,		reLenX, reLenY, 		-math.pi+reDir)
end

return Screen