local Level_End = require "screens.level.level_End"
local Screen = Level_End:extend()

local reList, dirList, spdList
local b1

function Screen:activate()
	--- shape value
	local cZ = 180
	local cLenX = Base.guiWidth-1*2
	local cLenY = Base.guiHeight-1*2
	local cLenZ = 50
	-- create player and destination
	local tipsTable = Lang.tips_polygon 
	local levelName = ""
	local waitTime = 10.3
	Screen.super.activate(self, tipsTable, levelName, waitTime)
	
	--- here to create shape
	-- reList
	reList = {}
	dirList = {}
	spdList = {}
	for i = 1, 150 do
		local _x = love.math.random(0, Base.guiWidth)
		local _y = love.math.random(0, Base.guiHeight)
		reList[i] = Rectangle(_x, -10, -Base.guiHeight*2.7+_y, Base.player.len, 0)

		table.insert(self.shapeList, reList[i])
		table.insert(self.drawList, reList[i])

		dirList[i] = love.math.random(0, math.pi*2)
		spdList[i] = love.math.random(Base.garvity,  Base.garvity*2)
		reList[i].dir = dirList[i]
	end

	-- ball
	b1 = Ball(Base.guiWidth/2, -10-80, -Base.guiHeight*3.8,			80)
	table.insert(self.drawList, b1)
end

function Screen:update(dt)
	Screen.super.update(self, dt)

	if self.timeToEnd and self.shiftMode==1 then
		-- reList
		for i = 1, #reList do
			reList[i].z = reList[i].z + spdList[i]*dt
		end

		-- ball
		b1.z = b1.z + Base.garvity*dt;
	end
end


return Screen