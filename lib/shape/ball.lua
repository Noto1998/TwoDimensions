local Ball = Shape:extend()

local SPD = 35
local SLOW_SPD = 10
local rects

local function initRects(shapeList)
    if rects ~= nil then
        return
    end

    rects = {}
    for key, obj in pairs(shapeList) do
        if obj:is(Rect) and not obj:is(Player) then
            table.insert(rects, obj)
        end
    end
end

local function isOnGround(self, shapeList)

    local flag = false
    local x = self.position.x
    local z = self.position.z + self.radius

    for key, obj in ipairs(shapeList) do
        -- Cuboid or Rect
        if obj:is(Cuboid) or obj:is(Rect) then
            flag = obj:isCollisionPointInXZ(x, z)

            if flag then
                break
            end
        end
    end

    return flag
end


function Ball:new(position, radius, colorFill, colorLine, colorMesh)
    Ball.super.new(self, position, colorFill, colorLine, colorMesh)

    self.radius = radius
    self.isOnGround = false
    self.spdX = 0
    self.spdZ = 0
end


function Ball:update(dt, mode, shapeList)

    -- init rects
    initRects(shapeList)

    if mode ~= 1 then
        return
    end

    --[[
    -- isOnGround
    self.isOnGround = isOnGround(self, shapeList)
    -- gravity
    self.spdZ = Base.ternary(self.isOnGround, 0, Base.garvity)

    -- roll
    -- todo: why limit spdX ?
    if self.spdX ~= 0 then

        if math.abs(self.spdX) > SLOW_SPD then
            self.spdX = self.spdX - Base.sign(self.spdX) * SLOW_SPD
        else
            self.spdX = 0
        end
    end

    for key, obj in pairs(rects) do
        local x = self.position.x
        local z = self.position.z + self.radius + self.spdZ * dt
        if obj:isCollisionPointInXZ(x, z) then
        --if self:isCollisionRectInXZ(obj) then
            if obj.radian < -math.pi / 2 then
                self.spdX = SPD
            elseif obj.radian > -math.pi / 2 then
                self.spdX = -SPD
            end

            self.spdZ = math.abs(obj:getVectorZ()) * SPD / math.abs(obj:getVectorX())

            break
        end
    end

    -- update position
    self.position.x = self.position.x + self.spdX * dt
    self.position.z = self.position.z + self.spdZ * dt

    ]]
end


function Ball:draw(mode)

    local y = self.position.y + (-self.position.y + self.position.z) * mode
    -- color fade in/out
    local color = {}
    Base.mixColor(color, Base.color.loaser.danger, Base.color.loaser.safe, 1 - mode)

    -- fill
    love.graphics.setColor(self.colorFill)
    love.graphics.circle('fill', self.position.x, y, self.radius)
    -- line
    love.graphics.setColor(color)
    love.graphics.circle('line', self.position.x, y, self.radius)
end


function Ball:isCollisionPointInXZ(pointX, pointZ)
    local flag = Base.isCircleWithPoint(self.position.x, self.position.z, self.radius, pointX, pointZ)
    return flag
end


---@param rect Rect
function Ball:isCollisionRectInXZ(rect)
    local ballX = self.position.x
    local ballZ = self.position.z
    local ballRadius = self.radius
    local lineX = rect.getPointX(1)
    local lineZ = rect.getPointZ(1)
    local radian = rect.radian
    local len = rect:getDistance()
    local flag = Base.isCircleWithLine(ballX, ballZ, ballRadius, lineX, lineZ, radian, len)

    return flag
end


function Ball:hitPlayer(player, shiftMode)
    local flag = false

    if shiftMode ~= 1 then
        return flag
    end

    for i = 1, 2 do
        local x = player:getPointX(i)
        local z = player:getPointZ(i)

        if self:isCollisionPointInXZ(x, z) then
            flag = true
            break
        end
    end

    return flag
end


return Ball