MoveCuboid = Cuboid:extend()

local spd = 30

function MoveCuboid:new(x, y, z, lenX, lenY, lenZ, moveX, moveY, moveZ, moveFlag)
    MoveCuboid.super.new(self, x, y, z, lenX, lenY, lenZ, nil, base.cDanger, nil)
    -- record
    self.oX = self.x
    self.oY = self.y
    self.oZ = self.z
    --
    self.moveX = self.x
    self.moveY = self.y
    self.moveZ = self.z
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
        if self.x ~= self.oX then
            local dx = self.oX-self.x
            if math.abs(dx) > spd*dt then
                spdX = spd*base.sign(dx)
            else
                spdX = dx/dt
            end
        end
        if self.y ~= self.oY then
            local dy = self.oY-self.y
            if math.abs(dy) > spd*dt then
                spdY = spd*base.sign(dy)
            else
                spdY = dy/dt
            end
        end
        if self.z ~= self.oZ then
            local dz = self.oZ-self.z
            if math.abs(dz) > spd*dt then
                spdZ = spd*base.sign(dz)
            else
                spdZ = dz/dt
            end
        end
    end

    -- reset
    if shiftMode == 1 then
        local flag
        for i = 1, #shapeList do
            if shapeList[i]:is(Laser) then
                if shapeList[i]:hitDraw2(self) then
                    flag = true
                end
                if flag then
                    self.x = self.moveX
                    self.y = self.moveY
                    self.z = self.moveZ
                    break
                end
            end
        end
    end

    -- update
    self.x = self.x + spdX*dt
    self.y = self.y + spdY*dt
    self.z = self.z + spdZ*dt
end