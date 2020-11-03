AllForOne = Shape:extend()

local dirR

function AllForOne:new(x, y, z, num, len, dir, cFill, cLine, cMesh)
    AllForOne.super.new(self, x, y, z, cFill, cLine, cMesh)

    self.num = num
    self.len = len
    self.dir = 0
    if dir ~= nil then
        self.dir = dir
    end
    dirR = 0
end

function AllForOne:update(dt)
    dirR = dirR + (math.pi/4)*dt
    if dirR > math.pi*2 then
        dirR = dirR - math.pi*2
    end

    --
    self.dir = self.dir + (math.pi/6)*dt
    if self.dir > math.pi*2 then
        self.dir = self.dir - math.pi*2
    end
end

function AllForOne:draw()
    love.graphics.setColor(self.cLine)
    for i = 1, self.num do
        local dir = math.pi*2*(i/self.num)
        local _x = self.x + base.dirGetXY(self.dir+dir, self.len, 0)
        local _y = self.z + base.dirGetXY(self.dir+dir, self.len, 1)
        
        local minDir = math.pi*2*(1/self.num)
        local len2 = self.len*math.sin(minDir/2)*2
        local dir2 = math.pi-(math.pi/2-minDir/2)
        local _x2 = _x + base.dirGetXY(self.dir+dir+dir2+dirR, len2, 0)
        local _y2 = _y + base.dirGetXY(self.dir+dir+dir2+dirR, len2, 1)

        love.graphics.line(_x, _y, _x2, _y2)
    end
end