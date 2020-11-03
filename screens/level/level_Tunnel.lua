local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local cubeZ = 130
	local cubeLenX = base.guiWidth-1*2
	local cubeLenY = base.guiHeight-1*2
	local cubeLenZ = 50

	local cubeY2 = base.guiHeight/2
	local cubeZ2 = -80
	local cubeLenX2 = cubeLenX/2-30/2
	local cubeLenY2 = 50

	local cubeLenZ3 = 60
	---

	-- levelName
	local levelName = lang.level_Tunnel
	-- player location
	local playerX = 80
	local playerY = 40
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = base.guiWidth/2-base.lenDestination/2
	local destinationY = 180
	local destinationZ = cubeZ2
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	self:addShapeList(Cuboid,		1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	-- gate
	self:addShapeList(Cuboid,		1, cubeY2, cubeZ2,								cubeLenX2, cubeLenY2, cubeLenZ)
	self:addShapeList(Cuboid,		base.guiWidth-cubeLenX2-1, cubeY2, cubeZ2,		cubeLenX2, cubeLenY2, cubeLenZ)
	-- wall
	self:addShapeList(Cuboid,		250-1, cubeY2, cubeZ-cubeLenZ3,		50, 50, cubeLenZ3)
	
	--- here to create tips
	self:addTipsList("/......?", 10, -200, base.guiBorder)
end

return Screen