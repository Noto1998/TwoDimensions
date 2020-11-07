Tips = Object:extend()

local radius = math.floor(Base.guiFontHeight/3)

function Tips:new(string, x, y, z, xMode, yMode)
    self.string = string
    self.x = 0
    if x ~= nil then
        self.x = x
    end
    self.y = 0
    if y ~= nil then
        self.y = y
    end
    self.z = 0
    if z ~= nil then
        self.z = z
    end
    self.xMode = xMode
    self.yMode = yMode
end


function Tips:draw(mode)
    local font = love.graphics.getFont()
    local fWidth = font:getWidth(self.string)
    local reWidth = fWidth + radius*2
    local _y = self.y + (-self.y +self.z)*mode
    local _x = self.x
    
    -- center
    if self.xMode ~= nil then
        if self.xMode == 'center' then
            _x = _x - reWidth/2
        elseif self.xMode == 'right' then
            _x = _x - reWidth
        end
    end
    if self.yMode ~= nil then
        if self.yMode == 'center' then
            _y = _y - Base.guiFontHeight/2
        elseif self.yMode == 'bottom' then
            _y = _y - Base.guiFontHeight
        end
    end

    -- bg
    love.graphics.setColor(Base.cWhite)
    Base.drawRoundedRectangle(_x, _y, reWidth, Base.guiFontHeight)
    -- text
    love.graphics.setColor(Base.cBlack)
    Base.print(self.string, _x+reWidth/2, _y, 'center')
end