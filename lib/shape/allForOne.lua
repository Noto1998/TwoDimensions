AllForOne = Shape:extend()

local dirR

function AllForOne:new(position, num, len, radian, colorFill, colorLine, colorMesh)
    AllForOne.super.new(self, position, colorFill, colorLine, colorMesh)

    self.num = num
    self.len = len
    self.radian = 0
    if radian ~= nil then
        self.radian = radian
    end
    dirR = 0
end

function AllForOne:update(dt)
    dirR = dirR + (math.pi/4)*dt
    if dirR > math.pi*2 then
        dirR = dirR - math.pi*2
    end

    --
    self.radian = self.radian + (math.pi/6)*dt
    if self.radian > math.pi*2 then
        self.radian = self.radian - math.pi*2
    end
end

function AllForOne:draw()
    love.graphics.setColor(self.colorLine)
    for i = 1, self.num do
        local radian = math.pi*2*(i/self.num)
        local _x = self.position.x + Base.getVector(self.radian+radian, self.len).x
        local _y = self.position.z + Base.getVector(self.radian+radian, self.len).y

        local minDir = math.pi*2*(1/self.num)
        local len2 = self.len*math.sin(minDir/2)*2
        local dir2 = math.pi-(math.pi/2-minDir/2)
        local _x2 = _x + Base.getVector(self.radian+radian+dir2+dirR, len2).x
        local _y2 = _y + Base.getVector(self.radian+radian+dir2+dirR, len2).y

        love.graphics.line(_x, _y, _x2, _y2)
    end
end