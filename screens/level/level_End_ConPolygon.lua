local Level_End = require("lib.level_End")
local Screen = Level_End:extend()

local cp1, cpSpd
local waitTimer

function Screen:activate()
	--- shape value
	local cZ = 180
	local cLenX = base.guiWidth-1*2
	local cLenY = base.guiHeight-1*2
	local cLenZ = 50
	--- create player and destination
	local tipsTable = lang.tips_conPolygon 
	local levelName = ""
	local waitTime = 7
	Screen.super.activate(self, tipsTable, levelName, waitTime)
	--
	cpSpd = 0
	waitTimer = 0

	--- here to create shape
	cp1 = ConPolygon(base.guiWidth/2, base.guiHeight/2, base.guiHeight/3+10,		15, 30,  30)
	table.insert(self.shapeList, cp1)
	table.insert(self.drawList, cp1)
end

function Screen:update(dt)
	Screen.super.update(self, dt)

	if self.timeToEnd and self.shiftMode==1 then
		waitTimer = waitTimer + 1*dt;
		
		if waitTimer > 1.5 then
			cp1.len = cp1.len + cpSpd*dt
			cpSpd = cpSpd + 0.5*dt
		end
	end
end


return Screen