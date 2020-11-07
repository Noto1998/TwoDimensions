local keys = require 'lib.game.keys'-- for input

local Base = {}

-- FUNCTION
function Base.sign(number)
    if number > 0 then
        return 1
    elseif number < 0 then
        return -1
    else
        return 0
    end
end

-- easy text print, xMode using love.graphics.printf(), yMode get font's pixels height and move x/y
function Base.print(string, x, y, xMode, yMode)
    -- xMode
    if xMode == nil and yMode == nil then
        love.graphics.print(string, x, y)
    else
        local w = love.graphics.getFont():getWidth(string) * 2
        local h = Base.guiFontHeight
        local y2 = y
        local xMode2 = xMode -- more usual
        -- yMode
        if yMode == 'top' or yMode == nil then
            --default
        elseif yMode == 'center' then
            y2 = math.floor(y - h/2)
        elseif yMode == 'bottom' then
            y2 = y - h
        else
            error('Invalid alignment ' .. yMode .. ', expected one of: \"top\",\"center\",\"bottom\"')
        end

        if xMode ~= nil then
            if xMode == 'left' then
                xMode2 = 'right'
            elseif xMode == 'right' then
                xMode2 = 'left'
            end
        end
        love.graphics.printf(string, math.floor(x-w/2), y2, w, xMode2)
    end
end

function Base.cloneTable(table)
    local t1 ={}--new table
    for i = 1, #table do
        t1[i] = table[i]
    end

    return t1
end

function Base.isDown(keyName)
    return love.keyboard.isDown(keyName.keyboard) or (joystick ~= nil and joystick:isGamepadDown(keyName.gamepad))
end

function Base.pressedSetting(keyName, dt)
    local flag = false
    
    -- reset
    if not Base.isDown(keyName) then
        keyName.released = true
        keyName.timerMax = 0
        keyName.timer = 0
    else
        keyName.timer = keyName.timer + dt
        
        if keyName.timerMax == 0 then   -- only 1 frame
            keyName.timerMax = dt
        end

        -- only 1 frame
        if keyName.timer > keyName.timerMax then
            keyName.released = false
        end

        if keyName.released then
            flag = true
        end
    end

    return flag
end

function Base.isPressed(keyName)
    return keyName.isPressed
end

function Base.getDistance(x1, y1, x2, y2)
    local disX = x1 - x2
    local disY = y1 - y2
    
    return math.sqrt(disX^2 + disY^2)
end

function Base.drawRoundedRectangle(x, y, width, height)
    local segments = 20
    local radius = math.floor(Base.guiFontHeight/3)
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

function Base.dirGetXY(dir, dis, xy)
    local x = math.cos(dir)*dis
    local y = math.sin(dir)*dis
    
    if xy == 0 then
        return x
    elseif xy == 1 then
        return y
    else
        return x, y
    end
end

local function keyCreater(keyboard, gamepad)
    local table = {}

    table.keyboard = keyboard
    table.gamepad = gamepad
    table.isPressed = false
    -- set default released
    table.released = false
    table.timer = 0
    table.timerMax = 0

    return table
end


-- GUI
Base.guiWidth = love.graphics.getWidth()
Base.guiHeight = love.graphics.getHeight()
Base.guiBorder = Base.guiWidth/30
Base.guiFontHeight = love.graphics.getFont():getHeight()


-- color
Base.cBlack = {0, 0, 0}
Base.cWhite = {1, 1, 1}
Base.cYellow = {1, 1, 0}
Base.cRed = {1, 0, 0}
Base.cGray = {0.5, 0.5, 0.5}
Base.cDarkGray = {0.25, 0.25, 0.25}

-- shape
Base.cFill = Base.cBlack
Base.cLine = Base.cWhite
-- destination
Base.cDestination = {0.5, 1, 0.5}
--loaser
Base.cWarning = Base.cloneTable(Base.cRed)
Base.cWarning[4] = 0.35
Base.cDanger = Base.cYellow
Base.cSafe = Base.cGray
-- fourD
Base.cfourD1 = {0.92, 0.02, 0.76, 0.25}
Base.cfourD2 = {0.02, 0.92, 0.7, 0.25}
---

-- KEY
-- gamepad
local joysticks = love.joystick.getJoysticks()
local joystick = joysticks[1]
-- all key
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