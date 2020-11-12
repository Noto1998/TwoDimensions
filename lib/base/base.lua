--- base helpful lib
local Base = {}

local keys = require 'lib.game.keys'-- for Base.keys
local joysticks = love.joystick.getJoysticks()
local joystick = joysticks[1]-- default joystick, for function Base.isDown()

-- FUNCTION

--- ternary operator ( bool ? a : b ). lua don't have ternary operator.
---@param isTrue boolean
---@param result1 any
---@param result2 any
---@return any
function Base.ternary(isTrue, result1, result2)
    if isTrue then
        return result1
    else
        return result2
    end
end

--- simple sign fn, lua don't have sign fn.
---@param number number
---@return number
function Base.sign(number)
    if number == 0 then
        return 0
    elseif number > 0 then
        return 1
    else
        return -1
    end
end

--- easy text print fn. xMode accept 'left', 'center' or 'right', yMode accept 'top', 'center' or 'bottom'.
---@param string string
---@param x number
---@param y number
---@param xMode string
---@param yMode string
function Base.print(string, x, y, xMode, yMode)

    if xMode == nil and yMode == nil then
        love.graphics.print(string, x, y)
    else
        local w = love.graphics.getFont():getWidth(string) * 2
        local h = Base.gui.fontHeight
        local x2 = math.floor(x - w / 2)
        local y2
        local xMode2-- love.graphics.printf()'s rule is reverse

        if xMode == nil or xMode == 'left' then
            xMode2 = 'right'
        elseif xMode == 'center' then
            xMode2 = xMode
        elseif xMode == 'right' then
            xMode2 = 'left'
        else
            error('Invalid alignment ' .. xMode .. ', expected one of: \"left\",\"center\",\"right\"')
        end

        if yMode == nil or yMode == 'top' then
            y2 = y
        elseif yMode == 'center' then
            y2 = math.floor(y - h / 2)
        elseif yMode == 'bottom' then
            y2 = y - h
        else
            error('Invalid alignment ' .. yMode .. ', expected one of: \"top\",\"center\",\"bottom\"')
        end

        love.graphics.printf(string, x2, y2, w, xMode2)
    end
end

--- clone table, return a new table with new address.
---@param table table
---@return table
function Base.cloneTable(table)
    local newTable = {}
    for i = 1, #table do
        newTable[i] = table[i]
    end
    return newTable
end

--- create a BaseKeyType table.
---@param keyboard string
---@param gamepad string
---@return BaseKeyType
local function keyCreater(keyboard, gamepad)
    ---@class BaseKeyType
    local table = {}

    ---@type string
    table.keyboard = keyboard
    ---@type string
    table.gamepad = gamepad
    table.isPressed = false
    table.isReleased = false
    table.timer = 0

    return table
end

--- set keyName.isPressed. for isPressed().
---@param keyName BaseKeyType
function Base.setKeyPressed(keyName)
    local flag = false

    if not Base.isDown(keyName) then
        keyName.isReleased = true
    else
        -- only one frame
        if keyName.isReleased then
            flag = true
        end

        keyName.isReleased = false
    end

    keyName.isPressed = flag
end

--- set keyName.timer. for isHold().
---@param keyName BaseKeyType
function Base.setKeyTimer(keyName, dt)
    if Base.isDown(keyName) then
        keyName.timer = keyName.timer + dt
    else
        keyName.timer = 0
    end
end

--- set all keys to make sure isPressed() and isHold() can work. keys is BaseKeyType table.
---@param dt number
function Base.setAllKeys(dt)
    for k, keyName in pairs(Base.keys) do
        Base.setKeyPressed(keyName)
        Base.setKeyTimer(keyName, dt)
    end
end

--- reuturn true if a key is down, support keyboard and joystick.
---@param keyName BaseKeyType
---@return boolean
function Base.isDown(keyName)
    return love.keyboard.isDown(keyName.keyboard) or (joystick ~= nil and joystick:isGamepadDown(keyName.gamepad))
end

--- return true if key is pressed, support keyboard and joystick.
---@param keyName BaseKeyType
---@return boolean
function Base.isPressed(keyName)
    return keyName.isPressed
end

--- return true if key is hold over than timeMax, support keyboard and joystick.
---@param keyName BaseKeyType
---@param timeMax number
---@return boolean
function Base.isHold(keyName, timeMax)
    return keyName.timer > timeMax
end

--- return distance between two points.
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@return number
function Base.getDistance(x1, y1, x2, y2)
    local disX = x1 - x2
    local disY = y1 - y2
    return math.sqrt(disX ^ 2 + disY ^ 2)
end

--- get { x = x, y = y } by direction and distance.
---@param dir number
---@param dis number
---@return table
function Base.getXYbyDir(dir, dis)
    local tx = math.cos(dir) * dis
    local ty = math.sin(dir) * dis

    return { x = tx, y = ty }
end

--- draw a rounded rectangle.
---@param x number
---@param y number
---@param width number
---@param height number
---@param segments number
function Base.drawRoundedRectangle(x, y, width, height, segments)

    -- default segments
    if segments == nil then
        segments = 20
    end

    local radius = math.floor(Base.gui.fontHeight / 3)
    local x1 = x + radius
    local y1 = y + radius
    local x2 = x + width - radius
    local y2 = y + height - radius
    local xyTable = {
        {x1, y1},
        {x2, y1},
        {x2, y2},
        {x1, y2}
    }
    local dirTable = {
        {-math.pi/2,    -math.pi},
        {-math.pi/2,    0},
        {0,             math.pi/2},
        {math.pi/2,     math.pi},
    }

    for i = 1, 4 do
        love.graphics.arc('fill', xyTable[i][1], xyTable[i][2], radius, dirTable[i][1], dirTable[i][2], segments)
    end
    love.graphics.rectangle('fill', x, y1, width,          height-radius*2)
    love.graphics.rectangle('fill', x1, y, width-radius*2, height)
end

local function smoothStart(t)
    return t*t*t
end
local function smoothStop(t)
    return 1-(1-t)*(1-t)*(1-t)
end
--- return 0 to 1 with non-linear. base on "Fast and Funky 1D Nonlinear Tramsformations" GDC talk.
---@param t number
---@return number
function Base.mix(t)
    if t > 1 then
        t = 1
    end

    local weight = t

    return smoothStart(t) * (1-weight) + smoothStop(t) * weight
end


-- GUI
Base.gui = {
    width = love.graphics.getWidth(),
    height = love.graphics.getHeight(),
    fontHeight = love.graphics.getFont():getHeight(),
}
Base.gui.border = Base.gui.width / 30-- can't write inside {}, because Base.gui.width isn't init yet

-- COLOR
Base.color = {
    black = {0, 0, 0},
    white = {1, 1, 1},
    yellow = {1, 1, 0},
    red = {1, 0, 0},
    gray = {0.5, 0.5, 0.5},
    darkGray = {0.25, 0.25, 0.25}
}
Base.color.fill = Base.color.black-- watch out, same address
Base.color.line = Base.color.white-- watch out, same address
Base.color.endCube = {0.5, 1, 0.5}
--loaser
Base.color.loaser = {
    warning = Base.cloneTable(Base.color.red),
    danger = Base.color.yellow,-- watch out, same address
    safe = Base.color.gray-- watch out, same address
}
Base.color.loaser.warning[4] = 0.35
--[[
-- fourD
Base.color.fourD = {
    color1 = {0.92, 0.02, 0.76, 0.25},
    color2 = {0.02, 0.92, 0.7, 0.25}
}
]]


-- KEY
Base.keys = {
    up      = keyCreater(keys.DPad_up,     'dpup'),
    down    = keyCreater(keys.DPad_down,   'dpdown'),
    left    = keyCreater(keys.DPad_left,   'dpleft'),
    right   = keyCreater(keys.DPad_right,  'dpright'),
    shift   = keyCreater(keys.Y,           'y'),
    enter   = keyCreater(keys.A,           'a'),
    cancel  = keyCreater(keys.B,           'b'),
    keyTips = keyCreater(keys.X,           'x'),
    music   = keyCreater(keys.Select,      'back'),
    reset   = keyCreater(keys.Start,       'start')
}


-- ELSE
Base.garvity = 100
Base.player = {
    len = 50,
    spdXY = 100,
    spdXZ = math.pi / 2
}
Base.lenEndCube = 50


return Base