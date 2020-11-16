FourD = Shape:extend()

local modeMin = 0.1
local mode1 = 0.33

function FourD:new(position, lenX, lenY)
    FourD.super.new(self, position)

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
    local _x = self.position.x
    local _y = self.position.y*(1-mode) + self.position.z*mode

    --[[
    local tableT = {
        self.position.x,             _y - self.lenY,
        self.position.x + self.lenX, _y,
        self.position.x,             _y + self.lenY,
        self.position.x - self.lenX, _y,
    }
    local tableT1 = {
        self.position.x,             _y - self.lenY*mode,
        self.position.x + self.lenX, _y,
        self.position.x,             _y + self.lenY*mode,
        self.position.x - self.lenX, _y,
    }
    local tableT2 = {
        self.position.x,             _y - self.lenY*(1-mode),
        self.position.x + self.lenX, _y,
        self.position.x,             _y + self.lenY*(1-mode),
        self.position.x - self.lenX, _y,
    }
    --
    local modeMin = 0.01
    --
    love.graphics.setColor(Base.color.fourD.color1)
    love.graphics.polygon('fill', tableT1)
    love.graphics.setColor(Base.color.fourD.color2)
    love.graphics.polygon('fill', tableT2)
    --
    love.graphics.setColor(Base.color.white)
    if mode > modeMin and mode < (1-modeMin) then
        love.graphics.polygon('line', tableT1)
        love.graphics.polygon('line', tableT2)
    else
        love.graphics.polygon('line', tableT)
    end
    ]]
    local tableT = {
        _x,             _y - self.lenY,
        _x + self.lenX, _y,
        _x,             _y + self.lenY,
        _x - self.lenX, _y,
    }
    love.graphics.setColor(Base.color.white)
    love.graphics.polygon('line', tableT)
end