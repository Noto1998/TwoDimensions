local Cuboid = Shape:extend()

local function initRectangles(self)

    local rectangles = {}
    local radian = 0
    local x = self.position.x

    local y1 = self.position.y
    local z1 = self.position.z
    local lenY1 = self.lenY
    local position1 = Base.createPosition(x, y1, z1)
    table.insert(
        rectangles,
        Rectangle(position1, self.lenX, lenY1, radian, self.colorFill, self.colorLine, self.colorMesh)
    )

    local y2 = self.position.z
    local z2 = self.position.y + self.lenY
    local lenY2 = self.lenZ
    local position2 = Base.createPosition(x, y2, z2)
    table.insert(
        rectangles,
        Rectangle(position2, self.lenX, lenY2, radian, self.colorFill, self.colorLine, self.colorMesh)
    )

    return rectangles
end

function Cuboid:new(position, lenX, lenY, lenZ, colorFill, colorLine, colorMesh)
    Cuboid.super.new(self, position, colorFill, colorLine, colorMesh)

    self.lenX = lenX
    self.lenY = lenY
    self.lenZ = lenZ

    self.rectangles = initRectangles(self)
end

function Cuboid:draw(mode)

    if mode ~= 1 then
        self.rectangles[1]:draw(mode)
    end

    if mode ~= 0 then
        self.rectangles[2]:draw(1 - mode)
    end
end

function Cuboid:isCollisionInXZ(x, z)

    local flag = false
    local checkBorder = 2

    local left   = self.position.x - checkBorder
    local right  = self.position.x + self.lenX + checkBorder
    local top    = self.position.z - checkBorder
    local bottom = self.position.z + self.lenZ + checkBorder

    if x >= left and x <= right and z >= top and z <= bottom then
        flag = true
    end

    return flag
end

return Cuboid