local Tips = Object:extend()

local RADIUS = math.floor(Base.gui.fontHeight / 3)
local tipsWidth
local drawX, drawY

local function initDrawXY(self)
    local x, y

    if self.xMode == nil or self.xMode == 'left' then
        x = self.position.x
    elseif self.xMode == 'center' then
        x = self.position.x - tipsWidth/2
    elseif self.xMode == 'right' then
        x = self.position.x - tipsWidth
    end

    if self.yMode == nil or self.yMode == 'top' then
        y = self.position.y
    elseif self.yMode == 'center' then
        y = self.position.y - Base.gui.fontHeight/2
    elseif self.yMode == 'bottom' then
        y = self.position.y - Base.gui.fontHeight
    end

    return x, y
end
local function initTipsWidth(self)
    local font = love.graphics.getFont()
    local stringWidth = font:getWidth(self.string)

    return stringWidth + RADIUS * 2
end

function Tips:new(string, x, y, z, xMode, yMode, colorBg, colorText)

    self.string = string

    local x2 = Base.ternary(x ~= nil, x, 0)
    local y2 = Base.ternary(y ~= nil, x, 0)
    local z2 = Base.ternary(z ~= nil, x, 0)
    self.position = Base.createPosition(x2, y2, z2)

    self.xMode = xMode
    self.yMode = yMode

    self.colorBg = Base.ternary(colorBg ~= nil, colorBg, Base.color.white)
    self.colorText = Base.ternary(colorText ~= nil, colorText, Base.color.black)

    tipsWidth = initTipsWidth(self)
    drawX, drawY = initDrawXY(self)
end


function Tips:draw(mode)
    drawY = drawY + (-self.position.y +self.position.z) * mode

    -- bg
    love.graphics.setColor(self.colorBg)
    Base.drawRoundedRectangle(drawX, drawY, tipsWidth, Base.gui.fontHeight)
    -- text
    love.graphics.setColor(self.colorText)
    Base.print(self.string, drawX + tipsWidth / 2, drawY, 'center')
end

return Tips