local Shift = Object:extend()

local timer
local TIMER_MAX = 1.25

function Shift:new(ScreenManager)
	self.screen = ScreenManager
end


function Shift:activate()

	self.shiftMode = 0-- 0 ~ 1, 0 = xy, 1 = xz.
	self.shiftFlag = 0-- 0 or 1.
	self.isShifting = false

	timer = 0
end


function Shift:update(dt, canShift)

	Base.setAllKeys(dt)
	bgmManager:update()

	-- update shiftMode.
	if self.isShifting then
		local t = timer / TIMER_MAX-- 0 to 1
		if t > 1 then
			t = 1
		end

		timer = timer + dt

		-- using non-linear function to update shiftMode, (shiftFlag is 1) means shiftMode need to up to 1, vice versa
		self.shiftMode = Base.ternary(self.shiftFlag == 1, Base.mix(t), 1 - Base.mix(t))

		-- finish
		if self.shiftMode == self.shiftFlag then
				self.isShifting = false
		end
	end

	-- switch shiftMode. (xx ~= false) is the same as (xx==nil or xx==true)
	if Base.isPressed(Base.keys.shift) and (canShift ~= false) and (not self.isShifting) then

		self.shiftFlag = Base.ternary(self.shiftFlag == 0, 1, 0)
		self.isShifting = true
		timer = 0

		love.audio.play(SFX_SHIFT)-- play sfx
	end
end

return Shift