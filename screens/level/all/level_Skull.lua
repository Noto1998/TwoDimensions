local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local cubeZ = 180
	local cubeLenX = 150
	local cubeLenY = Base.gui.height-1-1
	local cubeLenZ = 50
	local cubeLenZ3 = 100
	--nose
	local noseLenX = 100
	--floor
	local floorY = 20
	local floorLenX = Base.gui.width/2-noseLenX/2
	local floorLenY = 50*2
	---

	-- levelName
	local levelName = Lang.level_Skull
	-- player location
	local playerX = 30
	local playerY = floorY+floorLenY/2-Base.player.len/2
	local playerZ = cubeZ - 1
	-- endCube location
	local endCubeX = Base.gui.width/2 - Base.lenEndCube/2
	local endCubeY = Base.gui.height/2
	local endCubeZ = -100
	-- create player and endCube
	local playerPosition = Base.createPosition(playerX, playerY, playerZ)
	local endCubePosition = Base.createPosition(endCubeX, endCubeY, endCubeZ)
	Screen.super.activate(self, playerPosition, endCubePosition, levelName)

	--- here to create shape
	--floor
	self:addShape(Cuboid,		1, floorY, cubeZ,							floorLenX, floorLenY, cubeLenZ)
	self:addShape(Cuboid,		Base.gui.width-floorLenX, floorY, cubeZ,		floorLenX, floorLenY, cubeLenZ)
	--nose
	self:addShape(Cuboid,		Base.gui.width/2-noseLenX/2, 1, cubeZ-150,		noseLenX, cubeLenY-50, cubeLenZ)
	--eye
	self:addShape(Cuboid,		Base.gui.width-playerX-50, playerY, cubeZ-cubeLenZ3,		50, 50, cubeLenZ3)
	--tooth
	self:addShape(Cuboid,		Base.gui.width/2-40/2-40-10, cubeLenY-50+10, -100,		40, 40, 50)
	self:addShape(Cuboid,		Base.gui.width/2-40/2,		cubeLenY-50+10, cubeZ,		40, 40, 50)
	self:addShape(Cuboid,		Base.gui.width/2-40/2+40+10, cubeLenY-50+10, -300,		40, 40, 50)
end

return Screen