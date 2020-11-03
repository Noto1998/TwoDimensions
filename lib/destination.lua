Destination = Cuboid:extend()

function Destination:new(x, y, z)
    local len = base.lenDestination
    local cFill = base.cDestination
    local cLine = base.cWhite
    local cMesh = {0, 0, 0, 0}
    Destination.super.new(self, x, y, z, len, len, len, cFill, cLine, cMesh)
end