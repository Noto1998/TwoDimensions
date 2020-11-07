local Screen = Level:extend()

function Screen:activate()
	--- shape value
	-- Cuboid
	local cZ = 200
	local cLenZ = 25
	-- Rectangle
	local reLenX = Base.guiWidth-50
	local reLenY = Base.guiHeight/2
	local reDir = math.pi/20
	local reZBorder = 75
	local reX = Base.guiWidth - math.cos(reDir)*reLenX
	local reY = 0-reLenY
	local reZ = 70
	-- Ball
	local bR = 20
	local bX = Base.guiWidth/8
	local bY = Base.guiHeight/6
	local bZ = 0
	-- Laser
	local tX1 = 0
	local tSY1 = Base.guiHeight/Base.guiWidth
	local tX2 = Base.guiWidth/3
	local tSY2 = Base.guiHeight/(Base.guiWidth/3)
	
	-- levelName
	local levelName = Lang.level_OneShot
	-- player location
	local playerX = 20
	local playerY = Base.guiHeight/2-Base.player.len/2
	local playerZ = cZ-1
	-- destination location
	local destinationX = Base.guiWidth-playerX-Base.lenDestination
	local destinationY = Base.guiHeight/2-Base.lenDestination/2
	local destinationZ = -Base.lenDestination
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	-- floor
	self:addShapeList(Cuboid,		0, 0, cZ,				Base.guiWidth+2, Base.guiHeight+2, cLenZ)
	-- rectangle
	self:addShapeList(Rectangle,	Base.guiWidth-reX, Base.guiHeight+2, reZ,			reLenX, reLenY, 		 -math.pi+reDir)
	self:addShapeList(Rectangle,	reX, reY-2, reZ+reZBorder,							reLenX, reLenY, 		 -reDir)
	-- ball
	self:addShapeList(Ball,		bX, bY, bZ,												bR)
	self:addShapeList(Ball,		Base.guiWidth-bX, Base.guiHeight-bY, bZ+reZBorder,		bR)
	--ball to be wall
	self:addShapeList(Ball,		tX2, Base.guiHeight/2, cZ-bR,							bR)
	self:addShapeList(Ball,		Base.guiWidth-tX2, Base.guiHeight/2, cZ-bR,				bR)
	-- laser
	self:addShapeList(Laser,		tX1, 0, 0,					1, tSY1, 1)
	self:addShapeList(Laser,		tX2, 0, 0,					1, tSY2, 1)
	self:addShapeList(Laser,		tX1, Base.guiHeight, 0,		1, -tSY1, 1)
	self:addShapeList(Laser,		tX2, Base.guiHeight, 0,		1, -tSY2, 1)
end

return Screen