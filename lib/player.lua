Player = Rectangle:extend()

local sfxPlayed

function Player:new(x, y, z)
	local len = base.player.len
	local cFill = base.cloneTable(base.cGray)
	cFill[4] = 0.5
	local cMesh = {0,0,0,0}
	--
	Player.super.new(self, x, y, z, len, len, 0, cFill, base.cLine, cMesh)

	self.stuck = false
	self.onGround = {false, false}
	self.spdX = 0
	self.spdY = 0

	sfxPlayed = {true, true}
end


function Player:update(dt, mode, shapeList)
	if mode == 0 then
		-- move
		self:moveXY(dt)
		self:collisionXY(dt, shapeList)
		--
		self.x = self.x + self.spdX * dt
		self.y = self.y + self.spdY * dt
	elseif mode == 1 then
		-- onGround
		for i = 1, 2 do
			self.onGround[i] = self:PointOnGround(i, shapeList)
		end
		-- move
		self:collisionXZ(dt)

		--sfx
		for i = 1, 2 do
			if self.onGround[i] then
				if not sfxPlayed[i] then
					love.audio.play(sfx_touchGound)
					sfxPlayed[i] = true
				end
			else
				sfxPlayed[i] = false
			end
		end
	end
end


function Player:draw(mode)
	Player.super.draw(self, mode)
	
	if mode == 1 then
		-- point
		for i = 1, 2 do
			local cPoint = base.cDarkGray
			if self.onGround[i] then
				cPoint = base.cWhite
			end
			--
			love.graphics.setColor(cPoint)
			love.graphics.circle("fill", self:getX(i), self:getZ(i), 3)
		end

		--[[debug
		love.graphics.setColor(base.cWhite)
		love.graphics.circle("line", self:getX(1), self:getZ(1), 5)
		]]
	end
end


function Player:moveXY(dt)
	-- x
	if base.isDown(base.keys.left) then
		self.spdX = -base.player.spdXY
	elseif base.isDown(base.keys.right) then
		self.spdX = base.player.spdXY
	else
		self.spdX = 0
	end
	-- y
	if base.isDown(base.keys.up) then
		self.spdY = -base.player.spdXY
	elseif base.isDown(base.keys.down) then
		self.spdY = base.player.spdXY
	else
		self.spdY = 0
	end
	-- 45
	if self.spdX ~= 0 and self.spdY ~= 0 then
		self.spdX = base.player.spdXY / math.sqrt(2) * base.sign(self.spdX)
		self.spdY = base.player.spdXY / math.sqrt(2) * base.sign(self.spdY)
	end
end

function Player:moveXZ(dt)
	local spdXZ

	--
	if base.isDown(base.keys.left) then
		spdXZ = -base.player.spdXZ
	elseif base.isDown(base.keys.right) then
		spdXZ = base.player.spdXZ
	else
		spdXZ = 0
	end
	--
	self.dir = self.dir + spdXZ * dt
end

function Player:collisionXY(dt, shapeList)
	self.stuck = false

	--
	for key, obj in pairs(shapeList) do
		if obj:is(Rectangle) or obj:is(Cuboid) then
			local x1 = self:getX(self:getLeftX())
			local x2 = self:getX(self:getRightX())
			local y1 = self.y
			local y2 = self.y + self.lenY
			local centerX = (x1 + x2)/2
			local centerY = (y1 + y2)/2

			local oXList
			local oYList = {obj.y, obj.y+obj.lenY}
			--
			if obj:is(Rectangle) then
				oXList = {obj:getX(obj:getLeftX()), obj:getX(obj:getRightX())}
			elseif obj:is(Cuboid) then
				oXList = {obj.x, obj.x+obj.lenX}
			end

			-- x
			if y2 > oYList[1] and y1 < oYList[2] then
				-- check how far between x and the line
				for key, xValue in pairs(oXList) do
					local disX = math.abs(centerX - xValue)
					local signX = base.sign(centerX - xValue)
					local disMin = math.abs(self:getLenDX()/2)
					-- stuck
					if disX+1 < disMin then
						self.stuck = true
						self.spdY = 0
						self.spdX = 0
					-- push
					elseif math.abs(disX*signX + self.spdX*dt) < disMin then
						self.x = xValue + disMin*signX - self:getLenDX()/2
						self.spdX = 0
					end
				end
			end
			-- y
			if x2 > oXList[1] and x1 < oXList[2] then
				-- check how far between y and the line
				for key, yValue in pairs(oYList) do
					local disY = math.abs(centerY - yValue)
					local signY = base.sign(centerY - yValue)
					local disMin = math.abs(self.lenY/2)
					-- stuck
					if disY+1 < disMin then
						self.stuck = true
						self.spdY = 0
						self.spdX = 0
					-- push
					elseif math.abs(disY*signY + self.spdY*dt) < disMin then
						self.y = yValue + disMin*signY -self.lenY/2
						self.spdY = 0
					end
				end
			end
		end

		
	end
end
function Player:isCollisionXY(obj)
	local flag = false
	local x1 = self:getX(self:getLeftX())
	local x2 = self:getX(self:getRightX())
	local y1 = self.y
	local y2 = self.y + self.lenY

	if obj:is(Rectangle) then
		if 	y1 <= obj.y + obj.lenY
		and y2 >= obj.y
		and x1 <= obj:getX(2)
		and x2 >= obj:getX(1) then
			flag = true
		end
	elseif obj:is(Cuboid) then
		if 	y1 <= obj.y + obj.lenY
		and y2 >= obj.y
		and x1 <= obj.x + obj.lenX
		and x2 >= obj.x then
			flag = true
		end
	end

	return flag
end

function Player:PointOnGround(num, shapeList)
	local flag = false
	local x = self:getX(num)
	local z = self:getZ(num)

	for key, obj in pairs(shapeList) do
		if obj:is(Rectangle) or obj:is(Cuboid) or obj:is(Ball) then
			flag = obj:collisionPointXZ(x, z)
		end
		--
		if flag then
			break
		end
	end
	
	return flag
end

function Player:collisionXZ(dt)
	-- both not onGround
	if not self.onGround[1] and not self.onGround[2] then
		-- garvity
		self.z = self.z + base.garvity * dt
	else
		--both onGround
		if self.onGround[1] and self.onGround[2] then
			-- setting main point
			if (base.isDown(base.keys.left) and self.x ~= self:getX(self:getLeftX()))
			or (base.isDown(base.keys.right) and self.x ~= self:getX(self:getRightX())) then
				self.x = self:getX(2)
				self.z = self:getZ(2)
				self.dir = -(math.pi-self.dir)
			end
		-- one side onGround
		else
			-- setting main point
			if not self.onGround[1] then
				self.x = self:getX(2)
				self.z = self:getZ(2)
				self.dir = -(math.pi-self.dir)
			end
			-- garvity
			if (not base.isDown(base.keys.left)) and (not base.isDown(base.keys.right)) then
				local spdG
				--
				if self:getLeftX() == 1 then
					spdG = base.player.spdXZ
				else
					spdG = -base.player.spdXZ
				end
				--
				self.dir = self.dir + spdG * dt
			end
		end
		-- control dir
		self:moveXZ(dt)
		
		-- fix dir
		if self.dir <= -math.pi*2 then
			self.dir = self.dir + math.pi*2
		elseif self.dir >= math.pi*2 then
			self.dir = self.dir - math.pi*2
		end
	end
end

function Player:isOnGround()
	return self.onGround[1] and self.onGround[2]
end

function Player:touch(obj, mode)
	local flag = false

	if mode == 0 then
		if self:isCollisionXY(obj) then
		flag = true
		end
	elseif mode == 1 then
		for i = 1, 2 do
			if self:PointOnGround(i, {obj}) then
				flag = true
				break
			end
		end
	end

	return flag
end