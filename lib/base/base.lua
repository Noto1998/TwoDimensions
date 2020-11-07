---base helpful function
local Base = {}

local keys = require 'lib.game.keys'-- for input
local joysticks = love.joystick.getJoysticks()
local joystick = joysticks[1]-- for function Base.isDown()

-- FUNCTION

--- simple sign(), lua dont have sign()
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

--- easy text print. xMode using love.graphics.printf(), yMode get font's pixels height and move x/y
---@param string string
---@param x number
---@param y number
---@param xMode string
---@param yMode string
function Base.print(string, x, y, xMode, yMode)
    -- xMode
    if xMode == nil and yMode == nil then
        love.graphics.print(string, x, y)
    else
        local w = love.graphics.getFont():getWidth(string) * 2
        local h = Base.gui.fontHeight
        local x2 = math.floor(x-w/2)
        local y2
        local xMode2-- love's default printf()'s rule is reverse

        if xMode == nil or xMode == 'left' then
            xMode2 = 'right'
        elseif xMode == 'center' then
            xMode2 = xMode
        elseif xMode == 'right' then
            xMode2 = 'left'
        else
            error('Invalid alignment ' .. xMode .. ', expected one of: \"left\",\"center\",\"right\"')
        end

        -- yMode
        if yMode == nil or yMode == 'top' then
            y2 = y
        elseif yMode == 'center' then
            y2 = math.floor(y - h/2)
        elseif yMode == 'bottom' then
            y2 = y - h
        else
            error('Invalid alignment ' .. yMode .. ', expected one of: \"top\",\"center\",\"bottom\"')
        end

        love.graphics.printf(string, x2, y2, w, xMode2)
    end
end

--- clone a table, return a new table with new address
---@param table table
---@return table
function Base.cloneTable(table)
    local t1 = {}--new table
    for i = 1, #table do
        t1[i] = table[i]
    end
    return t1
end

--- create a BaseKeyType
---@param keyboard string
---@param gamepad string
---@return BaseKeyType
local function keyCreater(keyboard, gamepad)
    ---@class BaseKeyType
    local table = {}

    table.keyboard = keyboard
    table.gamepad = gamepad
    table.isPressed = false
    table.released = false
    table.timer = 0

    return table
end

--- set keyName.isPressed, keyName is table(pointer)
---@param keyName BaseKeyType
function Base.setKeyPressed(keyName)
    local flag = false

    if not Base.isDown(keyName) then
        keyName.released = true
    else
        -- only one frame
        if keyName.released then
            flag = true
        end

        keyName.released = false
    end

    keyName.isPressed = flag
end

--- set keyName.timer, keyName is table(pointer)
---@param keyName BaseKeyType
function Base.setKeyTimer(keyName, dt)
    if Base.isDown(keyName) then
        keyName.timer = keyName.timer + dt
    else
        keyName.timer = 0
    end
end

--- set all keys's .isPressed and .timer, keys is a table(pointer)
function Base.setAllKeys(dt)
    for k, keyName in pairs(Base.keys) do
        Base.setKeyPressed(keyName)-- for isPressed
        Base.setKeyTimer(keyName, dt)-- for isHold
    end
end

--- reuturn true if a key is down, support keyboard and joystick
---@param keyName BaseKeyType
---@return boolean
function Base.isDown(keyName)
    return love.keyboard.isDown(keyName.keyboard) or (joystick ~= nil and joystick:isGamepadDown(keyName.gamepad))
end

--- return true if key is pressed
---@param keyName BaseKeyType
---@return boolean
function Base.isPressed(keyName)
    return keyName.isPressed
end

--- return true if key is hold over than timeMax
---@param keyName BaseKeyType
---@param timeMax number
---@return boolean
function Base.isHold(keyName, timeMax)
    return keyName.timer > timeMax
end

--- return distance between two points
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@return number
function Base.getDistance(x1, y1, x2, y2)
    local disX = x1 - x2
    local disY = y1 - y2
    return math.sqrt(disX^2 + disY^2)
end

--- draw a rounded rectangle
function Base.drawRoundedRectangle(x, y, width, height, segments)
    -- default segments
    if segments == nil then
        segments = 20
    end
    local radius = math.floor(Base.gui.fontHeight/3)
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

--- get {x, y} by a direction and distance
---@return table
function Base.getXYbyDir(dir, dis)
    local table = {}
    table.x = math.cos(dir)*dis
    table.y = math.sin(dir)*dis

    return table
end


-- GUI
Base.gui = {
    width = love.graphics.getWidth(),
    height = love.graphics.getHeight(),
    fontHeight = love.graphics.getFont():getHeight(),
}
Base.gui.border = Base.gui.width/30-- can't write inside {}, because gui isn't init yet

-- COLOR
Base.color = {
    black = {0, 0, 0},
    white = {1, 1, 1},
    yellow = {1, 1, 0},
    red = {1, 0, 0},
    gray = {0.5, 0.5, 0.5},
    darkGray = {0.25, 0.25, 0.25}
}
-- shape
Base.color.fill = Base.color.black-- watch out, same address
Base.color.line = Base.color.white-- watch out, same address
Base.color.endCube = {0.5, 1, 0.5}-- destination
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
-- player
Base.player = {
    len = 50,
    spdXY = 100,
    spdXZ = math.pi/2
}
Base.lenDestination = 50

return Base