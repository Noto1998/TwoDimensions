FourD = Shape:extend()


local modeMin = 0.1
local mode1 = 0.33

function FourD:new(x, y, z, lenX, lenY)
    FourD.super.new(self, x, y, z)

    self.lenX = lenX
    self.lenY = lenY
end


function FourD:update(mode)
    --[[
    -- update fourD len
    if (mode >= mode1-modeMin and mode <= mode1+modeMin)
    or (mode >= (1-mode1)-modeMin and mode <= (1-mode1)+modeMin) then
		self.lenX, self.lenY = self.lenY, self.lenX
    end
    ]]
end


function FourD:draw(mode)
    local _x = self.x
    local _y = self.y*(1-mode) + self.z*mode

    --[[
    local tableT = {
        self.x,             _y - self.lenY,
        self.x + self.lenX, _y,
        self.x,             _y + self.lenY,
        self.x - self.lenX, _y,
    }
    local tableT1 = {
        self.x,             _y - self.lenY*mode,
        self.x + self.lenX, _y,
        self.x,             _y + self.lenY*mode,
        self.x - self.lenX, _y,
    }
    local tableT2 = {
        self.x,             _y - self.lenY*(1-mode),
        self.x + self.lenX, _y,
        self.x,             _y + self.lenY*(1-mode),
        self.x - self.lenX, _y,
    }
    --
    local modeMin = 0.01
    --
    love.graphics.setColor(base.cfourD1)
    love.graphics.polygon("fill", tableT1)
    love.graphics.setColor(base.cfourD2)
    love.graphics.polygon("fill", tableT2)
    --
    love.graphics.setColor(base.cWhite)
    if mode > modeMin and mode < (1-modeMin) then
        love.graphics.polygon("line", tableT1)
        love.graphics.polygon("line", tableT2)
    else
        love.graphics.polygon("line", tableT)
    end
    ]]
    local tableT = {
        _x,             _y - self.lenY,
        _x + self.lenX, _y,
        _x,             _y + self.lenY,
        _x - self.lenX, _y,
    }
    love.graphics.setColor(base.cWhite)
    love.graphics.polygon("line", tableT)
end