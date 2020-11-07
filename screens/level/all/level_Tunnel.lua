local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local cubeZ = 130
	local cubeLenX = Base.gui.width-1*2
	local cubeLenY = Base.gui.height-1*2
	local cubeLenZ = 50

	local cubeY2 = Base.gui.height/2
	local cubeZ2 = -80
	local cubeLenX2 = cubeLenX/2-30/2
	local cubeLenY2 = 50
	local cubeLenZ3 = 60
	---

	-- levelName
	local levelName = Lang.level_Tunnel
	-- player location
	local playerX = 80
	local playerY = 40
	local playerZ = cubeZ - 1
	-- endCube location
	local endCubeX = Base.gui.width/2-Base.lenEndCube/2
	local endCubeY = 180
	local endCubeZ = cubeZ2
	-- create player and endCube
	Screen.super.activate(self, playerX, playerY, playerZ, endCubeX, endCubeY, endCubeZ, levelName)

	--- here to create shape
	self:addShapeList(Cuboid,		1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	-- gate
	self:addShapeList(Cuboid,		1, cubeY2, cubeZ2,								cubeLenX2, cubeLenY2, cubeLenZ)
	self:addShapeList(Cuboid,		Base.gui.width-cubeLenX2-1, cubeY2, cubeZ2,		cubeLenX2, cubeLenY2, cubeLenZ)
	-- wall
	self:addShapeList(Cuboid,		250-1, cubeY2, cubeZ-cubeLenZ3,		50, 50, cubeLenZ3)

	--- here to create tips
	self:addTipsList("/......?", 10, -200, Base.gui.border)
end

return Screen