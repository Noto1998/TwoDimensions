Level = Shift:extend()

local finishFlag, finishTimer
local gotoMainScreenTimerMax = 1-- second
local keyTips
local player, endCube
local _isTutorial


function Level:activate(playerX, playerY, playerZ, endCubeX, endCubeY, endCubeZ, levelName, isTutorial)
	-- shift
	Level.super.activate(self)
	
	-- player and endCube
	player = Player(playerX, playerY, playerZ)
	endCube = EndCube(endCubeX, endCubeY, endCubeZ)

	-- shapeList
	self.shapeList = {}
	table.insert(self.shapeList, endCube)
	
	-- drawList
	self.drawList = {}
	table.insert(self.drawList, player)
	table.insert(self.drawList, endCube)

	-- tipsList
	self.tipsList = {}
	
	-- levelName
	self.levelName = 'levelName missing!'
	if levelName ~= nil then
		self.levelName = levelName
	end

	-- for Tutorial switch
	_isTutorial = false
	if isTutorial ~= nil then
		_isTutorial = isTutorial
	end

	-- finishLevelTimer
	finishFlag = false
	finishTimer = 0
	gotoMainScreenTimer = 0
	
	-- keyTips
	keyTips = KeyTips()
end


function Level:update(dt, canShift)
	-- shift/bgmManager/pressedSetting
	canShift = (self.shiftMode~=1 or player:isOnGround()) and (not finishFlag) and (not keyTips:getShowFlag()) and (canShift == nil or canShift==true)
	Level.super.update(self, dt, canShift)
	
	-- keyTips
	if not _isTutorial then
		keyTips:update()
	end

	-- some key staff
	if (not finishFlag) and (not keyTips:getShowFlag()) then
		-- reset
		if Base.isPressed(Base.keys.reset) then
			self.screen:view(RESET_LEVEL_PATH)
		end

		-- goto MainScreens
		if Base.isHold(Base.keys.cancel, gotoMainScreenTimerMax) then
			self.screen:view('MainScreen')
		end

		-- player move
		player:update(dt, self.shiftMode, self.shapeList)
	end

	-- goto next level
	if finishFlag then
		if not showDoc and Base.isPressed(Base.keys.enter) then
			LEVEL_CHOICE = LEVEL_CHOICE + 1
			local levelName = LEVEL_STRING[LEVEL_CHOICE]
			self.screen:view(levelName)
		end
	end

	-- shape update
	for i = 1, #self.shapeList do
		-- laser
		if self.shapeList[i]:is(Laser) then
			-- turn on/ballBlock/reflex
			self.shapeList[i]:update(dt, self.shiftMode, self.shapeList, player)
			
			-- hit player
			if self.shiftMode == 0 and self.shapeList[i]:hitPlayer(player) and not finishFlag then
				self:playerDead()
			end
			
		-- Ball
		elseif self.shapeList[i]:is(Ball) then
			self.shapeList[i]:update(dt, self.shiftMode, self.shapeList)

			-- hit player
			if self.shapeList[i]:hit(player, self.shiftMode) and not finishFlag then
				self:playerDead()
			end
		-- FourD
		elseif self.shapeList[i]:is(FourD) then
			self.shapeList[i]:update(self.shiftMode)
		-- MoveCuboid
		elseif self.shapeList[i]:is(MoveCuboid) then
			self.shapeList[i]:update(dt, self.shiftMode, self.shapeList)
			-- hit
			if player:touch(self.shapeList[i], self.shiftMode) then
				self:playerDead()
			end
		end
	end
	
	-- finish level
	if player:touch(endCube, self.shiftMode) then
		if not finishFlag then
			finishFlag = true
			--sfx
			love.audio.play(SFX_FINISH)
		end
	end

	--- sort drawList
	if self.shiftMode == 0 then
		-- sort by z
		for i=1, #self.drawList do
			local j = i
			for k=i+1, #self.drawList do
				if self.drawList[k].z > self.drawList[j].z then
					j, k = k, j
				end
			end
			self.drawList[i], self.drawList[j] = self.drawList[j], self.drawList[i]
		end
	elseif self.shiftMode == 1 then
		-- sort by y
		for i=1, #self.drawList do
			local j = i
			for k=i+1, #self.drawList do
				if self.drawList[k].y < self.drawList[j].y then
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
				if self.drawList[k].z > self.drawList[j].z then
					j, k = k, j
				end
			end
			self.drawList[i], self.drawList[j] = self.drawList[j], self.drawList[i]
		end
		-- sort by y
		for i=1, #self.drawList do
			local j = i
			for k=i+1, #self.drawList do
				if self.drawList[k].z == self.drawList[j].z and self.drawList[k].y < self.drawList[j].y then
					j, k = k, j
				end
			end
			self.drawList[i], self.drawList[j] = self.drawList[j], self.drawList[i]
		end
	end
	---
end


function Level:draw()
	-- draw BG
	love.graphics.setColor(Base.color.black)
	love.graphics.rectangle('fill', 0, 0, Base.gui.width, Base.gui.height)

	-- draw all obj in drawList
	if self.drawList ~= nil then
		for key, value in pairs(self.drawList) do
			value:draw(self.shiftMode)
		end
	end

	-- draw tips
	if self.tipsList ~= nil then
		for i = 1, #self.tipsList do
			self.tipsList[i]:draw(self.shiftMode)
		end
	end

	-- draw levelName
	love.graphics.setColor(Base.color.white)
	Base.print(self.levelName, Base.gui.border, Base.gui.height, 'left', 'bottom')
	
	-- bgmManager
	bgmManager:draw()

	-- draw stuck warning
	if self.shiftMode == 0 and player.stuck then
		love.graphics.setColor(Base.color.white)
		Base.print(Lang.ui_player_stuck, Base.gui.width/2, Base.gui.height/2, 'center', 'center')
	end

	-- XYZ
	self:drawXYZ()

	-- hide
	if not _isTutorial then
		-- draw keyTips text
		love.graphics.setColor(Base.color.darkGray)
		Base.print(Lang.ui_key_keyTips, Base.gui.width-Base.gui.border, Base.gui.height, 'right', 'bottom')
		
		-- draw keyTips
		keyTips:draw()
	end

	-- draw finishLevel
	if finishFlag then
		love.graphics.setColor(0,0,0, 0.9)
		love.graphics.rectangle('fill', 0, 0, Base.gui.width, Base.gui.height)
		love.graphics.setColor(Base.color.white)
		Base.print(Lang.ui_level_finish, Base.gui.width/2, Base.gui.height/3, 'center', 'center')
		local string = Lang.ui_key_continue
		Base.print(string, Base.gui.width/2, Base.gui.height/3*2, 'center', 'center')
	end
end


-- function
function Level:addShapeList(obj, ...)
	table.insert(self.shapeList, obj(...))
	-- add to drawList
	table.insert(self.drawList, self.shapeList[#self.shapeList])
end

function Level:addTipsList(...)
	table.insert(self.tipsList, Tips(...))
end

function Level:playerDead()
	-- sfx
	SFX_RESTART:seek(0.15)
	love.audio.play(SFX_RESTART)
	-- reset
	self.screen:view(RESET_LEVEL_PATH)
end

function Level:drawXYZ()
	local w = 15
	local _x = Base.gui.border+w*6
	local c1 = Base.cloneTable(Base.color.darkGray)
	c1[4] = self.shiftMode
	love.graphics.setColor(c1)
	Base.print('z', _x-w*1, 0, 'center')
	c1[4] = (1-self.shiftMode)
	love.graphics.setColor(c1)
	Base.print('x', _x-w*5, 0, 'center')
	love.graphics.setColor(Base.color.darkGray)
	Base.print('y', _x-w*3, 0, 'center')
	Base.print('[', _x-w*(6-self.shiftMode*2), 0, 'center')
	Base.print(',', _x-w*(4-self.shiftMode*2), 0, 'center')
	Base.print(']', _x-w*(2-self.shiftMode*2), 0, 'center')
end