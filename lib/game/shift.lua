local Shift = Object:extend()


function Shift:new(ScreenManager)
	self.screen = ScreenManager
end


function Shift:activate()

	self.shiftMode = 0-- 0=xy, 1=xz
	self.shiftFlag = false
	self.shifting = false
	self.shiftSpd = 0
end


function Shift:update(dt, canShift)
	-- pressed setting, only use once, so time only add once
	for k, keyName in pairs(base.keys) do
		keyName.isPressed = base.pressedSetting(keyName, dt)
	end

	-- update shiftMode
	if self.shifting then
		local SHIFT_ADD_SPD = 2 * dt
		local SHIFT_ADD_TIME = 0.3
		local SHIFT_TIMER_MAX = 1.25

		-- start spd
		if self.shiftMode == 0 or self.shiftMode == 1 then
			self.shiftSpd = 0
		end
		
		-- add spd
		if self.shiftFlag then
			if self.shiftMode < SHIFT_ADD_TIME then
					self.shiftSpd = self.shiftSpd + SHIFT_ADD_SPD
			elseif self.shiftMode > 1-SHIFT_ADD_TIME then
				self.shiftSpd = self.shiftSpd - SHIFT_ADD_SPD
			end
		else
			if self.shiftMode < SHIFT_ADD_TIME then
				self.shiftSpd = self.shiftSpd - SHIFT_ADD_SPD
			elseif self.shiftMode > 1-SHIFT_ADD_TIME then
				self.shiftSpd = self.shiftSpd + SHIFT_ADD_SPD
			end
		end
		
		local _dt = math.abs(self.shiftSpd) / SHIFT_TIMER_MAX * dt
		
		-- change shiftMode
		if self.shiftMode < 1 and self.shiftFlag then
			local _border =  1 - self.shiftMode
			if _border < _dt then
				self.shiftMode = 1
				self.shifting = false -- close
			else
				self.shiftMode = self.shiftMode + _dt
			end
		end
		
		if self.shiftMode > 0 and not self.shiftFlag then
			if self.shiftMode < _dt then
				self.shiftMode = 0
				self.shifting = false -- close
			else
				self.shiftMode = self.shiftMode - _dt
			end
		end
		
		-- close
		if self.shiftMode == 0 or self.shiftMode == 1 then
			self.shiftSpd = 0
		end
	end
	
	-- switch shiftMode
	if (canShift == nil or canShift == true) and
	base.isPressed(base.keys.shift) and not self.shifting then
		self.shiftFlag = not self.shiftFlag
		self.shifting = true
		-- play sfx
		love.audio.play(sfx_shift)
	end

	-- bgmManager
	bgmManager:update()
end

return Shift