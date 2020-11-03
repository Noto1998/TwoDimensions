local Screen = Level:extend()

function Screen:activate()
	--- shape vnlue
	-- Side Wall
	local SWx = -12
	local SWy = 0
	local SWz = base.guiHeight/2
	local SWLx = 20
	local SWLy = 238
	local SWLz = base.guiHeight/2-30
	-- Middle Wall
	local MWz = -110
	-- laser
	local Lx = 160
	local Ly = 3
	local Lz = 188
	local LLx = 0
	local LLy = 1
	local LLz = 1
	-- Laser
	local Sx=1
	local Sy = 240/(320-2*(Lx-50))
	-- Slope
	local dir= math.pi/8
	---
	
	-- levelName
	local levelName = lang.level_Cross
	-- player location
	local playerX = base.guiWidth-20-base.player.len
	local playerY = 20
	local playerZ = 209
	-- destination location
	local destinationX = 20
	local destinationY = 20
	local destinationZ = -160
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--here to create the shape
	--Floor
	self:addShapeList(Cuboid, 2,2,210,	318,238,30)
	--Side Wall
	self:addShapeList(Cuboid, SWx,SWy,SWz,						SWLx,SWLy,SWLz)
	self:addShapeList(Cuboid, base.guiWidth-SWx-SWLx,SWy,SWz,	SWLx,SWLy,SWLz)
	--Laser
	self:addShapeList(Laser, Lx,	Ly-4, 210-40/2,		LLx,LLy,LLz)--chuizhi
	self:addShapeList(Laser, Lx-50, Ly-4, 210-40/2,	Sx,Sy,LLz)--right
	self:addShapeList(Laser, Lx+50, Ly-4, 210-40/2,	-Sx,Sy,LLz)--left
	self:addShapeList(Laser, 0, Ly+210, Lz, 			1,0,0)
	--Middle Wall
	self:addShapeList(Cuboid, 150, 50, 190,		20,55,20)
	self:addShapeList(Cuboid, 150, 130, 190,		20,55,20)
	-- Cross
	self:addShapeList(Cuboid, 55, 100, MWz,		210,30,30)
	self:addShapeList(Cuboid, 290,100, MWz,		22,30,30)
	self:addShapeList(Cuboid, 10, 100, MWz,		22,30,30)
	--Ball
	self:addShapeList(Ball, 85,115,150,12.5)
	--Slope
	self:addShapeList(Rectangle, base.guiWidth/2, 105, 210,		(210/2)/math.cos(dir), 25,		-math.pi+dir)

	-- here to create tips
	self:addTipsList(lang.tips_mayoiba_yabureru, 20, -80, base.guiBorder*2)
end

return Screen