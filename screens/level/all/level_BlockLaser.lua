local Screen = Level:extend()

function Screen:activate()
	-- Cuboid
	local cLenX = 40*2
	local cLenY = Base.gui.height*1.5
	local cLenZ = 50
	local cX = Base.gui.width/2 -cLenX/2
	local cY = -30
	local cZ = Base.gui.height-cLenZ
	-- Ball
	local bR = 20

	-- levelName
	local levelName = Lang.level_BlockLaser
	-- player location
	local playerX = Base.gui.width/2-Base.player.len/2
	local playerY = -25
	local playerZ = 150
	-- endCube location
	local endCubeX = Base.gui.width/2-Base.lenEndCube/2
	local endCubeY = Base.gui.height-5
	local endCubeZ = -Base.lenEndCube
	-- create player and endCube
	local playerPosition = Base.createPosition(playerX, playerY, playerZ)
	local endCubePosition = Base.createPosition(endCubeX, endCubeY, endCubeZ)
	Screen.super.activate(self, playerPosition, endCubePosition, levelName)

	--- here to create shape
	-- floor
	self:addShape(Cuboid,		cX, cY, cZ,		cLenX, cLenY, cLenZ)
	self:addShape(Rectangle,	Base.gui.width, Base.gui.height+10, 150,		Base.gui.width+40, Base.gui.height/2, 		 -math.pi+math.pi/10)
	self:addShape(Ball,			bR, 80, 0,		bR)
	self:addShape(Laser,		Base.gui.width/2, 1, 1,		0, 1, 1)
end

return Screen