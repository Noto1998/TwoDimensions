local Screen = Level:extend()

function Screen:activate()
	--- shape value
	-- Rect
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
	-- endCube location
	local endCubeX = Base.gui.width-Base.lenEndCube
	local endCubeY = Base.gui.height/4*3-Base.lenEndCube/2
	local endCubeZ = Base.gui.height+10
	-- create player and endCube
	local playerPosition = Base.createPosition(playerX, playerY, playerZ)
	local endCubePosition = Base.createPosition(endCubeX, endCubeY, endCubeZ)
	Screen.super.activate(self, playerPosition, endCubePosition, levelName)

	--- here to create shape
	self:addShape(Ball,		Base.gui.width-reBorder, Base.gui.height/4, 0,			bR)
	self:addShape(Rect, reBorder, 0, reZ,								reLenX, reLenY,			-reDir)
	self:addShape(Rect, Base.gui.width-reBorder, reLenY, reZ+50,		reLenX, reLenY, 		-math.pi+reDir)
end

return Screen