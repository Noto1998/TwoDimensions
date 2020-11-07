local Screen = Level:extend()

local finishFlag--fake

function Screen:activate()
	--- shape value
	local cubeZ = Base.gui.height
	local cubeLenX = Base.gui.width-1*2
	local cubeLenY = Base.gui.height-1*2
	local cubeLenZ = 50
	---
	finishFlag = false

	-- levelName
	local levelName = ""
	-- player location
	local playerX = 70
	local playerY = 180+Base.gui.height
	local playerZ = cubeZ - 1
	-- destination location
	local destinationX = Base.gui.width/2-50/2
	local destinationY = Base.gui.height+cubeLenY
	local destinationZ = cubeZ - 50
	-- create player and destination
	Screen.super.activate(self, playerX, playerY, playerZ, destinationX, destinationY, destinationZ, levelName)
	
	--- here to create shape
	self:addShapeList(Cuboid,		1, 1+Base.gui.height, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)
	
	--- here to create tips
	self:addTipsList(Lang.tips_save_us, 			Base.gui.width/2, Base.gui.height/3,		-50*4,	"center", "center")
	self:addTipsList(Lang.tips_congratulations,		Base.gui.width/2, Base.gui.height/3,		-100,	"center", "center")
	self:addTipsList(Lang.tips_save_us,				Base.gui.width/2, Base.gui.height/3 *2,	-50*3,	"center", "center")
	self:addTipsList(Lang.ui_key_continue,			Base.gui.width/2, Base.gui.height/3 *2,	-100,	"center", "center")
	--
	local _x = Base.gui.width/2
	self:addTipsList(Lang.tips_save_us, _x, Base.gui.height,		 -50*2, "center")
	self:addTipsList(Lang.tips_save_us, _x, Base.gui.height+100,  -50*1,	"center")
	self:addTipsList(Lang.tips_save_us, _x, Base.gui.height+100*2, 50*0,	"center")
	self:addTipsList(Lang.tips_save_us, _x, Base.gui.height+100*3, 50*1,	"center")
	self:addTipsList(Lang.tips_save_us, _x, Base.gui.height+100*4, 50*2,	"center")
	-- random location
	for i = 0, 10 do
		local _x = love.math.random(0, Base.gui.width)
		local _y = love.math.random(0, Base.gui.height)
		local _z = love.math.random(0, Base.gui.height-80)
		self:addTipsList(Lang.tips_save_us, _x, Base.gui.height+_y, _z, "center")
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
		love.graphics.rectangle("fill", 0, 0, Base.gui.width, Base.gui.height)
		love.graphics.setColor(Base.color.white)
		Base.drawRoundedRectangle(Base.gui.border, Base.gui.border, Base.gui.width-Base.gui.border*2, Base.gui.height-Base.gui.border*2)
		love.graphics.setColor(Base.color.black)
		Base.print(Lang.docFake, Base.gui.border*2, Base.gui.border*2)
		Base.print("A 寻找圆", Base.gui.width-Base.gui.border*2, Base.gui.height-Base.gui.border*2, "right", "bottom")
	end
end
]]

return Screen