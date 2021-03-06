local Screen = Level:extend()

function Screen:activate()
	--- shape vnlue
	-- Side Wall
	local SWx = -12
	local SWy = 0
	local SWz = Base.gui.height/2
	local SWLx = 20
	local SWLy = 238
	local SWLz = Base.gui.height/2-30
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
	local Sx = 1
	local Sy = 240/(320-2*(Lx-50))
	-- Slope
	local radian = math.pi/8
	---

	-- levelName
	local levelName = Lang.level_Cross
	-- player location
	local playerX = Base.gui.width-20-Base.player.len
	local playerY = 20
	local playerZ = 209
	-- endCube location
	local endCubeX = 20
	local endCubeY = 20
	local endCubeZ = -160
	-- create player and endCube
	local playerPosition = Base.createPosition(playerX, playerY, playerZ)
	local endCubePosition = Base.createPosition(endCubeX, endCubeY, endCubeZ)
	Screen.super.activate(self, playerPosition, endCubePosition, levelName)

	--here to create the shape
	--Floor
	self:addShape(Cuboid, 2,2,210,	318,238,30)
	--Side Wall
	self:addShape(Cuboid, SWx,SWy,SWz,						SWLx,SWLy,SWLz)
	self:addShape(Cuboid, Base.gui.width-SWx-SWLx,SWy,SWz,	SWLx,SWLy,SWLz)
	--Laser
	self:addShape(Laser, Lx,	Ly-4, 210-40/2,		LLx,LLy,LLz)--chuizhi
	self:addShape(Laser, Lx-50, Ly-4, 210-40/2,	Sx,Sy,LLz)--right
	self:addShape(Laser, Lx+50, Ly-4, 210-40/2,	-Sx,Sy,LLz)--left
	self:addShape(Laser, 0, Ly+210, Lz, 			1,0,0)
	--Middle Wall
	self:addShape(Cuboid, 150, 50, 190,		20,55,20)
	self:addShape(Cuboid, 150, 130, 190,		20,55,20)
	-- Cross
	self:addShape(Cuboid, 55, 100, MWz,		210,30,30)
	self:addShape(Cuboid, 290,100, MWz,		22,30,30)
	self:addShape(Cuboid, 10, 100, MWz,		22,30,30)
	--Ball
	self:addShape(Ball, 85,115,150,12.5)
	--Slope
	self:addShape(Rect, Base.gui.width/2, 105, 210,		(210/2)/math.cos(radian), 25,		-math.pi+radian)

	-- here to create tips
	self:addTipsList(Lang.tips_mayoiba_yabureru, 20, -80, Base.gui.border*2)
end

return Screen