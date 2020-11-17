local Cuboid = Shape:extend()

local function initRects(self)

    local rects = {}
    local radian = 0
    local x = self.position.x

    local y1 = self.position.y
    local z1 = self.position.z
    local lenY1 = self.lenY
    local position1 = Base.createPosition(x, y1, z1)
    table.insert(
        rects,
        Rect(position1, self.lenX, lenY1, radian, self.colorFill, self.colorLine, self.colorMesh)
    )

    local y2 = self.position.z
    local z2 = self.position.y + self.lenY
    local lenY2 = self.lenZ
    local position2 = Base.createPosition(x, y2, z2)
    table.insert(
        rects,
        Rect(position2, self.lenX, lenY2, radian, self.colorFill, self.colorLine, self.colorMesh)
    )

    return rects
end

function Cuboid:new(position, lenX, lenY, lenZ, colorFill, colorLine, colorMesh)
    Cuboid.super.new(self, position, colorFill, colorLine, colorMesh)

    self.lenX = lenX
    self.lenY = lenY
    self.lenZ = lenZ

    self.rects = initRects(self)
end

function Cuboid:draw(mode)

    if mode ~= 1 then
        self.rects[1]:draw(mode)
    end

    if mode ~= 0 then
        self.rects[2]:draw(1 - mode)
    end
end

function Cuboid:isCollisionPointInXZ(pointX, pointZ)

    local checkBorder = 2
    local x = self.position.x - checkBorder
    local z = self.position.z - checkBorder
    local lenX = self.lenX + checkBorder
    local lenZ = self.lenZ + checkBorder

    local flag = Base.isRectWithPoint(x, z, lenX, lenZ, pointX, pointZ)

    return flag
end

return Cuboid