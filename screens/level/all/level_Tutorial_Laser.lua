local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local cubeZ = 130
	local cubeLenX = Base.guiWidth-1*2
	local cubeLenY = Base.guiHeight-1*2
	local cubeLenZ = 50
	local cubeLenZ3 = 50+2

	local cubeLenX2 = 50
	local cubeLenY2 = 50
	---

	-- levelName
	local levelName = Lang.level_Tutorial_Laser
	-- player location
	local playerX = Base.guiWidth/4-Base.player.len/2
	local playerY = Base.guiHeight/4-Base.player.len/2
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = Base.guiWidth-playerX - Base.lenDestination/2
	local destinationY = Base.guiHeight-playerY - Base.lenDestination/2
	local destinationZ = -200
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	-- floor
	self:addShapeList(Cuboid,		1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
    -- wall
    self:addShapeList(Cuboid,		Base.guiWidth/2-cubeLenX2/2, Base.guiHeight/2-cubeLenY2/2, cubeZ-cubeLenZ*2,		cubeLenX2, cubeLenY2, cubeLenZ*2)
	-- laser
    self:addShapeList(Laser,		Base.guiWidth/2, 0, cubeZ-cubeLenZ3,		0, 1, 0)
    self:addShapeList(Laser,		0, Base.guiHeight/2, cubeZ-cubeLenZ3,		1, 0, 0)

	--- here to create tips
	self:addTipsList(Lang.tips_yellow_means_danger,		5, Base.guiHeight+10, 20)
end

return Screen