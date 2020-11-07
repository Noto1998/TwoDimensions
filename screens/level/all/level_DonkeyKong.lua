local Screen = Level:extend()

function Screen:activate()
	--- shape value
	-- Rectangle
	local reZ = 100
	local reLenX = Base.gui.width-75
	local reLenY = Base.gui.height/2
	local reDir = math.pi/18
	local reBorder = 80
	-- Ball
	local bR = 20
	---

	-- levelName
	local levelName = Lang.level_DonkeyKong
	-- player location
	local playerX = Base.gui.width/2-Base.player.len/2
	local playerY = Base.gui.height/4*3-Base.player.len/2
	local playerZ = 100
	-- destination location
	local destinationX = Base.gui.width-Base.lenDestination
	local destinationY = Base.gui.height/4*3-Base.lenDestination/2
	local destinationZ = Base.gui.height+10
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	self:addShapeList(Ball,		Base.gui.width-reBorder, Base.gui.height/4, 0,			bR)

	self:addShapeList(Rectangle, reBorder, 0, reZ,								reLenX, reLenY,			-reDir)
	self:addShapeList(Rectangle, Base.gui.width-reBorder, reLenY, reZ+50,		reLenX, reLenY, 		-math.pi+reDir)
end

return Screen