local base = {}

--- function
function base.sign(number)
    if number > 0 then
        return 1
    elseif number < 0 then
        return -1
    else
        return 0
    end
end
function base.print(string, x, y, xMode, yMode)
    -- easy text print, xMode using love.graphics.printf(), yMode get font's pixels height and move x/y
    -- xMode
    if xMode == nil and yMode == nil then
        love.graphics.print(string, x, y)
    else
        local w = love.graphics.getFont():getWidth(string) * 2
        local h = base.guiFontHeight
        local y2 = y
        local xMode2 = xMode -- more usual
        -- yMode
        if yMode == "top" or yMode == nil then
            --default
        elseif yMode == "center" then
            y2 = math.floor(y - h/2)
        elseif yMode == "bottom" then
            y2 = y - h
        else
            error("Invalid alignment " .. yMode .. ", expected one of: 'top','center','bottom'");
        end

        if xMode ~= nil then
            if xMode == "left" then
                xMode2 = "right"
            elseif xMode == "right" then
                xMode2 = "left"
            end
        end
        love.graphics.printf(string, math.floor(x-w/2), y2, w, xMode2)
    end
end
function base.cloneTable(table)
    local t1 ={}--new table
    for i = 1, #table do
        t1[i] = table[i]
    end

    return t1
end
function base.isDown(keyName)
    return love.keyboard.isDown(keyName.keyboard) or (joystick ~= nil and joystick:isGamepadDown(keyName.gamepad))
end
function base.pressedSetting(keyName, dt)
    local flag = false
    
    -- reset
    if not base.isDown(keyName) then
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
function base.isPressed(keyName)
    return keyName.isPressed
end
function base.getDistance(x1, y1, x2, y2)
    local disX = x1 - x2
    local disY = y1 - y2
    
    return math.sqrt(disX^2 + disY^2)
end
function base.drawRoundedRectangle(x, y, width, height)
    local segments = 20
    local radius = math.floor(base.guiFontHeight/3)
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
        love.graphics.arc("fill", xyTable[i][1], xyTable[i][2], radius, dirTable[i][1], dirTable[i][2], segments)
    end
    love.graphics.rectangle("fill", x, y1, width,          height-radius*2)
    love.graphics.rectangle("fill", x1, y, width-radius*2, height)
end
function base.dirGetXY(dir, dis, xy)
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
---

--- gui
base.guiWidth = love.graphics.getWidth()
base.guiHeight = love.graphics.getHeight()
base.guiBorder = base.guiWidth/30
base.guiFontHeight = love.graphics.getFont():getHeight()
---

--- color
base.cBlack = {0, 0, 0}
base.cWhite = {1, 1, 1}
base.cYellow = {1, 1, 0}
base.cRed = {1, 0, 0}
base.cGray = {0.5, 0.5, 0.5}
base.cDarkGray = {0.25, 0.25, 0.25}
-- shape
base.cFill = base.cBlack
base.cLine = base.cWhite
-- destination
base.cDestination = {0.5, 1, 0.5}
--loaser
base.cWarning = base.cloneTable(base.cRed)
base.cWarning[4] = 0.35
base.cDanger = base.cYellow
base.cSafe = base.cGray
-- fourD
base.cfourD1 = {0.92, 0.02, 0.76, 0.25}
base.cfourD2 = {0.02, 0.92, 0.7, 0.25}
---

--- keys
-- gamepad
local joysticks = love.joystick.getJoysticks()
local joystick = joysticks[1]
-- all key
base.keys = {}
base.keys.up    = keyCreater(keys.DPad_up,      "dpup")
base.keys.down  = keyCreater(keys.DPad_down,    "dpdown")
base.keys.left  = keyCreater(keys.DPad_left,    "dpleft")
base.keys.right  = keyCreater(keys.DPad_right,  "dpright")
base.keys.shift  = keyCreater(keys.Y,           "y")
base.keys.enter  = keyCreater(keys.A,           "a")
base.keys.cancel = keyCreater(keys.B,           "b")
base.keys.keyTips= keyCreater(keys.X,           "x")
base.keys.music  = keyCreater(keys.Select,      "back")
base.keys.reset  = keyCreater(keys.Start,       "start")
---

base.garvity = 100
-- player
base.player = {}
base.player.len = 50
base.player.spdXY = 100
base.player.spdXZ = math.pi/2
-- 
base.lenDestination = 50

return base