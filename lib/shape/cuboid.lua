Cuboid = Shape:extend()

function Cuboid:new(x, y, z, lenX, lenY, lenZ, cFill, cLine, cMesh)
    Cuboid.super.new(self, x, y, z, cFill, cLine, cMesh)
    self.lenX = lenX
    self.lenY = lenY
    self.lenZ = lenZ
end

function Cuboid:draw(mode)
    local _dir = 0
    -- 0
    local _y = self.y
    local _lenY = self.lenY
    local _z = self.z
    local re1 = Rectangle(self.x, _y, _z, self.lenX, _lenY, _dir, self.cFill, self.cLine, self.cMesh)
    re1:draw(mode)
    -- 1
    _y = self.z
    _lenY = self.lenZ
    _z = self.y + self.lenY
    re1 = Rectangle(self.x, _y, _z, self.lenX, _lenY, _dir, self.cFill, self.cLine, self.cMesh)
    re1:draw(1 - mode)
    -- release
    re1 = nil
end

function Cuboid:collisionPointXZ(x, z)
    local flag = false
    local checkBorder = 2

    if	x >= self.x - checkBorder
    and z >= self.z - checkBorder
    and x <= self.x + self.lenX + checkBorder
    and z <= self.z + self.lenZ + checkBorder then
        flag = true
    end

    return flag
end