local Screen = Level:extend()

function Screen:activate()
	--- shape value
	-- Cuboid
	local cZ = 200
	local cLenZ = 25
	-- Rect
	local reLenX = Base.gui.width-50
	local reLenY = Base.gui.height/2
	local reDir = math.pi/20
	local reZBorder = 75
	local reX = Base.gui.width - math.cos(reDir)*reLenX
	local reY = 0-reLenY
	local reZ = 70
	-- Ball
	local bR = 20
	local bX = Base.gui.width/8
	local bY = Base.gui.height/6
	local bZ = 0
	-- Laser
	local tX1 = 0
	local tSY1 = Base.gui.height/Base.gui.width
	local tX2 = Base.gui.width/3
	local tSY2 = Base.gui.height/(Base.gui.width/3)

	-- levelName
	local levelName = Lang.level_OneShot
	-- player location
	local playerX = 20
	local playerY = Base.gui.height/2-Base.player.len/2
	local playerZ = cZ-1
	-- endCube location
	local endCubeX = Base.gui.width-playerX-Base.lenEndCube
	local endCubeY = Base.gui.height/2-Base.lenEndCube/2
	local endCubeZ = -Base.lenEndCube
	-- create player and endCube
	local playerPosition = Base.createPosition(playerX, playerY, playerZ)
	local endCubePosition = Base.createPosition(endCubeX, endCubeY, endCubeZ)
	Screen.super.activate(self, playerPosition, endCubePosition, levelName)

	--- here to create shape
	-- floor
	self:addShape(Cuboid,		0, 0, cZ,				Base.gui.width+2, Base.gui.height+2, cLenZ)
	-- rect
	self:addShape(Rect,	Base.gui.width-reX, Base.gui.height+2, reZ,			reLenX, reLenY, 		 -math.pi+reDir)
	self:addShape(Rect,	reX, reY-2, reZ+reZBorder,							reLenX, reLenY, 		 -reDir)
	-- ball
	self:addShape(Ball,		bX, bY, bZ,												bR)
	self:addShape(Ball,		Base.gui.width-bX, Base.gui.height-bY, bZ+reZBorder,		bR)
	--ball to be wall
	self:addShape(Ball,		tX2, Base.gui.height/2, cZ-bR,							bR)
	self:addShape(Ball,		Base.gui.width-tX2, Base.gui.height/2, cZ-bR,				bR)
	-- laser
	self:addShape(Laser,		tX1, 0, 0,					1, tSY1, 1)
	self:addShape(Laser,		tX2, 0, 0,					1, tSY2, 1)
	self:addShape(Laser,		tX1, Base.gui.height, 0,		1, -tSY1, 1)
	self:addShape(Laser,		tX2, Base.gui.height, 0,		1, -tSY2, 1)
end

return Screen