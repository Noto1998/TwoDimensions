local Screen = Level:extend()

function Screen:activate()
	--- shape value
	-- Rectangle
	local reZ = 100
	local reLenX = Base.guiWidth-75
	local reLenY = Base.guiHeight/2
	local reDir = math.pi/18
	local reBorder = 80
	-- Ball
	local bR = 20
	---

	-- levelName
	local levelName = Lang.level_DonkeyKong
	-- player location
	local playerX = Base.guiWidth/2-Base.player.len/2
	local playerY = Base.guiHeight/4*3-Base.player.len/2
	local playerZ = 100
	-- destination location
	local destinationX = Base.guiWidth-Base.lenDestination
	local destinationY = Base.guiHeight/4*3-Base.lenDestination/2
	local destinationZ = Base.guiHeight+10
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	self:addShapeList(Ball,		Base.guiWidth-reBorder, Base.guiHeight/4, 0,			bR)

	self:addShapeList(Rectangle, reBorder, 0, reZ,								reLenX, reLenY,			-reDir)
	self:addShapeList(Rectangle, Base.guiWidth-reBorder, reLenY, reZ+50,		reLenX, reLenY, 		-math.pi+reDir)
end

return Screen