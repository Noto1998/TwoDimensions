local Screen = Shift:extend()

local page
local pageHide = 4	--hide
local imgGameLogo, imgMofishLogo
local tipsList

local function getLevelName(page)
	local levelName = LEVEL_STRING[page]
	local string = Lang[levelName]
	
	if string==nil then
		error('level name do not exist')
	end

	-- hiden level
	if page > (#LEVEL_STRING - pageHide) then
		string = '???'
	end

	return string
end


function Screen:activate()
	-- shift
	Screen.super.activate(self)

	-- img
	page = 1
	imgGameLogo = love.graphics.newImage('img/gameLogo.png')
	imgMofishLogo = love.graphics.newImage('img/mofishLogo.png')

	--- tips
	local y1 = Base.guiHeight-Base.guiFontHeight
	local y2 = y1-(Base.guiFontHeight+Base.guiBorder)
	local creditsY = Base.guiFontHeight

	tipsList = {
		Tips(Lang.ui_level_choice(page, getLevelName(page)), Base.guiWidth/2, y2, -50, 'center', 'bottom'),
		Tips(Lang.ui_key_start_and_move,	Base.guiWidth/2, y1, -50, 'center', 'bottom')
	}
	table.insert(
		tipsList,
		Tips(Lang.ui_thank_you_for_playing,		Base.guiWidth/2, Base.guiHeight+50, creditsY, 'center')
	)
	for i, tipsString in ipairs(Lang.ui_credits) do
		table.insert(
			tipsList,
			Tips(Lang.ui_credits[i],		Base.guiWidth/2, Base.guiHeight+50, creditsY + (Base.guiFontHeight+Base.guiBorder/2)*i,	'center')
		)
	end
	
end


function Screen:update(dt)
	-- shift/bgmManager/pressedSetting
	Screen.super.update(self, dt)
	
	-- switch level
	if self.shiftMode == 0 then
		if Base.isPressed(Base.keys.right) or Base.isPressed(Base.keys.left) then
			local levelMax = #LEVEL_STRING - pageHide + 1--show the laser
			
			-- change page
			if Base.isPressed(Base.keys.right) then
				if page < levelMax then
					page = page + 1
				else
					page = 1
				end
			elseif Base.isPressed(Base.keys.left) then
				if page > 1 then
					page = page - 1
				else
					page = levelMax
				end
			end
			
			-- update levelName string
			tipsList[1].string = Lang.ui_level_choice(page, getLevelName(page))

			-- sfx
			love.audio.play(SFX_MENU)
		end

		-- start level
		if Base.isPressed(Base.keys.enter) and page <= (#LEVEL_STRING - pageHide) then 
			LEVEL_CHOICE = page
			self.screen:view(LEVEL_STRING[LEVEL_CHOICE])
		end
	end
end


function Screen:draw()
	-- draw BG
	love.graphics.setColor(Base.cBlack)
	love.graphics.rectangle('fill', 0, 0, Base.guiWidth, Base.guiHeight)

	-- bgmManager
	bgmManager:draw()
	
	-- logo
	local c1 = Base.cloneTable(Base.cWhite)
	local c2 = Base.cloneTable(Base.cWhite)
	local scale1 = 0.9
	local scale2 = 0.3
	c1[4] = 1 - self.shiftMode
	c2[4] = self.shiftMode
	love.graphics.setColor(c1)
	love.graphics.draw(imgGameLogo, Base.guiWidth*(1-scale1)/2, 10, 0, scale1, scale1)
	love.graphics.setColor(c2)
	love.graphics.draw(imgMofishLogo, Base.guiWidth*(1-scale2)/2, Base.guiHeight-imgMofishLogo:getHeight()*scale2, 0, scale2, scale2)

	-- tips
	for key, obj in pairs(tipsList) do
		obj:draw(self.shiftMode)
	end

	-- credits
	local c1 = Base.cloneTable(Base.cDarkGray)
	local c2 = Base.cloneTable(Base.cDarkGray)
	c2[4] = self.shiftMode
	love.graphics.setColor(c2)
	Base.print(Lang.ui_key_credits, Base.guiWidth-Base.guiBorder-Base.guiFontHeight, 0, 'right')
end


return Screen