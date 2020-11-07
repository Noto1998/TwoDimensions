local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local cubeZ = 130
	local cubeLenX = Base.gui.width/2-15
	local cubeLenY = Base.gui.height-1*2
	local cubeLenZ = 50
	local cubeLenZ3 = 50 + 2*2
	---

	-- levelName
	local levelName = Lang.level_Invisible
	-- player location
	local playerX = 50
	local playerY = 150
	local playerZ = cubeZ - 1
	-- endCube location
	local endCubeX = 250
	local endCubeY = 50
	local endCubeZ = 130-Base.lenEndCube
	-- create player and endCube
	Screen.super.activate(self, playerX, playerY, playerZ, endCubeX, endCubeY, endCubeZ, levelName)

	--- here to create shape
	self:addShapeList(Cuboid,		1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	self:addShapeList(Cuboid,		Base.gui.width-cubeLenX-1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	self:addShapeList(Cuboid,		Base.gui.width-cubeLenX-1, 1, 0,			cubeLenX, cubeLenY, cubeLenZ-40)
	self:addShapeList(Cuboid,		endCubeX-2, playerY, cubeZ-cubeLenZ3,		cubeLenZ3, cubeLenZ3, cubeLenZ3)
end

return Screen