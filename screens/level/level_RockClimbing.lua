local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local cubeZ = 50
	local cubeLenX = 150
	local cubeLenY = base.guiHeight-1-1
	local cubeLenZ = 40
	---

	-- levelName
	local levelName = lang.level_RockClimbing
	-- player location
	local playerX = 50
	local playerY = 90
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = cubeLenX - 50
	local destinationY = base.guiWidth+50
	local destinationZ = cubeZ+cubeLenZ*2
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	self:addShapeList(Cuboid,		1, 1, cubeZ,								cubeLenX, cubeLenY, cubeLenZ)
	self:addShapeList(Cuboid,		1 + cubeLenX + 45, 1, cubeZ+cubeLenZ,		cubeLenX, cubeLenY, cubeLenZ)
end

return Screen