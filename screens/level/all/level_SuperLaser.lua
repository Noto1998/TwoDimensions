local Screen = Level:extend()

function Screen:activate()
	--- shape value
	-- floor
	local floorZ = base.guiHeight-20
	-- player wall
	local c1Z = 80
	local c1LenX = 2.5*40
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
	local hX2 = hX1 + 40*3
	local hZ = c1Z
	-- left wall
	local leftLenY = 50
	local leftLenZ = 200
	local leftX = hX1-1
	local leftY = -200
	local leftZ = hZ - leftLenZ + hLenZ
	-- ball
	local ballR = hLenX/2
	-- laser
	local tX = 3.5*40
	local tBorderX = 40
	local tY = leftY+leftLenY
	local tZ = hZ+30--100
	local tSX = 0
	local tSY = 1
	local tSZ = 1
	---

	-- levelName
	local levelName = lang.level_SuperLaser
	-- player location
	local playerX = 30
	local playerY = 50
	local playerZ = c1Z-1
	-- destination location
	local destinationX = playerX-base.lenDestination/2
	local destinationY = base.guiHeight+10
	local destinationZ = floorZ-base.lenDestination/2
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
    
	--- here to create shape
	-- floor
    self:addShapeList(Cuboid, 1, 1, floorZ,			base.guiWidth, base.guiHeight, 1)
	-- player wall
	self:addShapeList(Cuboid, 1, 1, c1Z,						c1LenX, c1LenY, c1LenZ)
	-- laser wall
	self:addShapeList(Cuboid, 1+c1LenX, 1, c1Z+c1LenZ,			c2LenX, c2LenY, c2LenZ)
	--left wall
	self:addShapeList(Cuboid, leftX, leftY, leftZ,				10, leftLenY, leftLenZ)
	-- hole1
	self:addShapeList(Cuboid, hX1, leftY, hZ,					hLenX, leftLenY, hLenZ)
	self:addShapeList(Ball,	  hX1+ballR, leftY-10, hZ-ballR,	ballR)
	-- hole2
	self:addShapeList(Cuboid, hX2, leftY, hZ,					hLenX, leftLenY, hLenZ)
	self:addShapeList(Ball,	  hX2+ballR, leftY-10, hZ-ballR,	ballR)
	-- Laser
	for i = 0, 4 do
		self:addShapeList(Laser, tX+tBorderX*i, tY, tZ,			tSX, tSY, tSZ)
	end
end

return Screen