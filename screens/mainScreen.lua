local Screen = Shift:extend()

local index
local pageHide = 4	--hide
local imgGameLogo, imgMofishLogo
local tipsList
local levelChoiceTips

local function getLevelName(index)
	local levelName, levelNameLang

	-- hiden level
	if index > (#LEVEL_STRING - pageHide) then
		levelNameLang = '???'
	else
		levelName = LEVEL_STRING[index]
		levelNameLang = Lang[levelName]
	end

	if levelNameLang == nil then
		error('level \"'..levelName..'\" do not exist')
	end

	return levelNameLang
end


function Screen:activate()
	Screen.super.activate(self)

	index = 1

	-- img
	imgGameLogo = love.graphics.newImage('img/gameLogo.png')
	imgMofishLogo = love.graphics.newImage('img/mofishLogo.png')

	--- tips
	local y1 = Base.gui.height - Base.gui.fontHeight
	local y2 = y1 - (Base.gui.fontHeight + Base.gui.border)
	local creditsY = Base.gui.fontHeight
	local widthCenter = Base.gui.width / 2
	local positon1 = Base.createPosition(widthCenter, y2, -50)
	local positon2 = Base.createPosition(widthCenter, y1, -50)
	local positon3 = Base.createPosition(widthCenter, Base.gui.height + 50, creditsY)
	local uiLevelChoice = Lang.ui_level_choice(index, getLevelName(index))

	levelChoiceTips = Tips(uiLevelChoice,   positon1, 'center', 'bottom')
	tipsList = {
		levelChoiceTips,
		Tips(Lang.ui_key_start_and_move,    positon2, 'center', 'bottom'),
		Tips(Lang.ui_thank_you_for_playing, positon3, 'center')
	}

	for i, tipsString in ipairs(Lang.ui_credits) do
		local positon = Base.createPosition(widthCenter, Base.gui.height + 50, creditsY + (Base.gui.fontHeight + Base.gui.border / 2) * i)

		table.insert(
			tipsList,
			Tips(tipsString, positon, 'center')
		)
	end
end


function Screen:update(dt)
	Screen.super.update(self, dt)

	if self.shiftMode ~= 0 then
		return
	end

	-- switch level
	if Base.isPressed(Base.keys.right) or Base.isPressed(Base.keys.left) then

		local levelMax = #LEVEL_STRING - pageHide + 1-- 1 is the '???' level

		-- change index
		if Base.isPressed(Base.keys.right) then
			index = Base.ternary(index < levelMax, index + 1, 1)
		else
			index = Base.ternary(index > 1, index - 1, levelMax)
		end

		-- update levelName
		local levelName = Lang.ui_level_choice(index, getLevelName(index))
		levelChoiceTips:changeText(levelName)

		-- play sfx
		love.audio.play(SFX_MENU)
	end

	-- start level
	if Base.isPressed(Base.keys.enter) and index <= (#LEVEL_STRING - pageHide) then
		self.screen:view(LEVEL_STRING[index], index)
	end
end


function Screen:draw()

	-- draw BG
	love.graphics.setColor(Base.color.black)
	love.graphics.rectangle('fill', 0, 0, Base.gui.width, Base.gui.height)

	-- bgmManager
	bgmManager:draw()

	-- logo
	local color1 = Base.cloneTable(Base.color.white)
	local color2 = Base.cloneTable(Base.color.white)
	local scale1 = 0.9
	local scale2 = 0.3
	color1[4] = 1 - self.shiftMode
	color2[4] = self.shiftMode
	love.graphics.setColor(color1)
	love.graphics.draw(imgGameLogo, Base.gui.width * ( 1 - scale1 ) / 2, 10, 0, scale1, scale1)
	love.graphics.setColor(color2)
	love.graphics.draw(imgMofishLogo, Base.gui.width * (1 - scale2) / 2, Base.gui.height - imgMofishLogo:getHeight() * scale2, 0, scale2, scale2)

	-- tips
	for key, tips in pairs(tipsList) do
		tips:draw(self.shiftMode)
	end

	-- key_credits
	local color3 = Base.cloneTable(Base.color.darkGray)
	color3[4] = self.shiftMode
	love.graphics.setColor(color3)
	Base.print(Lang.ui_key_credits, Base.gui.width - Base.gui.border - Base.gui.fontHeight, 0, 'right')
end


return Screen