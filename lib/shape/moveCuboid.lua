local MoveCuboid = Cuboid:extend()

local SPD = 20


function MoveCuboid:new(position, lenX, lenY, lenZ, movePosition)
    MoveCuboid.super.new(self, position, lenX, lenY, lenZ, nil, Base.color.loaser.danger, nil)

    self.movePosition = Base.ternary(movePosition ~= nil, Base.cloneTable(movePosition), Base.cloneTable(self.position))
    self.oPosition = Base.cloneTable(self.position)    -- record position
    self.position = Base.cloneTable(self.movePosition) -- init
end


function MoveCuboid:update(dt, shiftMode, shapeList)

    -- update position
    if shiftMode == 0 or shiftMode == 1 then

        -- position += dis means position = oPosition
        if self.position.x ~= self.oPosition.x then
            local disX = self.oPosition.x - self.position.x
            local spdX = Base.ternary(math.abs(disX) > SPD * dt, Base.sign(disX) * SPD * dt, disX)

            self.position.x = self.position.x + spdX
        end

        if self.position.y ~= self.oPosition.y then
            local disY = self.oPosition.y - self.position.y
            local spdY = Base.ternary(math.abs(disY) > SPD * dt, Base.sign(disY) * SPD * dt, disY)

            self.position.y = self.position.x + spdY
        end

        if self.position.z ~= self.oPosition.z then
            local disZ = self.oPosition.z - self.position.z
            local spdZ = Base.ternary(math.abs(disZ) > SPD * dt, Base.sign(disZ) * SPD * dt, disZ)

            self.position.z = self.position.z + spdZ
        end
    end

    -- reset
    if shiftMode == 1 then
        for key, shape in pairs(shapeList) do
            if shape:is(Laser) and shape:hitDraw2(self) then
                self.position.x = self.movePosition.x
                self.position.y = self.movePosition.y
                self.position.z = self.movePosition.z
                break
            end
        end
    end

    -- update draw position
    self:updateRectanglesPosition()
    -- update mesh vertices
    for key, rectangle in pairs(self.rectangles) do
        rectangle:updateVertices()
    end
end


function MoveCuboid:hitPlayer(player, mode)
    return player:isTouch(self, mode)
end


function MoveCuboid:updateRectanglesPosition()
    local x = self.position.x

    local y1 = self.position.y
    local z1 = self.position.z

    self.rectangles[1].position.x = x
    self.rectangles[1].position.y = y1
    self.rectangles[1].position.z = z1

    local y2 = self.position.z
    local z2 = self.position.y + self.lenY

    self.rectangles[2].position.x = x
    self.rectangles[2].position.y = y2
    self.rectangles[2].position.z = z2
end


return MoveCuboid