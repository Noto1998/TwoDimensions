local Screen = Level:extend()


function Screen:activate()
	--- shape value
	local cubeZ = Base.gui.height
	local cubeLenX = Base.gui.width-1*2
	local cubeLenY = Base.gui.height-1*2
	local cubeLenZ = 50

	-- levelName
	local levelName = ""
	-- player location
	local playerX = 70
	local playerY = 180+Base.gui.height
	local playerZ = cubeZ - 1
	-- endCube location
	local endCubeX = Base.gui.width/2-50/2
	local endCubeY = Base.gui.height+cubeLenY
	local endCubeZ = cubeZ - 50
	-- create player and endCube
	Screen.super.activate(self, playerX, playerY, playerZ, endCubeX, endCubeY, endCubeZ, levelName)

	--- here to create shape
	self:addShape(Cuboid,		1, 1+Base.gui.height, cubeZ,		cubeLenX, cubeLenY, cubeLenZ)

	--- here to create tips
	self:addTipsList(Lang.tips_save_us, 			Base.gui.width/2, Base.gui.height/3,	-50*4,	"center", "center")
	self:addTipsList(Lang.tips_congratulations,		Base.gui.width/2, Base.gui.height/3,	-100,	"center", "center")
	self:addTipsList(Lang.tips_save_us,				Base.gui.width/2, Base.gui.height/3 *2,	-50*3,	"center", "center")
	self:addTipsList(Lang.ui_key_continue,			Base.gui.width/2, Base.gui.height/3 *2,	-100,	"center", "center")
	--
	local _x = Base.gui.width/2
	self:addTipsList(Lang.tips_save_us, _x, Base.gui.height,	  -50*2,	"center")
	self:addTipsList(Lang.tips_save_us, _x, Base.gui.height+100,  -50*1,	"center")
	self:addTipsList(Lang.tips_save_us, _x, Base.gui.height+100*2, 50*0,	"center")
	self:addTipsList(Lang.tips_save_us, _x, Base.gui.height+100*3, 50*1,	"center")
	self:addTipsList(Lang.tips_save_us, _x, Base.gui.height+100*4, 50*2,	"center")
	-- random location
	for i = 0, 10 do
		local _x2 = love.math.random(0, Base.gui.width)
		local _y = love.math.random(0, Base.gui.height)
		local _z = love.math.random(0, Base.gui.height-80)
		self:addTipsList(Lang.tips_save_us, _x2, Base.gui.height+_y, _z, "center")
	end
end

function Screen:update(dt)
	Screen.super.update(self, dt)

	if self.shiftMode == 0 and Base.isPressed(Base.keys.enter) then
		self.screen:view("level_End_ConPolygon")
	end
end


return Screen