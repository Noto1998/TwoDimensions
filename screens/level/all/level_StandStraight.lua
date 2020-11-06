local Screen = Level:extend()

function Screen:activate()

	local mX = 60
	local mY = base.guiHeight/2
	local mZ = 10
	local mLenX = base.guiWidth
	local mLenY = base.guiHeight/2
	local mLenZ = 20
	local bR = 20


	-- levelName
	local levelName = lang.level_StandStraight
	-- player location
	local playerX = 5
	local playerY = 20
	local playerZ = 100
	-- destination location
	local destinationX = base.guiWidth-20
	local destinationY = base.guiHeight+20
	local destinationZ = base.guiHeight-20
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	self:addShapeList(Rectangle,	280, 0, base.guiHeight-20,							300, 300, -math.pi+math.pi/8)
	self:addShapeList(MoveCuboid,	mX, mY, mZ,											mLenX, mLenY, mLenZ, 		400)
	for i = 1, 5 do
		local _x = 100+50*(i-1)
		self:addShapeList(Laser,		_x, base.guiHeight/3, 20,						0, -1, 1)
		self:addShapeList(Ball,			_x, mY+mLenY/2, mZ-bR,							bR)
	end
end


return Screen