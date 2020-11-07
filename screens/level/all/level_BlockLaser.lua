local Screen = Level:extend()

function Screen:activate()
	--- shape vnlue
	-- Cuboid
	local cLenX = 40*2
	local cLenY = Base.gui.height*1.5
	local cLenZ = 50
	local cX = Base.gui.width/2 -cLenX/2
	local cY = -30
	local cZ = Base.gui.height-cLenZ
	-- Ball
	local bR = 20
	---

	-- levelName
	local levelName = Lang.level_BlockLaser
	-- player location
	local playerX = Base.gui.width/2-Base.player.len/2
	local playerY = -25
	local playerZ = 150
	-- destination location
	local destinationX = Base.gui.width/2-Base.lenDestination/2
	local destinationY = Base.gui.height-5
	local destinationZ = -Base.lenDestination
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	-- floor
	self:addShapeList(Cuboid,		cX, cY, cZ,		cLenX, cLenY, cLenZ)
	
	self:addShapeList(Rectangle,	Base.gui.width, Base.gui.height+10, 150,		Base.gui.width+40, Base.gui.height/2, 		 -math.pi+math.pi/10)
	self:addShapeList(Ball,			bR, 80, 0,		bR)
	
	self:addShapeList(Laser,		Base.gui.width/2, 1, 1,		0, 1, 1)
end

return Screen