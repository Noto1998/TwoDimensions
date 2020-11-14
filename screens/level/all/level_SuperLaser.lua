local Screen = Level:extend()

function Screen:activate()
	--- shape value
	-- floor
	local floorZ = Base.gui.height - 20
	-- player wall
	local c1Z = 80
	local c1LenX = 2.5 * 40
	local c1LenY = 140
	local c1LenZ = 100
	-- laser wall
	local c2LenX = 40 * 4
	local c2LenY = c1LenY
	local c2LenZ = floorZ-(c1Z+c1LenZ)
	-- hole
	local hLenX = 40 * 2
	local hLenZ = 10
	local hX1 = 3*40
	local hX2 = hX1 + 40 * 3
	local hZ = c1Z
	-- left wall
	local leftLenY = 50
	local leftLenZ = 200
	local leftX = hX1 - 1
	local leftY = -200
	local leftZ = hZ - leftLenZ + hLenZ
	-- ball
	local ballR = hLenX/2
	-- laser
	local tX = 3.5 * 40
	local tBorderX = 40
	local tY = leftY + leftLenY
	local tZ = hZ+30--100
	local tSX = 0
	local tSY = 1
	local tSZ = 1
	---

	-- levelName
	local levelName = Lang.level_SuperLaser
	-- player location
	local playerX = 30
	local playerY = 50
	local playerZ = c1Z-1
	-- endCube location
	local endCubeX = playerX-Base.lenEndCube/2
	local endCubeY = Base.gui.height+10
	local endCubeZ = floorZ-Base.lenEndCube/2
	-- create player and endCube
	Screen.super.activate(self, playerX, playerY, playerZ, endCubeX, endCubeY, endCubeZ, levelName)

	--- here to create shape
	-- floor
    self:addShape(Cuboid, 1, 1, floorZ,			Base.gui.width, Base.gui.height, 1)
	-- player wall
	self:addShape(Cuboid, 1, 1, c1Z,						c1LenX, c1LenY, c1LenZ)
	-- laser wall
	self:addShape(Cuboid, 1+c1LenX, 1, c1Z+c1LenZ,			c2LenX, c2LenY, c2LenZ)
	--left wall
	self:addShape(Cuboid, leftX, leftY, leftZ,				10, leftLenY, leftLenZ)
	-- hole1
	self:addShape(Cuboid, hX1, leftY, hZ,					hLenX, leftLenY, hLenZ)
	self:addShape(Ball,	  hX1+ballR, leftY-10, hZ-ballR,	ballR)
	-- hole2
	self:addShape(Cuboid, hX2, leftY, hZ,					hLenX, leftLenY, hLenZ)
	self:addShape(Ball,	  hX2+ballR, leftY-10, hZ-ballR,	ballR)
	-- Laser
	for i = 0, 4 do
		self:addShape(Laser, tX+tBorderX*i, tY, tZ,			tSX, tSY, tSZ)
	end
end

return Screen