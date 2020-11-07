local Screen = Object:extend()

function Screen:new(ScreenManager)
	self.screen = ScreenManager
end

function Screen:activate()
	love.graphics.clear()
end

function Screen:update(dt)
	-- switch Lang
	if Base.isDown(Base.keys.enter) or Base.isDown(Base.keys.cancel) or Base.isDown(Base.keys.keyTips) then
		local langFile
		if Base.isDown(Base.keys.enter) then
			langFile = 'lib.Lang.lang_cn'
		elseif Base.isDown(Base.keys.cancel) then
			langFile = 'lib.Lang.lang_en'
		elseif Base.isDown(Base.keys.keyTips) then
			langFile = 'lib.Lang.lang_jp'
		end
		Lang = require(langFile)

		-- goto MainScreen
		self.screen:view('MainScreen')
	end
end

function Screen:draw()
	love.graphics.setColor(Base.color.white)
	Base.print('A - 中文\nB - English\nX - 日本語')
end

return Screen