local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local cubeZ = 50
	local cubeLenX = 150
	local cubeLenY = Base.gui.height-1-1
	local cubeLenZ = 40
	---

	-- levelName
	local levelName = Lang.level_RockClimbing
	-- player location
	local playerX = 50
	local playerY = 90
	local playerZ = cubeZ - 1
	-- endCube location
	local endCubeX = cubeLenX - 50
	local endCubeY = Base.gui.width+50
	local endCubeZ = cubeZ+cubeLenZ*2
	-- create player and endCube
	local playerPosition = Base.createPosition(playerX, playerY, playerZ)
	local endCubePosition = Base.createPosition(endCubeX, endCubeY, endCubeZ)
	Screen.super.activate(self, playerPosition, endCubePosition, levelName)

	--- here to create shape
	self:addShape(Cuboid,		1, 1, cubeZ,								cubeLenX, cubeLenY, cubeLenZ)
	self:addShape(Cuboid,		1 + cubeLenX + 45, 1, cubeZ+cubeLenZ,		cubeLenX, cubeLenY, cubeLenZ)
end

return Screen