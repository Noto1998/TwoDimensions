local Screen = Level:extend()

function Screen:activate()
	--- shape vnlue
	local cLenX1 = 50
	local cLenY1 = cLenX1
	local cLenZ1 = 25
	local cX1 = base.guiWidth/4-cLenX1/2
	local cY1 = base.guiHeight/4-cLenY1/2
	
	local cLenX2 = base.guiWidth/2 - (base.guiWidth/2 - cLenX1)/2
	local cLenY2 = base.guiHeight/2 - (base.guiHeight/2 - cLenY1)/2
	local cX2 = base.guiWidth/4-cLenX2/2
	local cY2 = base.guiHeight/4-cLenY2/2

	local cLenX3 = base.guiWidth/2
	local cLenY3 = base.guiHeight/2
	---

	-- levelName
	local levelName = lang.level_Contour
	-- player location
	local playerX = base.guiWidth/4-base.player.len/2
	local playerY = base.guiHeight/4-base.player.len/2
	local playerZ = 50
	-- destination location
	local destinationX = base.guiWidth-base.guiWidth/4-base.lenDestination/2
	local destinationY = base.guiHeight-base.guiHeight/4-base.lenDestination/2
	local destinationZ = 200-base.lenDestination
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	-- left-top
	self:addShapeList(Cuboid,		cX2, cY2, 50,							cLenX2, cLenY2, cLenZ1)
	self:addShapeList(Cuboid,		0-10, -cLenY3, base.guiHeight-10,		cLenX3+10, cLenY3*2, cLenZ1)
	-- right-top
	self:addShapeList(Cuboid,		cX1+base.guiWidth/2, cY1, -1-94,		cLenX1, cLenY1, cLenZ1)
	self:addShapeList(Cuboid,		cX2+base.guiWidth/2, cY2, -1,			cLenX2, cLenY2, cLenZ1)
	self:addShapeList(Cuboid,		0+base.guiWidth/2, 0, 94,				cLenX3, cLenY3, cLenZ1)
	-- right-bottom
	self:addShapeList(Cuboid,		cX2+base.guiWidth/2, cY2+base.guiHeight/2, 200,					cLenX2, cLenY2, cLenZ1)
	self:addShapeList(Cuboid,		0+base.guiWidth/2, 0+base.guiHeight/2, base.guiHeight+40,		cLenX3, cLenY3, cLenZ1)
	-- left-bottom
	self:addShapeList(Cuboid,		cX1, cY1+base.guiHeight/2, 94,					cLenX1, cLenY1, cLenZ1)
	self:addShapeList(Cuboid,		cX2+1, cY2+base.guiHeight/2, 94+(94-50),		cLenX2, cLenY2, cLenZ1)
	self:addShapeList(Cuboid,		0, 0+base.guiHeight/2, base.guiHeight+80,		cLenX3, cLenY3, cLenZ1)
end

return Screen