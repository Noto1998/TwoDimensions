local Screen = Level:extend()

function Screen:activate()
	--- shape vnlue
	-- Cuboid
	local cLenX = 40*2
	local cLenY = base.guiHeight*1.5
	local cLenZ = 50
	local cX = base.guiWidth/2 -cLenX/2
	local cY = -30
	local cZ = base.guiHeight-cLenZ
	-- Ball
	local bR = 20
	---

	-- levelName
	local levelName = lang.level_BlockLaser
	-- player location
	local playerX = base.guiWidth/2-base.player.len/2
	local playerY = -25
	local playerZ = 150
	-- destination location
	local destinationX = base.guiWidth/2-base.lenDestination/2
	local destinationY = base.guiHeight-5
	local destinationZ = -base.lenDestination
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	-- floor
	self:addShapeList(Cuboid,		cX, cY, cZ,		cLenX, cLenY, cLenZ)
	
	self:addShapeList(Rectangle,	base.guiWidth, base.guiHeight+10, 150,		base.guiWidth+40, base.guiHeight/2, 		 -math.pi+math.pi/10)
	self:addShapeList(Ball,			bR, 80, 0,		bR)
	
	self:addShapeList(Laser,		base.guiWidth/2, 1, 1,		0, 1, 1)
end

return Screen