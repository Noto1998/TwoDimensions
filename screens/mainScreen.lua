local Screen = Shift:extend()

local index
local pageHide = 4	--hide
local imgGameLogo, imgMofishLogo
local tipsList

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
	-- shift
	Screen.super.activate(self)

	-- img
	index = 1
	imgGameLogo = love.graphics.newImage('img/gameLogo.png')
	imgMofishLogo = love.graphics.newImage('img/mofishLogo.png')

	--- tips
	local y1 = Base.gui.height-Base.gui.fontHeight
	local y2 = y1-(Base.gui.fontHeight+Base.gui.border)
	local creditsY = Base.gui.fontHeight

	tipsList = {
		Tips(Lang.ui_level_choice(index, getLevelName(index)), Base.gui.width/2, y2, -50, 'center', 'bottom'),
		Tips(Lang.ui_key_start_and_move,	Base.gui.width/2, y1, -50, 'center', 'bottom')
	}
	table.insert(
		tipsList,
		Tips(Lang.ui_thank_you_for_playing,		Base.gui.width/2, Base.gui.height+50, creditsY, 'center')
	)
	for i, tipsString in ipairs(Lang.ui_credits) do
		table.insert(
			tipsList,
			Tips(tipsString,		Base.gui.width/2, Base.gui.height+50, creditsY + (Base.gui.fontHeight+Base.gui.border/2)*i,	'center')
		)
	end
end


function Screen:update(dt)
	-- shift/bgmManager/pressedSetting
	Screen.super.update(self, dt)

	-- switch level
	if self.shiftMode == 0 then
		if Base.isPressed(Base.keys.right) or Base.isPressed(Base.keys.left) then
			local levelMax = #LEVEL_STRING - pageHide + 1-- show the laser

			-- change index
			if Base.isPressed(Base.keys.right) then
				if index < levelMax then
					index = index + 1
				else
					index = 1
				end
			elseif Base.isPressed(Base.keys.left) then
				if index > 1 then
					index = index - 1
				else
					index = levelMax
				end
			end

			-- update levelName string
			local levelName = Lang.ui_level_choice(index, getLevelName(index))
			tipsList[1]:changeText(levelName)

			-- play sfx
			love.audio.play(SFX_MENU)
		end

		-- start level
		if Base.isPressed(Base.keys.enter) and index <= (#LEVEL_STRING - pageHide) then
			self.screen:view(LEVEL_STRING[index], index)
		end
	end
end


function Screen:draw()
	-- draw BG
	love.graphics.setColor(Base.color.black)
	love.graphics.rectangle('fill', 0, 0, Base.gui.width, Base.gui.height)

	-- bgmManager
	bgmManager:draw()

	-- logo
	local c1 = Base.cloneTable(Base.color.white)
	local c2 = Base.cloneTable(Base.color.white)
	local scale1 = 0.9
	local scale2 = 0.3
	c1[4] = 1 - self.shiftMode
	c2[4] = self.shiftMode
	love.graphics.setColor(c1)
	love.graphics.draw(imgGameLogo, Base.gui.width*(1-scale1)/2, 10, 0, scale1, scale1)
	love.graphics.setColor(c2)
	love.graphics.draw(imgMofishLogo, Base.gui.width*(1-scale2)/2, Base.gui.height-imgMofishLogo:getHeight()*scale2, 0, scale2, scale2)

	-- tips
	for key, obj in pairs(tipsList) do
		obj:draw(self.shiftMode)
	end

	-- credits
	local c3 = Base.cloneTable(Base.color.darkGray)
	c3[4] = self.shiftMode
	love.graphics.setColor(c3)
	Base.print(Lang.ui_key_credits, Base.gui.width-Base.gui.border-Base.gui.fontHeight, 0, 'right')
end


return Screen