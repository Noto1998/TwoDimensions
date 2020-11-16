local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local reLenX = Base.gui.width-1*2
	local reLenY = 100
	local reLenZ = 50
	local reX = Base.gui.width
	local reY = Base.gui.height/2-reLenY/2
	local reZ = Base.gui.height-50
	-- Ball
	local bR = 20
	---

	-- levelName
	local levelName = Lang.level_Tutorial_Ball
	-- player location
	local playerX = Base.gui.width/4
	local playerY = Base.gui.height/2-Base.player.len/2
	local playerZ = 50
	-- endCube location
	local endCubeX = Base.gui.width-50/2
	local endCubeY = Base.gui.width+50
	local endCubeZ = reZ-50
	-- create player and endCube
	local playerPosition = Base.createPosition(playerX, playerY, playerZ)
	local endCubePosition = Base.createPosition(endCubeX, endCubeY, endCubeZ)
	Screen.super.activate(self, playerPosition, endCubePosition, levelName)

	--- here to create shape
	self:addShape(Rectangle,	reX, reY, reZ,		reLenX, reLenY,		-math.pi+math.pi/10)
	self:addShape(Cuboid,		Base.gui.width/2-25/2, reY, 1,		25, reLenY, 25)
	self:addShape(Ball,			bR, Base.gui.height/2, 50,			bR)
end

return Screen