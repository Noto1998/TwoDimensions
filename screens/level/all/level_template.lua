local Screen = Level:extend()

function Screen:activate()
	-- set levelName
	local levelName = ""
	-- set player and endCube's position
	local playerPosition = Base.createPosition(0, 0, 0)
	local endCubePosition = Base.createPosition(0, 0, 0)

	Screen.super.activate(self, playerPosition, endCubePosition, levelName)

	--- here to create shape
	-- use [ self:addShape(...) ] to create shape.
	-- e.g. self:addShape(Cuboid, 0, 0, 0, 50, 50, 50)

	-- Rectangle,	position, lenX, lenY, radian(0 ~ -math.pi)
	-- Cuboid,		position, lenX, lenY, lenZ
	-- Laser,		position, scaleX, scaleY, scaleZ(0 ~ 1)
	-- FourD,		position, lenX, lenY
	-- MoveCuboid,	position, lenX, lenY, lenZ, x_to_move, y_to_move, z_to_move
	-- ConPolygon,	position, num

	--- here to create tips
	-- self:addTipsList(string, position [, xMode][, yMode])
end

return Screen