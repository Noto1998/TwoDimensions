local EndCube = Cuboid:extend()

function EndCube:new(position)
    local len = Base.lenEndCube
    local colorFill = Base.color.endCube
    local colorLine = Base.color.white
    local colorMesh = {0, 0, 0, 0}

    EndCube.super.new(self, position, len, len, len, colorFill, colorLine, colorMesh)
end

return EndCube