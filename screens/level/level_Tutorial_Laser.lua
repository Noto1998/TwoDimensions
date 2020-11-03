local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local cubeZ = 130
	local cubeLenX = base.guiWidth-1*2
	local cubeLenY = base.guiHeight-1*2
	local cubeLenZ = 50
	local cubeLenZ3 = 50+2

	local cubeLenX2 = 50
	local cubeLenY2 = 50
	---

	-- levelName
	local levelName = lang.level_Tutorial_Laser
	-- player location
	local playerX = base.guiWidth/4-base.player.len/2
	local playerY = base.guiHeight/4-base.player.len/2
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = base.guiWidth-playerX - base.lenDestination/2
	local destinationY = base.guiHeight-playerY - base.lenDestination/2
	local destinationZ = -200
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	-- floor
	self:addShapeList(Cuboid,		1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
    -- wall
    self:addShapeList(Cuboid,		base.guiWidth/2-cubeLenX2/2, base.guiHeight/2-cubeLenY2/2, cubeZ-cubeLenZ*2,		cubeLenX2, cubeLenY2, cubeLenZ*2)
	-- laser
    self:addShapeList(Laser,		base.guiWidth/2, 0, cubeZ-cubeLenZ3,		0, 1, 0)
    self:addShapeList(Laser,		0, base.guiHeight/2, cubeZ-cubeLenZ3,		1, 0, 0)

	--- here to create tips
	self:addTipsList(lang.tips_yellow_means_danger,		5, base.guiHeight+10, 20)
end

return Screen