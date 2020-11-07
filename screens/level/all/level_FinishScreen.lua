local Screen = Level:extend()

local finishFlag--fake

function Screen:activate()
	--- shape value
	local cubeZ = Base.guiHeight
	local cubeLenX = Base.guiWidth-1*2
	local cubeLenY = Base.guiHeight-1*2
	local cubeLenZ = 50
	---
	finishFlag = false

	-- levelName
	local levelName = ""
	-- player location
	local playerX = 70
	local playerY = 180+Base.guiHeight
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = Base.guiWidth/2-50/2
	local destinationY = Base.guiHeight+cubeLenY
	local destinationZ = cubeZ - 50
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	self:addShapeList(Cuboid,		1, 1+Base.guiHeight, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	
	--- here to create tips
	self:addTipsList(Lang.tips_save_us, 			Base.guiWidth/2, Base.guiHeight/3,		-50*4,	"center", "center")
	self:addTipsList(Lang.tips_congratulations,		Base.guiWidth/2, Base.guiHeight/3,		-100,	"center", "center")
	self:addTipsList(Lang.tips_save_us,				Base.guiWidth/2, Base.guiHeight/3 *2,	-50*3,	"center", "center")
	self:addTipsList(Lang.ui_key_continue,			Base.guiWidth/2, Base.guiHeight/3 *2,	-100,	"center", "center")
	--
	local _x = Base.guiWidth/2
	self:addTipsList(Lang.tips_save_us, _x, Base.guiHeight,		 -50*2, "center")
	self:addTipsList(Lang.tips_save_us, _x, Base.guiHeight+100,  -50*1,	"center")
	self:addTipsList(Lang.tips_save_us, _x, Base.guiHeight+100*2, 50*0,	"center")
	self:addTipsList(Lang.tips_save_us, _x, Base.guiHeight+100*3, 50*1,	"center")
	self:addTipsList(Lang.tips_save_us, _x, Base.guiHeight+100*4, 50*2,	"center")
	-- random location
	for i = 0, 10 do
		local _x = love.math.random(0, Base.guiWidth)
		local _y = love.math.random(0, Base.guiHeight)
		local _z = love.math.random(0, Base.guiHeight-80)
		self:addTipsList(Lang.tips_save_us, _x, Base.guiHeight+_y, _z, "center")
	end
end

function Screen:update(dt)
	Screen.super.update(self, dt)
		
	if self.shiftMode == 0 and Base.isPressed(Base.keys.enter) then
		self.screen:view("level_End_ConPolygon")
	end
end

--[[
function Screen:update(dt)
	-- shift and bgm
	local canShift = not finishFlag
	Screen.super.update(self, dt, canShift)

	if finishFlag then
		-- should be first
		if Base.isPressed(Base.keys.enter) then
			print(1111)
			self.screen:view("level_End_ConPolygon")
		end
	else
		if self.shiftMode == 0 and Base.isPressed(Base.keys.enter) then
			print(2222)
			finishFlag = true
		end
	end
end

function Screen:draw()
	Screen.super.draw(self)
	
	-- draw finishLevel
	if finishFlag then
		love.graphics.setColor(0,0,0, 0.75)
		love.graphics.rectangle("fill", 0, 0, Base.guiWidth, Base.guiHeight)
		love.graphics.setColor(Base.cWhite)
		Base.drawRoundedRectangle(Base.guiBorder, Base.guiBorder, Base.guiWidth-Base.guiBorder*2, Base.guiHeight-Base.guiBorder*2)
		love.graphics.setColor(Base.cBlack)
		Base.print(Lang.docFake, Base.guiBorder*2, Base.guiBorder*2)
		Base.print("A 寻找圆", Base.guiWidth-Base.guiBorder*2, Base.guiHeight-Base.guiBorder*2, "right", "bottom")
	end
end
]]

return Screen