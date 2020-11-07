local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local cubeZ = 130
	local cubeLenX = Base.guiWidth/2-15
	local cubeLenY = Base.guiHeight-1*2
	local cubeLenZ = 50
	local cubeLenZ3 = 50 + 2*2
	---

	-- levelName
	local levelName = Lang.level_Invisible
	-- player location
	local playerX = 50
	local playerY = 150
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = 250
	local destinationY = 50
	local destinationZ = 130-Base.lenDestination
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	self:addShapeList(Cuboid,		1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	
	self:addShapeList(Cuboid,		Base.guiWidth-cubeLenX-1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	self:addShapeList(Cuboid,		Base.guiWidth-cubeLenX-1, 1, 0,			cubeLenX, cubeLenY, cubeLenZ-40)
	
	self:addShapeList(Cuboid,		destinationX-2, playerY, cubeZ-cubeLenZ3,		cubeLenZ3, cubeLenZ3, cubeLenZ3)
end

return Screen