local Screen = Level:extend()

function Screen:activate()
	--- shape value
	local cubeZ = 130
	local cubeLenX = base.guiWidth/2-15
	local cubeLenY = base.guiHeight-1*2
	local cubeLenZ = 50
	local cubeLenZ3 = 50 + 2*2
	---

	-- levelName
	local levelName = lang.level_CrossTheRiver
	-- player location
	local playerX = 50
	local playerY = 150
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = 250
	local destinationY = 50
	local destinationZ = 130-base.lenDestination
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	self:addShapeList(Cuboid,		1, 1, cubeZ,							cubeLenX, cubeLenY, cubeLenZ)
	self:addShapeList(Cuboid,		base.guiWidth-cubeLenX-1, 1, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	
	--- here to create tips
	self:addTipsList(lang.tips_pressed_Y_to_shift,		base.guiBorder, 50, -50)
	self:addTipsList(lang.tips_left_and_right_to_move,	base.guiBorder, 350, 30)
end

return Screen