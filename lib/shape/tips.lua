local Tips = Object:extend()

local RADIUS = math.floor(Base.gui.fontHeight / 3)

local function initDrawXY(self)
    local x, y

    if (self.xMode == nil) or (self.xMode == 'left') then
        x = self.position.x
    elseif self.xMode == 'center' then
        x = self.position.x - self.tipsWidth/2
    elseif self.xMode == 'right' then
        x = self.position.x - self.tipsWidth
    end

    if (self.yMode == nil) or (self.yMode == 'top') then
        y = self.position.y
    elseif self.yMode == 'center' then
        y = self.position.y - Base.gui.fontHeight/2
    elseif self.yMode == 'bottom' then
        y = self.position.y - Base.gui.fontHeight
    end

    self.drawX = x
    self.drawY = y
end
local function initTipsWidth(self)
    local font = love.graphics.getFont()
    local stringWidth = font:getWidth(self.string)

    self.tipsWidth = stringWidth + RADIUS * 2
end

function Tips:new(string, x, y, z, xMode, yMode, colorBg, colorText)

    self.string = string

    local x2 = Base.ternary(x ~= nil, x, 0)
    local y2 = Base.ternary(y ~= nil, y, 0)
    local z2 = Base.ternary(z ~= nil, z, 0)
    self.position = Base.createPosition(x2, y2, z2)

    self.xMode = xMode
    self.yMode = yMode

    self.colorBg = Base.ternary(colorBg ~= nil, colorBg, Base.color.white)
    self.colorText = Base.ternary(colorText ~= nil, colorText, Base.color.black)

    initTipsWidth(self)
    initDrawXY(self)
end


function Tips:draw(mode)
    local y = self.drawY + (-self.position.y +self.position.z) * mode

    -- bg
    love.graphics.setColor(self.colorBg)
    Base.drawRoundedRectangle(self.drawX, y, self.tipsWidth, Base.gui.fontHeight)
    -- text
    love.graphics.setColor(self.colorText)
    Base.print(self.string, self.drawX + self.tipsWidth / 2, y, 'center')
end


function Tips:changeText(string)
    self.string = string
    -- update TipsWidth and drawXY
    initTipsWidth(self)
    initDrawXY(self)
end


return Tips