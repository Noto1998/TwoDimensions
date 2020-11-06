local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local cubeZ = 180
	local cubeLenX = 150
	local cubeLenY = base.guiHeight-1-1
	local cubeLenZ = 50
	local cubeLenZ3 = 100
	--nose
	local noseLenX = 100
	--floor
	local floorY = 20
	local floorLenX = base.guiWidth/2-noseLenX/2
	local floorLenY = 50*2
	---

	-- levelName
	local levelName = lang.level_Skull
	-- player location
	local playerX = 30
	local playerY = floorY+floorLenY/2-base.player.len/2
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = base.guiWidth/2 - base.lenDestination/2
	local destinationY = base.guiHeight/2
	local destinationZ = -100
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	--floor
	self:addShapeList(Cuboid,		1, floorY, cubeZ,							floorLenX, floorLenY, cubeLenZ)
	self:addShapeList(Cuboid,		base.guiWidth-floorLenX, floorY, cubeZ,		floorLenX, floorLenY, cubeLenZ)
	--nose
	self:addShapeList(Cuboid,		base.guiWidth/2-noseLenX/2, 1, cubeZ-150,		noseLenX, cubeLenY-50, cubeLenZ)
	--eye
	self:addShapeList(Cuboid,		base.guiWidth-playerX-50, playerY, cubeZ-cubeLenZ3,		50, 50, cubeLenZ3)
	--tooth
	self:addShapeList(Cuboid,		base.guiWidth/2-40/2-40-10, cubeLenY-50+10, -100,		40, 40, 50)
	self:addShapeList(Cuboid,		base.guiWidth/2-40/2,		cubeLenY-50+10, cubeZ,		40, 40, 50)
	self:addShapeList(Cuboid,		base.guiWidth/2-40/2+40+10, cubeLenY-50+10, -300,		40, 40, 50)
end

return Screen