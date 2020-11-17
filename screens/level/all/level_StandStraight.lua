local Screen = Level:extend()

function Screen:activate()

	local mX = 60
	local mY = Base.gui.height/2
	local mZ = 10
	local mLenX = Base.gui.width
	local mLenY = Base.gui.height/2
	local mLenZ = 20
	local bR = 20

	-- levelName
	local levelName = Lang.level_StandStraight
	-- player location
	local playerX = 5
	local playerY = 20
	local playerZ = 100
	-- endCube location
	local endCubeX = Base.gui.width-20
	local endCubeY = Base.gui.height+20
	local endCubeZ = Base.gui.height-20
	-- create player and endCube
	local playerPosition = Base.createPosition(playerX, playerY, playerZ)
	local endCubePosition = Base.createPosition(endCubeX, endCubeY, endCubeZ)
	Screen.super.activate(self, playerPosition, endCubePosition, levelName)

	--- here to create shape
	self:addShape(Rect,	280, 0, Base.gui.height-20,							300, 300, -math.pi+math.pi/8)
	self:addShape(MoveCuboid,	mX, mY, mZ,											mLenX, mLenY, mLenZ)
	for i = 1, 5 do
		local _x = 100+50*(i-1)
		self:addShape(Laser,		_x, Base.gui.height/3, 20,						0, -1, 1)
		self:addShape(Ball,			_x, mY+mLenY/2, mZ-bR,							bR)
	end
end


return Screen