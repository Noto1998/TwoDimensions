local Laser = Shape:extend()

local radius = 10
local len = math.sqrt(Base.gui.height ^ 2 + Base.gui.width ^ 2) + 1
local timeMax = 2-- second
local warningTime = 0.3
local player
local ballList

local function initDrawPosition(self)
    self.drawX1 = self.position.x + self.scaleX * len
    self.drawZ2 = self.position.z + self.scaleZ * len
    self.drawX2 = self.drawX1 + self.scaleX * len
    self.drawZ2 = self.drawZ2 + self.scaleZ * len
end

local function initBallList(shapeList)
    if ballList ~= nil then
        return
    end

    ballList = {}
    for key, shape in pairs(shapeList) do
        if shape:is(Ball) then
            table.insert(ballList, shape)
        end
    end
end

local function initPlayer(shapeList)

    if player ~= nil then
        return
    end

    for key, shape in pairs(shapeList) do
        if shape:is(Player) then
            player = shape
        end
    end
end

function Laser:new(position, scaleX, scaleY, scaleZ, colorFill, colorLine, colorMesh)
    Laser.super.new(self, position, colorFill, colorLine, colorMesh)

    -- scale
    self.scaleX = scaleX
    self.scaleY = scaleY
    self.scaleZ = scaleZ

    self.timer = 0
    self.len = len
    self.isTurnOn = false

    initDrawPosition(self)

    ballList = nil
    player = nil
end


function Laser:update(dt, mode, shapeList)
    initBallList(shapeList)
    initPlayer(shapeList)

    -- update isTurnOn
    if mode == 0 or mode == 1 then
        self.timer = self.timer + dt

        if self.timer > timeMax then
            self.timer = 0
            self.isTurnOn = not self.isTurnOn

            -- play sfx
            if self.isTurnOn then
                love.audio.play(SFX_SHOOT)
            end
        end
    end

    -- reset
    initDrawPosition(self)

    -- block
    self:block(ballList)

    -- reflex
    if mode == 1 then
        self:reflex(player)
    end
end


function Laser:draw(mode)
    local x = self.position.x
    local y = self.position.y * (1 - mode) + self.position.z * mode
    local lenX = self.scaleX * self.len
    local lenY = (self.scaleY * (1 - mode) + self.scaleZ * mode) * self.len

    -- draw self
    love.graphics.setColor(self.colorFill)
    love.graphics.circle('fill', x, y, radius * 2)
    love.graphics.setColor(self.colorLine)
    love.graphics.circle('line', x, y, radius)
    love.graphics.circle('line', x, y, radius * 2)

    -- draw shoot line

    if not self.isTurnOn then
        -- warning
        if self.timer > timeMax - warningTime then
            love.graphics.setColor(Base.color.loaser.warning)
            love.graphics.line(x, y, x + lenX, y + lenY)
        end
    else
        -- shooting
        local color = {}
        Base.mixColor(color, Base.color.loaser.safe, Base.color.loaser.danger, mode)

        love.graphics.setColor(color)
        if mode == 1 then
            love.graphics.line(x, y, self.drawX1, self.drawZ2)
            love.graphics.line(self.drawX1, self.drawZ2, self.drawX2, self.drawZ2)
        else
            -- todo: work wrong! fix!
            love.graphics.line(x, y, x + lenX, y + lenY)
        end
    end
end

-- todo: why ?
function Laser:hitRect(x1, y1, x2, y2, selfY, selfScaleY)
    local flag

    selfY = Base.ternary(selfY ~= nil, selfY, self.position.y)
    selfScaleY = Base.ternary(selfScaleY ~= nil, selfScaleY, self.scaleY)

    -- x
    local xLeft = self.position.x
    local xRight = self.position.x + self.scaleX * self.len
    if xLeft > xRight then
        xLeft, xRight = xRight, xLeft
    end
    -- y
    local yTop = selfY
    local yBottom = selfY + selfScaleY * self.len
    if yTop > yBottom then
        yTop, yBottom = yBottom, yTop
    end

    -- check rect
    if x2 > xLeft and x1 < xRight and
       y2 > yTop  and y1 < yBottom then

        if self.scaleX == 0 and selfScaleY == 0 then
            -- point, do nothing
        elseif self.scaleX == 0 or selfScaleY == 0 then
            -- vertical or horizontal
            flag = true
        else
            -- fix
            if y1 < yTop + 1 then
                y1 = yTop + 1
            end
            if y2 > yBottom - 1 then
                y2 = yBottom - 1
            end

            local xyTable = {
                {x1, y1},
                {x2, y1},
                {x2, y2},
                {x1, y2},
            }
            local sign = nil
            local radianReal = math.atan2(selfScaleY, self.scaleX)

            for i = 1, 4 do
                local vX = xyTable[i][1]
                local vY = xyTable[i][2]
                -- laser to 4 point
                local lenX = vX - self.position.x
                local lenY = vY - selfY
                local radian = math.atan2(lenY, lenX)
                local pSign = Base.sign(radianReal - radian)

                if sign == nil then
                    sign = pSign
                else
                    -- check radian(show point in which side)
                    if sign ~= pSign then
                        flag = true
                        break
                    end
                end
            end
        end
    end

    return flag
end


function Laser:hit(obj)
    local flag = false

    -- x
    local xLeft = self.position.x
    local xRight = self.position.x + self.scaleX * self.len
    if xLeft > xRight then
        xLeft, xRight = xRight, xLeft
    end

    -- y
    local yTop = self.position.y
    local yBottom = self.position.y + self.scaleY * self.len
    if yTop > yBottom then
        yTop, yBottom = yBottom, yTop
    end

    if obj:is(Rect) then
        local x1 = obj:getPointX(obj:getPointIndex('left'))
        local x2 = obj:getPointX(obj:getPointIndex('right'))
        local y1 = obj.position.y
        local y2 = obj.position.y + obj.lenY

        flag = self:hitRect(x1, y1, x2, y2)

    elseif obj:is(Ball) then
        -- check rect
        if obj.position.x + obj.radius > xLeft and
           obj.position.x - obj.radius < xRight and
           obj.position.y + obj.radius > yTop and
           obj.position.y - obj.radius < yBottom then

            if self.scaleX == 0 and self.scaleY == 0 then
                -- point, do nothing
            elseif self.scaleX == 0 or self.scaleY == 0 then
                -- vertical or horizontal
                flag = true
            else
                -- both ~= 0

                local radianReal = math.atan2(self.scaleY, self.scaleX)
                -- laser to ball
                local lenX = obj.position.x - self.position.x
                local lenY = obj.position.y - self.position.y
                local dirBall = math.atan2(lenY, lenX)
                -- min
                local c = math.sqrt(lenX ^ 2 + lenY ^ 2)
                local sin = obj.radius / c
                local dirMin = math.asin(sin)
                --
                if math.abs(dirBall - radianReal) < dirMin then
                    flag = true
                end
            end
        end
    end

    return flag
end


function Laser:hitPlayer(player, mode)
    return mode == 0 and self.isTurnOn and self:hit(player)
    -- body
end


-- todo: dont work! need fix!
function Laser:hitDraw2(obj)
    local flag = false

    local x1 = obj.position.x
    local z1 = obj.position.z
    local x2 = obj.position.x + obj.lenX
    local z2 = obj.position.z + obj.lenZ

    -- x
    local xLeft = self.drawX1
    local xRight = self.drawX2
    if xLeft > xRight then
        xLeft, xRight = xRight, xLeft
    end

    -- z
    local zTop = self.drawZ2
    local zBottom = self.drawZ2
    if zTop > zBottom then
        zTop, zBottom = zBottom, zTop
    end

    -- check rect
    if x2 > xLeft and x1 < xRight and
       z2 > zTop and z1 < zBottom then

        if xLeft == xRight and zBottom == zTop then
            -- point, do nothing
        elseif xLeft == xRight or zBottom == zTop then
            -- vertical or horizontal
            flag = true
        else
            -- fix
            if z1 < zTop + 1 then
                z1 = zTop + 1
            end
            if z2 > zBottom - 1 then
                z2 = zBottom - 1
            end

            local xyTable = {
                {x1, z1},
                {x2, z1},
                {x2, z2},
                {x1, z2},
            }
            local sign = nil
            local radianReal = math.atan2(self.drawZ2 - self.drawZ2, self.drawX2 - self.drawX1)

            for i = 1, 4 do
                local vX = xyTable[i][1]
                local vY = xyTable[i][2]
                -- laser to 4 point
                local lenX = vX - self.drawX1
                local lenY = vY - self.drawZ2
                local radian = math.atan2(lenY, lenX)
                local pSign = Base.sign(radianReal-radian)

                if sign == nil then
                    sign = pSign
                else
                    -- check radian(show point in which side)
                    if sign ~= pSign then
                        flag = true
                        break
                    end
                end
            end
        end
    end

    return flag
end


function Laser:block(ballList)
    local lenMin = len

    for key, ball in pairs(ballList) do

        if self:hit(ball) then
            local lenX = math.abs(self.position.x - ball.position.x)
            local lenY = math.abs(self.position.y - ball.position.y)
            local c = math.sqrt(lenX ^ 2 + lenY ^ 2)
            local c2 = math.sqrt(self.scaleX ^ 2 + self.scaleY ^ 2)
            local _len = c / c2

            -- record min len
            if _len < lenMin then
                lenMin = _len
            end
        end
    end

    self.len = lenMin
end


function Laser:reflex(obj)
    if not self.isTurnOn then
        return
    end

    local x1 = obj:getPointX(obj:getPointIndex('left'))
    local x2 = obj:getPointX(obj:getPointIndex('right'))
    local z1 = obj:getPointZ(1)-- why?
    local z2 = obj:getPointZ(2)
    if z1 > z2 then
        z1, z2 = z2, z1
    end

    -- check rect
    if not self:hitRect(x1, z1, x2, z2, self.position.z, self.scaleZ) then
        return
    end

    local function setDir(self)

        local oDir = math.atan2(self.drawZ2 - obj:getPointZ(obj:getPointIndex('left')), self.drawX1 - obj:getPointX(obj:getPointIndex('left')))
        local dir1 = math.atan2(-self.scaleZ, -self.scaleX)
        local dir2 = dir1 - oDir
        local radian = oDir - math.pi-dir2

        self.drawX2 = self.drawX1 + Base.getVector(radian, len).x
        self.drawZ2 = self.drawZ2 + Base.getVector(radian, len).y
    end

    local absX = math.abs(obj:getVectorX())
    local absZ = math.abs(obj:getVectorZ())
    local checkTime = Base.ternary(absX > absZ, absX, absZ)
    local partX = obj:getPointX(1) + obj:getVectorX() / checkTime
    local partZ = obj:getPointZ(1) + obj:getVectorZ() / checkTime

    for i = 1, checkTime do
        local oX = partX * i
        local oZ = partZ * i

        if self.scaleX == 0 and self.scaleZ == 0 then
            -- nothing
        elseif self.scaleX == 0 then

            if math.abs(oX - self.position.x) < 1 then
                self.drawX1 = oX
                self.drawZ2 = oZ

                setDir(self)
                break
            end
        elseif self.scaleZ == 0 then
            if math.abs(oZ - self.position.z) < 1 then
                self.drawX1 = oX
                self.drawZ2 = oZ

                setDir(self)
                break
            end
        else
            local d1 = self.scaleZ / self.scaleX
            local d2 = (oZ - self.position.z) / (oX - self.position.x)
            if math.abs(d2 - d1) < 0.05 then-- todo: why ?
                self.drawX1 = oX
                self.drawZ2 = oZ

                setDir(self)
                break
            end
        end
    end
end


return Laser