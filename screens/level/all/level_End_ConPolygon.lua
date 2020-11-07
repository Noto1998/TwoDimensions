local Level_End = require "screens.level.level_End"
local Screen = Level_End:extend()

local cp1, cpSpd
local waitTimer

function Screen:activate()
	--- shape value
	--- create player and endCube
	local tipsTable = Lang.tips_conPolygon
	local levelName = ""
	local waitTime = 7
	Screen.super.activate(self, tipsTable, levelName, waitTime)
	--
	cpSpd = 0
	waitTimer = 0

	--- here to create shape
	cp1 = ConPolygon(Base.gui.width/2, Base.gui.height/2, Base.gui.height/3+10,		15, 30,  30)
	table.insert(self.shapeList, cp1)
	table.insert(self.drawList, cp1)
end

function Screen:update(dt)
	Screen.super.update(self, dt)

	if self.timeToEnd and self.shiftMode == 1 then
		waitTimer = waitTimer + 1*dt;

		if waitTimer > 1.5 then
			cp1.len = cp1.len + cpSpd*dt
			cpSpd = cpSpd + 0.5*dt
		end
	end
end


return Screen