local AllForOne = Shape:extend()

local dirR


function AllForOne:new(position, num, len, radian, colorFill, colorLine, colorMesh)
    AllForOne.super.new(self, position, colorFill, colorLine, colorMesh)

    self.num = num
    self.len = len
    self.radian = Base.ternary(radian ~= nil, radian, 0)

    dirR = 0
end


function AllForOne:update(dt)

    -- todo: what is dirR ?
    -- limit dirR
    dirR = dirR + (math.pi / 4) * dt
    if dirR > math.pi * 2 then
        dirR = dirR - math.pi * 2
    end

    -- limit radian
    self.radian = self.radian + (math.pi / 6) * dt
    if self.radian > math.pi * 2 then
        self.radian = self.radian - math.pi * 2
    end
end


function AllForOne:draw()

    love.graphics.setColor(self.colorLine)
    for i = 1, self.num do
        local radian = math.pi * 2 * (i / self.num)
        local x1 = self.position.x + Base.getVector(self.radian + radian, self.len).x
        local y1 = self.position.z + Base.getVector(self.radian + radian, self.len).y

        local minDir = math.pi * 2 * (1 / self.num)
        local len2 = self.len * math.sin(minDir / 2) * 2
        local dir2 = math.pi - (math.pi / 2 - minDir / 2)
        local rad = self.radian + radian + dir2 + dirR
        local x2 = x1 + Base.getVector(rad, len2).x
        local y2 = y1 + Base.getVector(rad, len2).y

        love.graphics.line(x1, y1, x2, y2)
    end
end


return AllForOne