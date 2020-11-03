Laser = Shape:extend()

local radius = 10
local len = math.sqrt(base.guiHeight^2 + base.guiWidth^2) + 1
local timeMax = 2-- second

function Laser:new(x, y, z, sx, sy, sz, cFill, cLine, cMesh)
    Laser.super.new(self, x, y, z, cFill, cLine, cMesh)
    -- 0~1
    self.sx = sx
    self.sy = sy
    self.sz = sz
    -- turn on/off
    self.timer = 0
    self.turnOn = false
    -- len
    self.len = len
    --
    self.drawX = self.x + self.sx*len
    self.drawZ = self.z + self.sz*len
    self.drawX2 = self.drawX + self.sx*len
    self.drawZ2 = self.drawZ + self.sz*len
end


function Laser:update(dt, mode, shapeList, player)
    -- update TrunOn/Off
    if mode == 0 or mode == 1 then
        self.timer = self.timer + dt
        if self.timer > timeMax then
            self.timer = 0
            self.turnOn = not self.turnOn
            --sfx
            if self.turnOn then
                love.audio.play(sfx_shoot)
            end
        end
    end
    --reset
    self.drawX = self.x + self.sx*len
    self.drawZ = self.z + self.sz*len
    self.drawX2 = self.drawX + self.sx*len
    self.drawZ2 = self.drawZ + self.sz*len
    -- ball block laser
    local ballList = {}
    for i = 1, #shapeList do
        if shapeList[i]:is(Ball) then
            table.insert(ballList, shapeList[i])
        end
    end
    self:block(ballList)

    -- reflex
    if mode == 1 then
        self:reflex(player)
    end
end


function Laser:draw(mode)
    local _x = self.x
    local _y = self.y*(1-mode) + self.z*mode
    local _lenX = self.sx*self.len
    local _lenY = (self.sy*(1-mode)+self.sz*mode)*self.len
    
    -- draw self
    love.graphics.setColor(self.cFill)
    love.graphics.circle("fill", self.x, _y, radius*2)
    love.graphics.setColor(self.cLine)
    love.graphics.circle("line", self.x, _y, radius)
    love.graphics.circle("line", self.x, _y, radius*2)
    
    -- draw shoot line
    if self.turnOn then
        local cTable1 = base.cloneTable(base.cSafe)
        local cTable2 = base.cloneTable(base.cDanger)

        for i = 1, #cTable1 do
            cTable1[i] = cTable1[i]*mode + cTable2[i]*(1-mode)
        end

        --
        love.graphics.setColor(cTable1)
        if mode == 1 then
            love.graphics.line(_x, _y, self.drawX, self.drawZ)
            love.graphics.line(self.drawX, self.drawZ, self.drawX2, self.drawZ2)
        else
            love.graphics.line(_x, _y, _x + _lenX, _y + _lenY)
        end
    -- warning
    else
        if self.timer > timeMax * (1-0.3) then
            love.graphics.setColor(base.cWarning)
            love.graphics.line(_x, _y, _x + _lenX, _y + _lenY)
        end
    end
end


function Laser:hitRectangle(x1, y1, x2, y2, selfY, selfSY)
    local flag

    if selfY == nil then
        selfY = self.y
    end
    if selfSY == nil then
        selfSY = self.sy
    end

    -- x
    local xLeft = self.x
    local xRight = self.x + self.sx * self.len
    if xLeft > xRight then
        xLeft, xRight = xRight, xLeft
    end
    -- y
    local yTop = selfY
    local yBottom = selfY + selfSY * self.len
    if yTop > yBottom then
        yTop, yBottom = yBottom, yTop
    end

    -- check rectangle
    if  x2 > xLeft
    and x1 < xRight
    and y2 > yTop
    and y1 < yBottom then
        if self.sx == 0 and selfSY == 0 then
            -- point, do nothing
        elseif self.sx == 0 or selfSY == 0 then
            -- vertical or horizontal
            flag = true
        else
            -- fix
            if y1 < yTop+1 then
                y1 = yTop+1
            end
            if y2 > yBottom-1 then
                y2 = yBottom-1
            end
            --
            local pTable = {
                {x1, y1},
                {x2, y1},
                {x2, y2},
                {x1, y2},
            }
            local sign = nil
            -- real
            local dirReal = math.atan2(selfSY, self.sx)
            --
            for i = 1, 4 do
                local vX = pTable[i][1]
                local vY = pTable[i][2]
                -- laser to 4 point
                local lenX = vX-self.x
                local lenY = vY-selfY
                local dir = math.atan2(lenY, lenX)
                local pSign = base.sign(dirReal-dir)
                --
                if sign == nil then
                    sign = pSign
                else
                    -- check dir(show point in which side)
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
    local xLeft = self.x
    local xRight = self.x + self.sx * self.len
    if xLeft > xRight then
        xLeft, xRight = xRight, xLeft
    end
    -- y
    local yTop = self.y
    local yBottom = self.y + self.sy * self.len
    if yTop > yBottom then
        yTop, yBottom = yBottom, yTop
    end
    --
    if obj:is(Rectangle) then
        local x1 = obj:getX(obj:getLeftX())
        local x2 = obj:getX(obj:getRightX())
        local y1 = obj.y
        local y2 = obj.y+obj.lenY
        flag = self:hitRectangle(x1, y1, x2, y2)
    elseif obj:is(Ball) then
        -- check rectangle
        if  obj.x + obj.radius > xLeft
        and obj.x - obj.radius < xRight
        and obj.y + obj.radius > yTop
        and obj.y - obj.radius < yBottom then
            if self.sx == 0 and self.sy == 0 then
                -- point, do nothing
            elseif self.sx == 0 or self.sy == 0 then
                -- vertical or horizontal
                flag = true
            else
                -- both ~= 0
                -- real
                local dirReal = math.atan2(self.sy, self.sx)
                -- laser to ball
                local lenX = obj.x - self.x
                local lenY = obj.y - self.y
                local dirBall = math.atan2(lenY, lenX)
                -- min
                local c = math.sqrt(lenX^2 + lenY^2)
                local sin = obj.radius/c
                local dirMin = math.asin(sin)
                --
                if math.abs(dirBall - dirReal) < dirMin then
                    flag = true
                end
            end
        end
    end

    return flag
end
function Laser:hitPlayer(player)
    return self.turnOn and self:hit(player)
    -- body
end
function Laser:hitDraw2(obj)
    local flag = false

    local x1 = obj.x
    local z1 = obj.z
    local x2 = obj.x + obj.lenX
    local z2 = obj.z + obj.lenZ

    -- x
    local xLeft = self.drawX
    local xRight = self.drawX2
    if xLeft > xRight then
        xLeft, xRight = xRight, xLeft
    end
    -- z
    local zTop = self.drawZ
    local zBottom = self.drawZ2
    if zTop > zBottom then
        zTop, zBottom = zBottom, zTop
    end
    -- check rectangle
    if  x2 > xLeft
    and x1 < xRight
    and z2 > zTop
    and z1 < zBottom then
        if xLeft == xRight and zBottom == zTop then
            -- point, do nothing
        elseif xLeft == xRight or zBottom == zTop then
            -- vertical or horizontal
            flag = true
        else
            -- fix
            if z1 < zTop+1 then
                z1 = zTop+1
            end
            if z2 > zBottom-1 then
                z2 = zBottom-1
            end
            --
            local pTable = {
                {x1, z1},
                {x2, z1},
                {x2, z2},
                {x1, z2},
            }
            local sign = nil
            -- real
            local dirReal = math.atan2(self.drawZ2-self.drawZ, self.drawX2-self.drawX)
            --
            for i = 1, 4 do
                local vX = pTable[i][1]
                local vY = pTable[i][2]
                -- laser to 4 point
                local lenX = vX-self.drawX
                local lenY = vY-self.drawZ
                local dir = math.atan2(lenY, lenX)
                local pSign = base.sign(dirReal-dir)
                --
                if sign == nil then
                    sign = pSign
                else
                    -- check dir(show point in which side)
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


-- block
function Laser:block(ballList)
    local lenMin = len

    for key, obj in pairs(ballList) do
        if self:hit(obj) then
            local lenX = math.abs(self.x - obj.x)
            local lenY = math.abs(self.y - obj.y)
            local c = math.sqrt(lenX^ 2 + lenY^2)
            local c2 = math.sqrt(self.sx^2 + self.sy^2)
            local _len = c/c2

            -- record min len
            if _len < lenMin then
                lenMin = _len
            end

        end
    end

    self.len = lenMin
end


function Laser:reflex(obj)
    if self.turnOn then
        local x1 = obj:getX(obj:getLeftX())
        local x2 = obj:getX(obj:getRightX())
        local z1 = obj:getZ(1)
        local z2 = obj:getZ(2)
        if z1 > z2 then
            z1, z2 = z2, z1
        end

        local function setDir(self)
            local centerX = (x1+x2)/2
            local centerZ = (z1+z2)/2

            local oDir = math.atan2(self.drawZ-obj:getZ(obj:getLeftX()), self.drawX-obj:getX(obj:getLeftX()))

            local dir1 = math.atan2(-self.sz, -self.sx)

            local dir2 = dir1-oDir

            local dir = oDir-math.pi-dir2
            
            self.drawX2 = self.drawX+base.dirGetXY(dir, len, 0)
            self.drawZ2 = self.drawZ+base.dirGetXY(dir, len, 1)
        end
        -- check rectangle
        if self:hitRectangle(x1, z1, x2, z2, self.z, self.sz) then
            local absX = math.abs(obj:getLenDX())
            local absZ = math.abs(obj:getLenDZ())
            local absMax = absX
            if absZ > absMax then
                absMax = absZ
            end
            for i = 1, absMax do
                local oX = obj:getX(1) + obj:getLenDX()/absMax*i
                local oZ = obj:getZ(1) + obj:getLenDZ()/absMax*i

                if self.sx == 0 and self.sz == 0 then
                    -- nothing
                elseif self.sx == 0 then
                    if math.abs(oX-self.x)<1 then
                        self.drawX = oX
                        self.drawZ = oZ

                        setDir(self)
                        break
                    end
                elseif self.sz == 0 then
                    if math.abs(oZ-self.z)<1 then
                        self.drawX = oX
                        self.drawZ = oZ

                        setDir(self)
                        break
                    end
                else
                    local d1 = self.sz/self.sx
                    local d2 = (oZ-self.z)/(oX-self.x)
                    if math.abs(d2-d1)<0.05 then
                        self.drawX = oX
                        self.drawZ = oZ

                        setDir(self)
                        break
                    end 
                end
            end
        end
    end
end