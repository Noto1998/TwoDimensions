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

    local flag = false
    local lenX = math.abs(pointX - self.position.x)
    local lenZ = math.abs(pointZ - self.position.z)
    local disbetween = math.sqrt(lenX ^ 2 + lenZ ^ 2)

    if disbetween <= self.radius then
        flag = true
    end

    return flag
end


--- new version, but not good enough
---@param rect Rect
function Ball:isCollisionRectInXZ(rect)
    local flag = false

    local leftIndex = rect:getPointIndex('left')
    local rightInedx = rect:getPointIndex('right')
    local x1 = rect:getPointX(leftIndex)
    local x2 = rect:getPointX(rightInedx)

    if self.position.x + self.radius < x1 or self.position.x - self.radius > x2 then
        return flag
    end

    local z1 = rect:getPointZ(leftIndex)
    local startX = self.position.x - self.radius
    if startX < x1 then
        startX = x1
    end
    local disX = startX - x1
    local startZ = z1 + Base.getVectorLenY(rect.radian, disX)
    local checkTime = self.radius * 2
    if startX + checkTime > x2 then
        checkTime = x2 - startX
    end

    for i = 0, checkTime do
        local checkX = startX + i
        local checkZ = startZ + Base.getVectorLenY(rect.radian, i)

        if self:isCollisionPointInXZ(checkX, checkZ) then
            flag = true
            break
        end
    end

    return flag
end


function Ball:isCollisionLineInXZ(lineX, lineZ, lineRadian, lineLen)
    local flag = false

    local x1 = lineX
    local z1 = lineZ
    local vector = Base.getVector(lineRadian, lineLen)
    local x2 = lineX + vector.x
    local z2 = lineZ + vector.y

    -- check points in circle
    if self:isCollisionPointInXZ(x1, z1) or self:isCollisionPointInXZ(x2, z2) then
        flag = true
        return flag
    end

    -- points not in circle, so if isCollision, must be goes through circle


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