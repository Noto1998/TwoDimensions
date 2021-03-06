local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local cubeZ = 130
	local cubeLenX = Base.gui.width/2-15
	local cubeLenY = Base.gui.height-1*2
	local cubeLenZ = 50
	---

	-- levelName
	local levelName = Lang.level_CrossTheRiver
	-- player location
	local playerX = 50
	local playerY = 150
	local playerZ = cubeZ - 1
	-- endCube location
	local endCubeX = 250
	local endCubeY = 50
	local endCubeZ = 130-Base.lenEndCube
	-- create player and endCube
	local playerPosition = Base.createPosition(playerX, playerY, playerZ)
	local endCubePosition = Base.createPosition(endCubeX, endCubeY, endCubeZ)
	Screen.super.activate(self, playerPosition, endCubePosition, levelName)

	--- here to create shape
	self:addShape(Cuboid,		1, 1, cubeZ,							cubeLenX, cubeLenY, cubeLenZ)
	self:addShape(Cuboid,		Base.gui.width-cubeLenX-1, 1, cubeZ,	cubeLenX, cubeLenY, cubeLenZ)

	--- here to create tips
	self:addTipsList(Lang.tips_pressed_Y_to_shift,		Base.gui.border, 50, -50)
	self:addTipsList(Lang.tips_left_and_right_to_move,	Base.gui.border, 350, 30)
end

return Screen