local Player = Rectangle:extend()

local function setPointsOnGround(self, shapeList)
	for i = 1, #self.points do
		self.points[i].isOnGround = self:isPointOnGroundWithShapeList(i, shapeList)
	end
end

local function setSfx(self)
	for i = 1, #self.points do
		if self:isPointOnGround(i) then
			if not self.points[i].isSfxPlayed then
				love.audio.play(SFX_TOUCH_GOUND)
				self.points[i].isSfxPlayed = true
			end
		else
			self.points[i].isSfxPlayed = false
		end
	end
end

function Player:new(x, y, z)

	local len = Base.player.len
	local colorFill = Base.cloneTable(Base.color.gray)
	colorFill[4] = 0.5
	local colorMesh = {0, 0, 0, 0}
	Player.super.new(self, x, y, z, len, len, 0, colorFill, Base.color.line, colorMesh)

	self.stuck = false
	self.spdX = 0
	self.spdY = 0
	self.points = {
		{isOnGround = false, isSfxPlayed = true},
		{isOnGround = false, isSfxPlayed = true}
	}
end


function Player:update(dt, mode, shapeList)

	if mode == 0 then

		-- move
		self:moveXY()
		self:setCollisionXY(dt, shapeList)
		-- update position
		self.position.x = self.position.x + self.spdX * dt
		self.position.y = self.position.y + self.spdY * dt
	elseif mode == 1 then

		setPointsOnGround(self, shapeList)
		self:collisionXZ(dt)-- move
		setSfx(self)
	end
end


function Player:draw(mode)
	Player.super.draw(self, mode)

	-- draw points
	if mode == 1 then
		for i = 1, #self.points do
			local radius = 3
			local cPoint = Base.ternary(self:isPointOnGround(i), Base.color.white, Base.color.darkGray)

			love.graphics.setColor(cPoint)
			love.graphics.circle('fill', self:getPointX(i), self:getPointZ(i), radius)
		end
	end
end

--- lua don't have overloaded!
---@param index number
---@param shapeList table
---@return boolean
function Player:isPointOnGroundWithShapeList(index, shapeList)

	local flag = false
	local x = self:getPointX(index)
	local z = self:getPointZ(index)

	for key, shape in pairs(shapeList) do
		if shape:is(Rectangle) or shape:is(Cuboid) or shape:is(Ball) then
			flag = shape:isCollisionInXZ(x, z)

			if flag then
				break
			end
		end
	end

	return flag
end


---@param index number
---@return boolean
function Player:isPointOnGround(index)
	return self.points[index].isOnGround
end


---@return boolean
function Player:isOnGround()
	return self:isPointOnGround(1) and self:isPointOnGround(2)
end


function Player:moveXY()

	if Base.isDown(Base.keys.left) then
		self.spdX = -Base.player.spdXY
	elseif Base.isDown(Base.keys.right) then
		self.spdX = Base.player.spdXY
	else
		self.spdX = 0
	end

	if Base.isDown(Base.keys.up) then
		self.spdY = -Base.player.spdXY
	elseif Base.isDown(Base.keys.down) then
		self.spdY = Base.player.spdXY
	else
		self.spdY = 0
	end

	-- 45 degree
	if self.spdX ~= 0 and self.spdY ~= 0 then
		local spd45 = Base.player.spdXY / math.sqrt(2)

		self.spdX = spd45 * Base.sign(self.spdX)
		self.spdY = spd45 * Base.sign(self.spdY)
	end
end


function Player:moveXZ(dt)
	local spdXZ

	if Base.isDown(Base.keys.left) then
		spdXZ = -Base.player.spdXZ
	elseif Base.isDown(Base.keys.right) then
		spdXZ = Base.player.spdXZ
	else
		spdXZ = 0
	end

	self.radian = self.radian + spdXZ * dt
end


---@param dt number
---@param shapeList table
function Player:setCollisionXY(dt, shapeList)
	self.stuck = false

	local left 	 = self:getPointX(self:getPointIndex('left'))
	local right  = self:getPointX(self:getPointIndex('right'))
	local top 	 = self.position.y
	local bottom = self.position.y + self.lenY
	local centerX = (left + right) / 2
	local centerY = (top + bottom) / 2

	for key, obj in pairs(shapeList) do
		if not (obj:is(Rectangle) or obj:is(Cuboid)) then
			goto continue
		end

		local oLeft, oRight
		if obj:is(Rectangle) then
			oLeft = obj:getPointX(obj:getPointIndex('left'))
			oRight = obj:getPointX(obj:getPointIndex('right'))
		else
			oLeft = obj.position.x
			oRight = obj.position.x + obj.lenX
		end

		local oTop = obj.position.y
		local oBottom = obj.position.y + obj.lenY

		if bottom > oTop and top < oBottom then
			-- check how far between x and the line
			for key2, xValue in pairs({oLeft, oRight}) do

				local disX = math.abs(centerX - xValue)
				local signX = Base.sign(centerX - xValue)
				local disMin = math.abs(self:getVectorX() / 2)

				-- stuck
				if disMin - disX > 1 then
					self.stuck = true
					self.spdY = 0
					self.spdX = 0

					-- push
				elseif math.abs(disX * signX + self.spdX * dt) < disMin then
					self.position.x = xValue + disMin * signX - self:getVectorX() / 2
					self.spdX = 0
					break
				end
			end
		end
		-- y
		if right > oLeft and left < oRight then
			-- check how far between y and the line
			for key2, yValue in pairs({oTop, oBottom}) do

				local disY = math.abs(centerY - yValue)
				local signY = Base.sign(centerY - yValue)
				local disMin = self.lenY / 2

				-- stuck
				if disMin - disY > 1 then
					self.stuck = true
					self.spdY = 0
					self.spdX = 0

					-- push
				elseif math.abs(disY * signY + self.spdY * dt) < disMin then
					self.position.y = yValue + disMin * signY - disMin
					self.spdY = 0
					break
				end
			end
		end
		::continue::
	end
end

---@param obj Shape
---@return boolean
function Player:isCollisionInXY(obj)

	local flag = false

	if not (obj:is(Rectangle) or obj:is(Cuboid)) then
		return flag
	end

	local left 	 = self:getPointX(self:getPointIndex('left'))
	local right  = self:getPointX(self:getPointIndex('right'))
	local top 	 = self.position.y
	local bottom = self.position.y + self.lenY

	local oLeft, oRight
	if obj:is(Rectangle) then
		oLeft = obj:getPointX(obj:getPointIndex('left'))
		oRight = obj:getPointX(obj:getPointIndex('right'))
	else
		oLeft = obj.position.x
		oRight = obj.position.x + obj.lenX
	end

	local oTop = obj.position.y
	local oBottom = obj.position.y + obj.lenY

	if left <= oRight and right >= oLeft and
	   top <= oBottom and bottom >= oTop then
		flag = true
	end

	return flag
end


---@param obj Shape
---@param mode number
---@return boolean
function Player:isTouch(obj, mode)
	local flag = false

	if mode == 0 then
		if self:isCollisionInXY(obj) then
			flag = true
		end
	elseif mode == 1 then
		for i = 1, #self.points do
			if self:isPointOnGroundWithShapeList(i, {obj}) then
				flag = true
				break
			end
		end
	end

	return flag
end


local function swapPoints(self)
	self.position.x = self:getPointX(2)
	self.position.z = self:getPointZ(2)
	self.radian = self.radian - math.pi
end

---@param dt  number
function Player:collisionXZ(dt)

	-- both not on ground
	if not (self:isPointOnGround(1) or self:isPointOnGround(2)) then
		-- garvity
		self.position.z = self.position.z + Base.garvity * dt
	else
		-- make sure point1 is the main point

		-- both side on ground
		if self:isPointOnGround(1) and self:isPointOnGround(2) then

			if (Base.isDown(Base.keys.left) and self.position.x ~= self:getPointX(self:getPointIndex('left')))
			or (Base.isDown(Base.keys.right) and self.position.x ~= self:getPointX(self:getPointIndex('right'))) then
				swapPoints(self)
			end
		-- one side on ground
		else
			if not self:isPointOnGround(1) then
				swapPoints(self)
			end

			-- garvity
			if not ( Base.isDown(Base.keys.left) or Base.isDown(Base.keys.right) ) then
				local spdG

				if self:getPointIndex('left') == 1 then
					spdG = Base.player.spdXZ
				else
					spdG = -Base.player.spdXZ
				end

				-- fix shaking when radian = pi/2 or -3/2*pi (point down)
				local positiveRadian = self.radian
				if positiveRadian < 0 then
					positiveRadian = positiveRadian + math.pi * 2
				end

				if positiveRadian ~= math.pi/2 then

					local addRadtian = spdG * dt
					local absRadtianBetween = math.abs(math.pi/2 - positiveRadian)

					if absRadtianBetween < math.abs(spdG * dt) then
						addRadtian = absRadtianBetween * Base.sign(spdG)
					end

					self.radian = self.radian + addRadtian
				end
			end
		end
		-- control radian
		self:moveXZ(dt)

		-- limit radian
		if self.radian <= -math.pi * 2 then
			self.radian = self.radian + math.pi * 2
		elseif self.radian >= math.pi * 2 then
			self.radian = self.radian - math.pi * 2
		end
	end
end


return Player