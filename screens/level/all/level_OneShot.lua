local Screen = Level:extend()

function Screen:activate()
	--- shape value
	-- Cuboid
	local cZ = 200
	local cLenZ = 25
	-- Rectangle
	local reLenX = base.guiWidth-50
	local reLenY = base.guiHeight/2
	local reDir = math.pi/20
	local reZBorder = 75
	local reX = base.guiWidth - math.cos(reDir)*reLenX
	local reY = 0-reLenY
	local reZ = 70
	-- Ball
	local bR = 20
	local bX = base.guiWidth/8
	local bY = base.guiHeight/6
	local bZ = 0
	-- Laser
	local tX1 = 0
	local tSY1 = base.guiHeight/base.guiWidth
	local tX2 = base.guiWidth/3
	local tSY2 = base.guiHeight/(base.guiWidth/3)
	
	-- levelName
	local levelName = lang.level_OneShot
	-- player location
	local playerX = 20
	local playerY = base.guiHeight/2-base.player.len/2
	local playerZ = cZ-1
	-- destination location
	local destinationX = base.guiWidth-playerX-base.lenDestination
	local destinationY = base.guiHeight/2-base.lenDestination/2
	local destinationZ = -base.lenDestination
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	-- floor
	self:addShapeList(Cuboid,		0, 0, cZ,				base.guiWidth+2, base.guiHeight+2, cLenZ)
	-- rectangle
	self:addShapeList(Rectangle,	base.guiWidth-reX, base.guiHeight+2, reZ,			reLenX, reLenY, 		 -math.pi+reDir)
	self:addShapeList(Rectangle,	reX, reY-2, reZ+reZBorder,							reLenX, reLenY, 		 -reDir)
	-- ball
	self:addShapeList(Ball,		bX, bY, bZ,												bR)
	self:addShapeList(Ball,		base.guiWidth-bX, base.guiHeight-bY, bZ+reZBorder,		bR)
	--ball to be wall
	self:addShapeList(Ball,		tX2, base.guiHeight/2, cZ-bR,							bR)
	self:addShapeList(Ball,		base.guiWidth-tX2, base.guiHeight/2, cZ-bR,				bR)
	-- laser
	self:addShapeList(Laser,		tX1, 0, 0,					1, tSY1, 1)
	self:addShapeList(Laser,		tX2, 0, 0,					1, tSY2, 1)
	self:addShapeList(Laser,		tX1, base.guiHeight, 0,		1, -tSY1, 1)
	self:addShapeList(Laser,		tX2, base.guiHeight, 0,		1, -tSY2, 1)
end

return Screen