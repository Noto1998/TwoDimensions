local Ball = Shape:extend()

local SPD = 35
local slowSpd = 10

local function isOnGround(self, shapeList)

    local flag = false
    local x = self.position.x
    local z = self.position.z + self.radius

    for key, obj in ipairs(shapeList) do
        -- Cuboid or Rectangle
        if obj:is(Cuboid) or obj:is(Rectangle) then
            flag = obj:isCollisionInXZ(x, z)

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

    if mode ~= 1 then
        return
    end

    -- isOnGround
    self.isOnGround = isOnGround(self, shapeList)
    -- gravity
    self.spdZ = Base.ternary(self.isOnGround, 0, Base.garvity)

    -- roll
    -- todo: why limit spdX ?
    if self.spdX ~= 0 then

        if math.abs(self.spdX) > slowSpd then
            self.spdX = self.spdX - Base.sign(self.spdX) * slowSpd
        else
            self.spdX = 0
        end
    end

    for key, obj in pairs(shapeList) do

        if obj:is(Rectangle) then
            if obj:is(Player) then
                goto continue
            end

            if obj:isCollisionInXZ(self.position.x, self.position.z + self.radius + self.spdZ * dt) then

                if obj.radian < -math.pi/2 then
                    self.spdX = SPD
                elseif obj.radian > -math.pi/2 then
                    self.spdX = -SPD
                end

                self.spdZ = math.abs(obj:getVectorZ()) * SPD / math.abs(obj:getVectorX())

                break
            end
        end

        :: continue ::
    end

    -- update position
    self.position.x = self.position.x + self.spdX * dt
    self.position.z = self.position.z + self.spdZ * dt
end


function Ball:draw(mode)

    local y = self.position.y + (-self.position.y + self.position.z) * mode
    local color1 = Base.color.loaser.danger
    local color2 = Base.color.loaser.safe
    local color = {}

    -- color fade in/out
    for i = 1, #color1 do
        color[i] = color1[i] * mode + color2[i] * (1 - mode)
    end

    -- fill
    love.graphics.setColor(self.colorFill)
    love.graphics.circle('fill', self.position.x, y, self.radius)
    -- line
    love.graphics.setColor(color)
    love.graphics.circle('line', self.position.x, y, self.radius)
end


function Ball:isCollisionInXZ(x, z)

    local flag = false
    local lenX = math.abs(x - self.position.x)
    local lenZ = math.abs(z - self.position.z)
    local disbetween = math.sqrt(lenX ^ 2 + lenZ ^ 2)

    if disbetween < self.radius then
        flag = true
    end

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

        if self:isCollisionInXZ(x, z) then
            flag = true
            break
        end
    end

    return flag
end


return Ball