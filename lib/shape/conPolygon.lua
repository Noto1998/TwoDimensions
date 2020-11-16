ConPolygon = Shape:extend()

function ConPolygon:new(position, num, len, border, colorFill, colorLine, colorMesh)
    ConPolygon.super.new(self, position, colorFill, colorLine, colorMesh)

    self.num = num
    self.len = len
    self.border = border
end


function ConPolygon:draw(mode)
    local _x = self.position.x
    local _y = self.position.y*(1-mode)+self.position.z*mode
    local radian = 0
    local table = {}
    local _dir = math.pi*2/self.num

    for i = 1, self.num do
        table[(i-1)*4+1] = _x+Base.getVector(radian+_dir*(i-1), self.len).x
        table[(i-1)*4+2] = _y+Base.getVector(radian+_dir*(i-1), self.len).y
        table[(i-1)*4+3] = _x+Base.getVector(radian+_dir*(i-1)+_dir/2, self.border).x
        table[(i-1)*4+4] = _y+Base.getVector(radian+_dir*(i-1)+_dir/2, self.border).y
    end
    -- fill
    love.graphics.setColor(self.colorFill)
    local triList = love.math.triangulate(table)
    for key, triTable in pairs(triList) do
        love.graphics.polygon('fill', triTable)
    end
    -- line
    love.graphics.setColor(self.colorLine)
    love.graphics.polygon('line', table)
end