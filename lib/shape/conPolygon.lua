local ConPolygon = Shape:extend()


function ConPolygon:new(position, num, len, border, colorFill, colorLine, colorMesh)
    ConPolygon.super.new(self, position, colorFill, colorLine, colorMesh)

    self.num = num
    self.len = len
    self.border = border
end


function ConPolygon:draw(mode)
    local _x = self.position.x
    local _y = self.position.y * (1 - mode) + self.position.z * mode
    local radian = 0
    local table = {}
    local _radian = math.pi * 2 / self.num

    for i = 0, self.num - 1 do
        local j = i * 4
        local _rad1 = radian +_radian * i
        local _rad2 = _rad1 + _radian/2

        table[j + 1] = _x + Base.getVector(_rad1, self.len).x
        table[j + 2] = _y + Base.getVector(_rad1, self.len).y
        table[j + 3] = _x + Base.getVector(_rad2, self.border).x
        table[j + 4] = _y + Base.getVector(_rad2, self.border).y
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


return ConPolygon