local Cuboid = Shape:extend()

local rectangle1, rectangle2

local function initRectangles(self)
    local radian = 0
    local x = self.position.x

    local y1 = self.position.y
    local z1 = self.position.z
    local lenY1 = self.lenY
    rectangle1 = Rectangle(x, y1, z1, self.lenX, lenY1, radian, self.cFill, self.cLine, self.cMesh)

    local y2 = self.position.z
    local z2 = self.position.y + self.lenY
    local lenY2 = self.lenZ
    rectangle2 = Rectangle(x, y2, z2, self.lenX, lenY2, radian, self.cFill, self.cLine, self.cMesh)
end

function Cuboid:new(x, y, z, lenX, lenY, lenZ, cFill, cLine, cMesh)
    Cuboid.super.new(self, x, y, z, cFill, cLine, cMesh)

    self.lenX = lenX
    self.lenY = lenY
    self.lenZ = lenZ

    initRectangles(self)
end

function Cuboid:draw(mode)

    if mode ~= 1 then
        rectangle1:draw(mode)
    end

    if mode ~= 0 then
        rectangle2:draw(1 - mode)
    end
end

function Cuboid:isCollisionInXZ(x, z)
    local flag = false
    local checkBorder = 2

    if x >= self.position.x - checkBorder and
       z >= self.position.z - checkBorder and
       x <= self.position.x + self.lenX + checkBorder and
       z <= self.position.z + self.lenZ + checkBorder then
        flag = true
    end

    return flag
end

return Cuboid