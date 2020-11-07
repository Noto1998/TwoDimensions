Destination = Cuboid:extend()

function Destination:new(x, y, z)
    local len = Base.lenDestination
    local cFill = Base.color.endCube
    local cLine = Base.color.white
    local cMesh = {0, 0, 0, 0}
    Destination.super.new(self, x, y, z, len, len, len, cFill, cLine, cMesh)
end