local Screen = Level:extend()

function Screen:activate()
	--- shape vnlue
	local cLenX1 = 50
	local cLenY1 = cLenX1
	local cLenZ1 = 25
	local cX1 = Base.gui.width/4-cLenX1/2
	local cY1 = Base.gui.height/4-cLenY1/2
	
	local cLenX2 = Base.gui.width/2 - (Base.gui.width/2 - cLenX1)/2
	local cLenY2 = Base.gui.height/2 - (Base.gui.height/2 - cLenY1)/2
	local cX2 = Base.gui.width/4-cLenX2/2
	local cY2 = Base.gui.height/4-cLenY2/2

	local cLenX3 = Base.gui.width/2
	local cLenY3 = Base.gui.height/2
	---

	-- levelName
	local levelName = Lang.level_Contour
	-- player location
	local playerX = Base.gui.width/4-Base.player.len/2
	local playerY = Base.gui.height/4-Base.player.len/2
	local playerZ = 50
	-- destination location
	local destinationX = Base.gui.width-Base.gui.width/4-Base.lenDestination/2
	local destinationY = Base.gui.height-Base.gui.height/4-Base.lenDestination/2
	local destinationZ = 200-Base.lenDestination
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	-- left-top
	self:addShapeList(Cuboid,		cX2, cY2, 50,							cLenX2, cLenY2, cLenZ1)
	self:addShapeList(Cuboid,		0-10, -cLenY3, Base.gui.height-10,		cLenX3+10, cLenY3*2, cLenZ1)
	-- right-top
	self:addShapeList(Cuboid,		cX1+Base.gui.width/2, cY1, -1-94,		cLenX1, cLenY1, cLenZ1)
	self:addShapeList(Cuboid,		cX2+Base.gui.width/2, cY2, -1,			cLenX2, cLenY2, cLenZ1)
	self:addShapeList(Cuboid,		0+Base.gui.width/2, 0, 94,				cLenX3, cLenY3, cLenZ1)
	-- right-bottom
	self:addShapeList(Cuboid,		cX2+Base.gui.width/2, cY2+Base.gui.height/2, 200,					cLenX2, cLenY2, cLenZ1)
	self:addShapeList(Cuboid,		0+Base.gui.width/2, 0+Base.gui.height/2, Base.gui.height+40,		cLenX3, cLenY3, cLenZ1)
	-- left-bottom
	self:addShapeList(Cuboid,		cX1, cY1+Base.gui.height/2, 94,					cLenX1, cLenY1, cLenZ1)
	self:addShapeList(Cuboid,		cX2+1, cY2+Base.gui.height/2, 94+(94-50),		cLenX2, cLenY2, cLenZ1)
	self:addShapeList(Cuboid,		0, 0+Base.gui.height/2, Base.gui.height+80,		cLenX3, cLenY3, cLenZ1)
end

return Screen