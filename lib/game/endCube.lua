local EndCube = Cuboid:extend()

function EndCube:new(x, y, z)
    local len = Base.lenEndCube
    local colorFill = Base.color.endCube
    local colorLine = Base.color.white
    local colorMesh = {0, 0, 0, 0}

    EndCube.super.new(self, x, y, z, len, len, len, colorFill, colorLine, colorMesh)
end

return EndCube