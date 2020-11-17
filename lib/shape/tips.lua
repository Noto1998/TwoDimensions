local Tips = Object:extend()

local RADIUS = math.floor(Base.gui.fontHeight / 3)

local function initDrawXY(self)
    local x, y

    if (self.xMode == nil) or (self.xMode == 'left') then
        x = self.position.x
    elseif self.xMode == 'center' then
        x = self.position.x - self.tipsWidth / 2
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

function Tips:new(string, position, xMode, yMode, colorBg, colorText)

    self.string = string
    self.position = Base.cloneTable(position)

    self.xMode = xMode
    self.yMode = yMode

    self.colorBg = Base.ternary(colorBg ~= nil, colorBg, Base.color.white)
    self.colorText = Base.ternary(colorText ~= nil, colorText, Base.color.black)

    initTipsWidth(self)
    initDrawXY(self)
end


function Tips:draw(mode)
    local y = self.drawY * (1 - mode) + self.position.z * mode

    -- bg
    love.graphics.setColor(self.colorBg)
    Base.drawRoundedRect(self.drawX, y, self.tipsWidth, Base.gui.fontHeight)
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