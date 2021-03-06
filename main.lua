-- LOADING SCREEN
local img = love.graphics.newImage('img/loading.png')
love.graphics.clear(0, 0, 0)
love.graphics.draw(img)
love.graphics.present()


-- FONT
-- for lib.Base.lua can get font's height
local font = love.graphics.newFont('font/SourceHanSansCN-Medium.otf', 20)
love.graphics.setFont(font)


-- IMPORT CLASSIC
Object = require 'lib.Base.classic'-- oop
Base = require 'lib.Base.Base'-- helpful tool
Tips = require 'lib.shape.tips'

-- shape
Shape = require 'lib.shape.shape'
Rect = require 'lib.shape.rect'
Cuboid = require 'lib.shape.cuboid'
Ball = require 'lib.shape.ball'
Laser = require 'lib.shape.laser'
MoveCuboid = require 'lib.shape.moveCuboid'
ConPolygon = require 'lib.shape.conPolygon'
AllForOne = require 'lib.shape.allForOne'
--require 'lib.shape.circle'
--require 'lib.shape.fourD'

Player = require 'lib.game.player'
EndCube = require 'lib.game.endCube'
KeyTips = require 'lib.game.keyTips'

Shift = require 'lib.game.shift' -- frist
Level = require 'lib.game.level'

local ScreenManager = require 'lib.game.screenManager'
local BgmManager = require 'lib.game.bgmManager'

Lang = {}-- language table


-- LOAD SCREENS
local MainScreen = require 'screens.mainScreen'
local LangSwitchScreen = require 'screens.langSwitchScreen'

-- load level data
LEVEL_STRINGS = require 'screens.level.levelConf'
local LevelScreenList = {}
for i, levelString in ipairs(LEVEL_STRINGS) do
    local fileName = 'screens/level/all/' .. levelString .. '.lua'
    local file = love.filesystem.getInfo(fileName)
    if file ~= nil then
        table.insert(LevelScreenList, require('screens.level.all.' .. levelString))
    end
end

local function setCanvas()
    local canvas = love.graphics.newCanvas()

    love.graphics.setCanvas(canvas)
        love.graphics.clear()
        local lineBorder = 40

        love.graphics.setColor(Base.color.darkGray)
        for i = 1, Base.gui.height / lineBorder - 1 do
            local y = i * lineBorder
            love.graphics.line(0, y, Base.gui.width, y)
        end
        for i = 1, Base.gui.width / lineBorder - 1 do
            local x = i * lineBorder
            love.graphics.line(x, 0, x, Base.gui.height)
        end
    love.graphics.setCanvas()

    return canvas
end


-- LOAD GAME
function love.load()
    -- DEBUG
    DEBUG_MODE = true        -- work when ./debug/ have files, so remember not git ./debug/
    DEBUG_LEVEL = nil        -- pressed f1 to run level

    -- sound
    SFX_MENU        = love.audio.newSource('sound/bibi.mp3', 'static')
    SFX_TOUCH_GOUND = love.audio.newSource('sound/touchGound.mp3', 'static')
    SFX_SHIFT       = love.audio.newSource('sound/shift.mp3', 'static')
    SFX_FINISH      = love.audio.newSource('sound/finish.mp3', 'static')
    SFX_RESTART     = love.audio.newSource('sound/dead.mp3', 'static')
    SFX_SHOOT       = love.audio.newSource('sound/shoot.mp3', 'static')
    BGM_MAIN        = love.audio.newSource('sound/bgm_191208.mp3', 'stream')
    bgmManager = BgmManager(BGM_MAIN)

    -- canvas
    CANVAS_BG = setCanvas()

    -- register screens
    local screenManager = ScreenManager()
    screenManager:register('/', LangSwitchScreen)   -- frist
    screenManager:register('MainScreen', MainScreen)

    -- register level
    for i, level in ipairs(LevelScreenList) do
        local levelName = LEVEL_STRINGS[i]
        screenManager:register(levelName, level)
    end
end