local EndCube = Cuboid:extend()

function EndCube:new(x, y, z)
    local len = Base.lenEndCube
    local cFill = Base.color.endCube
    local cLine = Base.color.white
    local cMesh = {0, 0, 0, 0}
    EndCube.super.new(self, x, y, z, len, len, len, cFill, cLine, cMesh)
end

return EndCube