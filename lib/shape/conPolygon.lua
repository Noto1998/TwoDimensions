ConPolygon = Shape:extend()

function ConPolygon:new(x, y, z, num, len, border, cFill, cLine, cMesh)
    ConPolygon.super.new(self, x, y, z, cFill, cLine, cMesh)

    self.num = num
    self.len = len
    self.border = border
end


function ConPolygon:draw(mode)
    local _x = self.x
    local _y = self.y*(1-mode)+self.z*mode
    local dir = 0
    local table = {}
    local _dir = math.pi*2/self.num

    for i = 1, self.num do
        table[(i-1)*4+1] = _x+Base.getXYbyDir(dir+_dir*(i-1), self.len).x
        table[(i-1)*4+2] = _y+Base.getXYbyDir(dir+_dir*(i-1), self.len).y
        table[(i-1)*4+3] = _x+Base.getXYbyDir(dir+_dir*(i-1)+_dir/2, self.border).x
        table[(i-1)*4+4] = _y+Base.getXYbyDir(dir+_dir*(i-1)+_dir/2, self.border).y
    end
    -- fill
    love.graphics.setColor(self.cFill)
    local triList = love.math.triangulate(table)
    for key, triTable in pairs(triList) do
        love.graphics.polygon('fill', triTable)
    end
    -- line
    love.graphics.setColor(self.cLine)
    love.graphics.polygon('line', table)
end