MoveCuboid = Cuboid:extend()

local spd = 30

function MoveCuboid:new(position, lenX, lenY, lenZ, moveX, moveY, moveZ)
    MoveCuboid.super.new(self, position, lenX, lenY, lenZ, nil, Base.color.loaser.danger, nil)
    -- record
    self.oX = self.position.x
    self.oY = self.position.y
    self.oZ = self.position.z

    self.moveX = self.position.x
    self.moveY = self.position.y
    self.moveZ = self.position.z
    if moveX ~= nil then
        self.moveX = moveX
    end
    if moveY ~= nil then
        self.moveY = moveY
    end
    if moveZ ~= nil then
        self.moveZ = moveZ
    end
    --
end

function MoveCuboid:update(dt, shiftMode, shapeList)
    local spdX = 0
    local spdY = 0
    local spdZ = 0

    -- move
    if shiftMode == 0 or shiftMode == 1 then
        if self.position.x ~= self.oX then
            local dx = self.oX-self.position.x
            if math.abs(dx) > spd*dt then
                spdX = spd*Base.sign(dx)
            else
                spdX = dx/dt
            end
        end

        if self.position.y ~= self.oY then
            local dy = self.oY-self.position.y
            if math.abs(dy) > spd*dt then
                spdY = spd*Base.sign(dy)
            else
                spdY = dy/dt
            end
        end

        if self.position.z ~= self.oZ then
            local dz = self.oZ-self.position.z
            if math.abs(dz) > spd*dt then
                spdZ = spd*Base.sign(dz)
            else
                spdZ = dz/dt
            end
        end
    end

    -- reset
    if shiftMode == 1 then
        local flag
        for i = 1, #shapeList do

            -- todo:dont work!!!need fix
            if shapeList[i]:is(Laser) then
                if shapeList[i]:hitDraw2(self) then
                    flag = true
                end
                if flag then
                    self.position.x = self.moveX
                    self.position.y = self.moveY
                    self.position.z = self.moveZ
                    break
                end
            end
        end
    end

    -- update
    self.position.x = self.position.x + spdX*dt
    self.position.y = self.position.y + spdY*dt
    self.position.z = self.position.z + spdZ*dt
end

function MoveCuboid:hitPlayer(player, mode)
    return player:isTouch(self, mode)
end