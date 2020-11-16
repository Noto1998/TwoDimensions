local Level = Shift:extend()

local gotoMainScreenTimerMax = 1-- second
local keyTips
local player, endCube

local function resetLevel(self)
	-- self.resetLevelPath is in screenManager.lua - function ScreenManager:view(path, ...).
	self.screen:view(self.resetLevelPath)
end

-- record levelIndex
function Level:record(...)
	local levelIndex = ({...})[1]
	self.levelIndex = levelIndex
end

function Level:activate(playerPosition, endCubePosition, levelName, isTutorial)
	Level.super.activate(self)

	self.shapeList = {}
	self.drawList = {}
	self.tipsList = {}
	self.levelName = Base.ternary(levelName ~= nil, levelName, 'levelName missing!')
	self.isTutorial = Base.ternary(isTutorial ~= nil, isTutorial, false)
	self.isFinish = false

	keyTips = KeyTips()

	-- init player and endCube
	player = Player(playerPosition)
	endCube = EndCube(endCubePosition)
	table.insert(self.shapeList, player)
	table.insert(self.shapeList, endCube)
	table.insert(self.drawList, player)
	table.insert(self.drawList, endCube)
end


function Level:update(dt, canShift)

	canShift = not (self.shiftMode == 1 and not player:isOnGround()) and
			   (not self.isFinish) and
			   (not keyTips:isShow()) and
	   		   (not canShift ~= false)--same as (== nil or == true)
	Level.super.update(self, dt, canShift)

	-- update keyTips
	if not self.isTutorial then
		keyTips:update()
	end

	if (not self.isFinish) and (not keyTips:isShow()) then

		-- reset
		if Base.isPressed(Base.keys.reset) then
			resetLevel(self)
		end

		-- goto MainScreen
		if Base.isHold(Base.keys.cancel, gotoMainScreenTimerMax) then
			self.screen:view('MainScreen')
		end

		-- shape update
		self:updateShape(dt)
	end

	-- goto next level
	if self.isFinish and Base.isPressed(Base.keys.enter) then

		local nextLevelIndex = self.levelIndex + 1
		local levelName = LEVEL_STRING[nextLevelIndex]

		self.screen:view(levelName, nextLevelIndex)
	end

	-- finish level
	if player:isTouch(endCube, self.shiftMode) and (not self.isFinish) then
		self.isFinish = true
		-- play sfx
		love.audio.play(SFX_FINISH)
	end

	-- todo:rewrite
	--- sort drawList
	self:sortDrawList()
end


function Level:draw()
	-- draw BG
	love.graphics.setColor(Base.color.black)
	love.graphics.rectangle('fill', 0, 0, Base.gui.width, Base.gui.height)

	-- draw all obj in drawList
	if self.drawList ~= nil then
		for key, obj in pairs(self.drawList) do
			obj:draw(self.shiftMode)
		end
	end

	-- draw tips
	if self.tipsList ~= nil then
		for key, tip in pairs(self.tipsList) do
			tip:draw(self.shiftMode)
		end
	end

	-- draw levelName
	love.graphics.setColor(Base.color.white)
	Base.print(self.levelName, Base.gui.border, Base.gui.height, 'left', 'bottom')

	-- draw bgmManager
	bgmManager:draw()

	-- draw stuck warning
	if self.shiftMode == 0 and player.stuck then
		love.graphics.setColor(Base.color.white)
		Base.print(Lang.ui_player_stuck, Base.gui.width / 2, Base.gui.height / 2, 'center', 'center')
	end

	-- draw XYZ
	self:drawXYZ()

	-- draw keyTips, hide when isTutorial
	if not self.isTutorial then

		love.graphics.setColor(Base.color.darkGray)
		Base.print(Lang.ui_key_keyTips, Base.gui.width - Base.gui.border, Base.gui.height, 'right', 'bottom')

		keyTips:draw()
	end

	-- draw finishLevel
	if self.isFinish then

		love.graphics.setColor(0, 0, 0, 0.9)
		love.graphics.rectangle('fill', 0, 0, Base.gui.width, Base.gui.height)

		love.graphics.setColor(Base.color.white)
		Base.print(Lang.ui_level_finish, Base.gui.width / 2, Base.gui.height / 3, 'center', 'center')
		Base.print(Lang.ui_key_continue, Base.gui.width / 2, Base.gui.height / 3 * 2, 'center', 'center')
	end
end


---@param obj Shape
function Level:addShape(obj, x, y, z, ...)
	local position = Base.createPosition(x, y, z)
	table.insert(self.shapeList, obj(position, ...))
	table.insert(self.drawList, self.shapeList[#self.shapeList])
end


function Level:addTipsList(string, x, y, z, ...)
	local position = Base.createPosition(x, y, z)
	table.insert(self.tipsList, Tips(string, position, ...))
end


function Level:playerDead()
	-- play sfx
	SFX_RESTART:seek(0.15)
	love.audio.play(SFX_RESTART)
	-- reset
	resetLevel(self)
end


function Level:drawXYZ()
	local w = 15
	local x = Base.gui.border + w * 6
	local c1 = Base.cloneTable(Base.color.darkGray)

	c1[4] = self.shiftMode
	love.graphics.setColor(c1)
	Base.print('z', x - w * 1, 0, 'center')

	c1[4] = (1 - self.shiftMode)
	love.graphics.setColor(c1)
	Base.print('x', x - w * 5, 0, 'center')

	love.graphics.setColor(Base.color.darkGray)
	Base.print('y', x - w * 3, 0, 'center')
	Base.print('[', x - w * (6 - self.shiftMode * 2), 0, 'center')
	Base.print(',', x - w * (4 - self.shiftMode * 2), 0, 'center')
	Base.print(']', x - w * (2 - self.shiftMode * 2), 0, 'center')
end


---@param dt number
function Level:updateShape(dt)

	if self.isFinish then
		return
	end

	for key, shape in pairs(self.shapeList) do
		-- update
		if shape.update ~= nil then
			-- a new table, remove shape
			local listWithoutSelf = Base.cloneTable(self.shapeList)
			table.remove(listWithoutSelf, key)

			shape:update(dt, self.shiftMode, listWithoutSelf)
		end

		-- hit player
		if shape:is(Laser) or shape:is(Ball) or shape:is(MoveCuboid) then
			if shape:hitPlayer(player, self.shiftMode) then
				self:playerDead()
			end
		end
	end
end


--- todo: rewrite !!!
function Level:sortDrawList()
	if self.shiftMode == 0 then
		-- sort by z
		for i=1, #self.drawList do
			local j = i
			for k = i + 1, #self.drawList do
				if self.drawList[k].position.z > self.drawList[j].position.z then
					j, k = k, j
				end
			end
			self.drawList[i], self.drawList[j] = self.drawList[j], self.drawList[i]
		end
	elseif self.shiftMode == 1 then
		-- sort by y
		for i=1, #self.drawList do
			local j = i
			for k= i + 1, #self.drawList do
				if self.drawList[k].position.y < self.drawList[j].position.y then
					j, k = k, j
				end
			end
			self.drawList[i], self.drawList[j] = self.drawList[j], self.drawList[i]
		end
	-- shifting, by z, then by y
	else
		-- sort by z
		for i=1, #self.drawList do
			local j = i
			for k=i+1, #self.drawList do
				if self.drawList[k].position.z > self.drawList[j].position.z then
					j, k = k, j
				end
			end
			self.drawList[i], self.drawList[j] = self.drawList[j], self.drawList[i]
		end
		-- sort by y
		for i=1, #self.drawList do
			local j = i
			for k=i+1, #self.drawList do
				if self.drawList[k].position.z == self.drawList[j].position.z and self.drawList[k].position.y < self.drawList[j].position.y then
					j, k = k, j
				end
			end
			self.drawList[i], self.drawList[j] = self.drawList[j], self.drawList[i]
		end
	end
end


return Level