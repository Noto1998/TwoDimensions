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
    for key, value in pairs(table) do
        newTable[key] = value
    end
    return newTable
end

function Base.mixColor(colorTable, color1, color2, t)
    for i = 1, #color1 do
        colorTable[i] = color1[i] * t + color2[i] * (1 - t)
    end
end

--- create PositionType table.
---@param x number
---@param y number
---@param z number
---@return PositionType
function Base.createPosition(x, y, z)
    ---@class PositionType
    local position = {}

    ---@type number
    position.x = x
    ---@type number
    position.y = y
    ---@type number
    position.z = z

    -- set toString fn in position.metatable.
    local toStringTable = {
        __tostring = function(table)
            return '{ ' .. table.x .. ', ' .. table.y .. ', ' .. table.z .. ' }'
        end
    }
    setmetatable(position, toStringTable)

    return position
end

--- create a KeyType table.
---@param keyboard string
---@param gamepad string
---@return KeyType
local function createKey(keyboard, gamepad)
    ---@class KeyType
    local baseKey = {}

    ---@type string
    baseKey.keyboard = keyboard
    ---@type string
    baseKey.gamepad = gamepad
    ---@type boolean
    baseKey.isPressed = false
    ---@type boolean
    baseKey.isReleased = false
    ---@type number
    baseKey.holdTimer = 0

    local toStringTable = {
        __tostring = function(table)
            return 'KeyType ( keyboard:' .. table.keyboard .. ' gamepad:' .. table.gamepad .. ' )'
        end
    }
    setmetatable(baseKey, toStringTable)

    return baseKey
end

--- set keyName.isPressed. for isPressed().
---@param keyName KeyType
local function setKeyPressed(keyName)
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

--- set keyName.holdTimer. for isHold().
---@param keyName KeyType
local function setKeyTimer(keyName, dt)
    if Base.isDown(keyName) then
        keyName.holdTimer = keyName.holdTimer + dt
    else
        keyName.holdTimer = 0
    end
end

--- set all keys to make sure isPressed() and isHold() can work. keys is KeyType table.
---@param dt number
function Base.setAllKeys(dt)
    for k, keyName in pairs(Base.keys) do
        setKeyPressed(keyName)
        setKeyTimer(keyName, dt)
    end
end

--- reuturn true if a key is down, support keyboard and joystick.
---@param keyName KeyType
---@return boolean
function Base.isDown(keyName)
    return love.keyboard.isDown(keyName.keyboard) or (joystick ~= nil and joystick:isGamepadDown(keyName.gamepad))
end

--- return true if key is pressed, support keyboard and joystick.
---@param keyName KeyType
---@return boolean
function Base.isPressed(keyName)
    return keyName.isPressed
end

--- return true if key is hold over than timeMax, support keyboard and joystick.
---@param keyName KeyType
---@param timeMax number
---@return boolean
function Base.isHold(keyName, timeMax)
    return keyName.holdTimer > timeMax
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


function Base.getRadian(x1, y1, x2, y2)
    local disX = math.abs(x1 - x2)
    local disY = math.abs(y1 - y2)
    local radian = math.atan(disX / disY)

    return radian
end


--- get { x = , y = } by direction and distance.
---@param radian number
---@param len number
---@return table
function Base.getVector(radian, len)
    local table = {}
    local x = math.cos(radian) * len
    local y = math.sin(radian) * len

    table.x = x
    table.y = y

    return table
end

function Base.getVectorLenX(radian, lenY)
    return lenY / math.tan(radian)
end
function Base.getVectorLenY(radian, lenX)
    return lenX * math.tan(radian)
end


-- test, base shape collision

function Base.isLineWithPoint(lineX, lineY, lineRadian, lineLen, pointX, pointY, checkBorderX, checkBorderY)
    local flag = false

    checkBorderX = Base.ternary(checkBorderX ~= nil, checkBorderX, 1)
    checkBorderY = Base.ternary(checkBorderY ~= nil, checkBorderY, 1)

    local checkTime = lineLen

    local lenPartX = Base.getVector(lineRadian, lineLen).x / checkTime
    local lenPartY = Base.getVector(lineRadian, lineLen).y / checkTime

    -- check from point1 to point 2
    for i = 0, checkTime do
        local checkX = lineX + lenPartX
        local checkY = lineY + lenPartY

        -- checkBorder default is 1
        if math.abs(pointX - checkX) <= checkBorderX and math.abs(pointY - checkY) <= checkBorderY then
            flag = true
            break
        end
    end

    return flag
end

function Base.isRectWithPoint(rectX, rectY, rectLenX, rectLenY, pointX, pointY)
    local flag = false
    local rectX2 = rectX + rectLenX
    local rectY2 = rectY + rectLenY
    local left = Base.ternary(rectX < rectX2, rectX, rectX2)
    local right = Base.ternary(rectX > rectX2, rectX, rectX2)
    local top = Base.ternary(rectY < rectY2, rectY, rectY2)
    local bottom = Base.ternary(rectY > rectY2, rectY, rectY2)

    if pointX > left and pointX < right and pointY > top and pointY < bottom then
        flag = true
    end

    return flag
end

function Base.isRectWithLine(rectX, rectY, rectLenX, rectLenY, lineX, lineY, lineRadian, lineLen)
    local flag = false

    local lineX2 = lineX + Base.getVector(lineRadian, lineLen).x
    local lineY2 = lineY + Base.getVector(lineRadian, lineLen).y

    -- check two points
    if Base.isRectWithPoint(rectX, rectY, rectLenX, rectLenY, lineX, lineY) or
    Base.isRectWithPoint(rectX, rectY, rectLenX, rectLenY, lineX2, lineY2) then
        return true
    end

    local rectX2 = rectX + rectLenX
    local rectY2 = rectY + rectLenY
    local left = Base.ternary(rectX < rectX2, rectX, rectX2)
    local right = Base.ternary(rectX > rectX2, rectX, rectX2)
    local top = Base.ternary(rectY < rectY2, rectY, rectY2)
    local bottom = Base.ternary(rectY > rectY2, rectY, rectY2)

    -- vertical
    if lineX == lineX2 then
        local lineYTop = Base.ternary(lineY < lineY2, lineY, lineY2)
        local lineYBottom = Base.ternary(lineY > lineY2, lineY, lineY2)

        if (bottom > lineYTop and top < lineYBottom) and
   	       (lineX > left and lineX < right) then
            return true
        end
    end

    -- horizontal
    if lineY == lineY2 then
        local lineXLeft = Base.ternary(lineX < lineX2, lineX, lineX2)
        local lineYRight = Base.ternary(lineX > lineX2, lineX, lineX2)

        if (left > lineYRight and right < lineXLeft) and
   	       (lineY > top and lineY < bottom) then
            return true
        end
    end

    -- points not in rect, so the line must be goes through rect
    -- todo:

    return flag
end

-- todo: rect with rect

function Base.isCircleWithPoint(circleX, circleY, circleRadius, pointX, pointY)
    local dis = Base.getDistance(circleX, circleY, pointX, pointY)
    local flag = dis < circleRadius

    return flag
end

function Base.isCircleWithLine(circleX, circleY, circleRadius, lineX, lineY, lineRadian, lineLen)
    local flag = false

    local lineX2 = lineX + Base.getVector(lineRadian, lineLen).x
    local lineY2 = lineY + Base.getVector(lineRadian, lineLen).y

    -- check two points
    if Base.isCircleWithPoint(circleX, circleY, circleRadius, lineX, lineY) or Base.isCircleWithPoint(circleX, circleY, circleRadius, lineX2, lineY2) then
        return true
    end

    -- points not in circle, so the line must be goes through circle
    local dis = Base.getDistanceWithPointAndLine(circleX, circleY, lineX, lineY, lineRadian)
    if dis < circleRadius then
        return true
    end

    return flag
end

function Base.getDistanceWithPointAndLine(pointX, pointY, lineX, lineY, lineRadian)
    local bigRadian = Base.getRadian(lineX, lineY, pointX, pointY)
    local dis1 = Base.getDistance(lineX, lineY, pointX, pointY)
    local smallRadian = lineRadian - bigRadian
    local dis = math.sin(smallRadian) * dis1

    return dis
end


--- draw a rounded rect.
---@param x number
---@param y number
---@param width number
---@param height number
---@param segments number
function Base.drawRoundedRect(x, y, width, height, segments)

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
    love.graphics.rectangle('fill', x,  y1, width,              height - radius * 2)
    love.graphics.rectangle('fill', x1, y,  width - radius * 2, height)
end

local function smoothStart(t)
    return t * t * t
end
local function smoothStop(t)
    return 1 - (1 - t) * (1 - t) * (1 - t)
end
--- return 0 to 1 with non-linear. base on "Fast and Funky 1D Nonlinear Tramsformations" GDC talk.
---@param t number
---@return number
function Base.mix(t)
    if t > 1 then
        t = 1
    end

    local weight = t

    return smoothStart(t) * (1 - weight) + smoothStop(t) * weight
end


-- GUI
Base.gui = {
    width = love.graphics.getWidth(),
    height = love.graphics.getHeight(),
    fontHeight = love.graphics.getFont():getHeight(),
}
Base.gui.border = Base.gui.width / 30-- can't write inside {}, because Base.gui.width isn't init yet


-- COLOR
---@class ColorType
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
    up      = createKey(keys.DPad_up,     'dpup'),
    down    = createKey(keys.DPad_down,   'dpdown'),
    left    = createKey(keys.DPad_left,   'dpleft'),
    right   = createKey(keys.DPad_right,  'dpright'),
    shift   = createKey(keys.Y,           'y'),
    enter   = createKey(keys.A,           'a'),
    cancel  = createKey(keys.B,           'b'),
    keyTips = createKey(keys.X,           'x'),
    music   = createKey(keys.Select,      'back'),
    reset   = createKey(keys.Start,       'start')
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