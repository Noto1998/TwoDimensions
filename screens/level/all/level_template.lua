local Screen = Level:extend()

function Screen:activate()
	--- shape vnlue
	---

	-- levelName
	local levelName = ""
	-- player location
	local playerX = 0
	local playerY = 0
	local playerZ = 0
	-- endCube location
	local endCubeX = 0
	local endCubeY = 0
	local endCubeZ = 0
	-- create player and endCube
	Screen.super.activate(self, playerX, playerY, playerZ, endCubeX, endCubeY, endCubeZ, levelName)

	--- here to create shape
	-- use [ self:addShape(...) ] to create shape.
	-- e.g. self:addShape(Cuboid, 0, 0, 0, 50, 50, 50)

	-- Rectangle,	x, y, z, lenX, lenY, radian(0 ~ -math.pi)
	-- Cuboid,		x, y, z, lenX, lenY, lenZ
	-- Laser,		x, y, z, sx(0 ~ 1), sy(0 ~ 1), sz(0 ~ 1)
	-- FourD,		x, y, z, lenX, lenY
	-- MoveCuboid,	x, y, z, lenX, lenY, lenZ, x_to_move, y_to_move, z_to_move
	-- ConPolygon,	x, y, z, num

	--- here to create tips
	-- self:addTipsList(string, x, y, z [, xMode][, yMode])
end

return Screen