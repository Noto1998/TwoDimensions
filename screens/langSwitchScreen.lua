local Screen = Object:extend()

local langFile

function Screen:new(ScreenManager)
	self.screen = ScreenManager
end

function Screen:activate()
	love.graphics.clear()
end

function Screen:update(dt)
	-- switch lang
	if base.isDown(base.keys.enter) or base.isDown(base.keys.cancel) or base.isDown(base.keys.keyTips) then
		local langFile
		if base.isDown(base.keys.enter) then
			langFile = "lib.lang.lang_cn"
		elseif base.isDown(base.keys.cancel) then
			langFile = "lib.lang.lang_en"
		elseif base.isDown(base.keys.keyTips) then
			langFile = "lib.lang.lang_jp"
		end
		lang = require(langFile)
		
		-- goto MainScreen
		self.screen:view("MainScreen")
	end
end

function Screen:draw()
	love.graphics.setColor(base.cWhite)
	base.print("A - 中文\nB - English\nX - 日本語")
end

return Screen