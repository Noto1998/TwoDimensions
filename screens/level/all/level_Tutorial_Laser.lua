local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local cubeZ = 130
	local cubeLenX = Base.gui.width-1*2
	local cubeLenY = Base.gui.height-1*2
	local cubeLenZ = 50
	local cubeLenZ3 = 50+2

	local cubeLenX2 = 50
	local cubeLenY2 = 50
	---

	-- levelName
	local levelName = Lang.level_Tutorial_Laser
	-- player location
	local playerX = Base.gui.width/4-Base.player.len/2
	local playerY = Base.gui.height/4-Base.player.len/2
	local playerZ = cubeZ - 1
	-- endCube location
	local endCubeX = Base.gui.width-playerX - Base.lenEndCube/2
	local endCubeY = Base.gui.height-playerY - Base.lenEndCube/2
	local endCubeZ = -200
	-- create player and endCube
	local playerPosition = Base.createPosition(playerX, playerY, playerZ)
	local endCubePosition = Base.createPosition(endCubeX, endCubeY, endCubeZ)
	Screen.super.activate(self, playerPosition, endCubePosition, levelName)

	--- here to create shape
	-- floor
	self:addShape(Cuboid,		1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
    -- wall
    self:addShape(Cuboid,		Base.gui.width/2-cubeLenX2/2, Base.gui.height/2-cubeLenY2/2, cubeZ-cubeLenZ*2,		cubeLenX2, cubeLenY2, cubeLenZ*2)
	-- laser
    self:addShape(Laser,		Base.gui.width/2, 0, cubeZ-cubeLenZ3,		0, 1, 0)
    self:addShape(Laser,		0, Base.gui.height/2, cubeZ-cubeLenZ3,		1, 0, 0)

	--- here to create tips
	self:addTipsList(Lang.tips_yellow_means_danger,		5, Base.gui.height+10, 20)
end

return Screen