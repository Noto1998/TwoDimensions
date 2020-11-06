local Screen = Level:extend()

local player

function Screen:activate()
	-- levelName
	local levelName = lang.level_Tutorial_MoveCuboid
	-- player location
	local playerX = 20
	local playerY = base.guiHeight/2-base.player.len/2
	local playerZ = 100
	-- destination location
	local destinationX = 200+20
	local destinationY = base.guiHeight/2-base.lenDestination/2
	local destinationZ = 200+20
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	self:addShapeList(Rectangle,	200, 0, 200,											500, 500, -math.pi+math.pi/8)
	self:addShapeList(MoveCuboid,	120, base.guiHeight/2-50/2, 100,						50, 50, 50, 		300)
	self:addShapeList(Laser,		100, base.guiHeight/2, 20,								-0.5, -1, 1)
end


return Screen