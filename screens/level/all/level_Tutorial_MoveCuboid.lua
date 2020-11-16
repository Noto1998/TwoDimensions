local Screen = Level:extend()

local player

function Screen:activate()
	-- levelName
	local levelName = Lang.level_Tutorial_MoveCuboid
	-- player location
	local playerX = 20
	local playerY = Base.gui.height/2-Base.player.len/2
	local playerZ = 100
	-- endCube location
	local endCubeX = 200+20
	local endCubeY = Base.gui.height/2-Base.lenEndCube/2
	local endCubeZ = 200+20
	-- create player and endCube
	local playerPosition = Base.createPosition(playerX, playerY, playerZ)
	local endCubePosition = Base.createPosition(endCubeX, endCubeY, endCubeZ)
	Screen.super.activate(self, playerPosition, endCubePosition, levelName)

	--- here to create shape
	self:addShape(Rectangle,	200, 0, 200,											500, 500, -math.pi + math.pi / 8)
	self:addShape(MoveCuboid,	120, Base.gui.height/2-50/2, 100,						50, 50, 50)
	self:addShape(Laser,		100, Base.gui.height/2, 20,								-0.5, -1, 1)
end


return Screen