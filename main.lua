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
-- shape
Shape = require 'lib.shape.shape'
require 'lib.shape.rectangle'
require 'lib.shape.circle'
require 'lib.shape.cuboid'
require 'lib.shape.laser'
require 'lib.shape.ball'
require 'lib.shape.tips'
require 'lib.shape.fourD'
require 'lib.shape.moveCuboid'
require 'lib.shape.conPolygon'
require 'lib.shape.allForOne'
-- level
Shift = require 'lib.game.shift' -- frist
require 'lib.game.level'

require 'lib.game.player'-- player
EndCube = require 'lib.game.endCube'-- endCube
require 'lib.game.keyTips'-- keyTips

local ScreenManager = require 'lib.game.screenManager'
local BgmManager = require 'lib.game.bgmManager'

Lang = {}-- language table


-- LOAD SCREENS
local MainScreen = require 'screens.mainScreen'
local LangSwitchScreen = require 'screens.langSwitchScreen'

-- load level data
LEVEL_STRING = require 'screens.level.levelConf'
local LevelScreenList = {}
for i, value in ipairs(LEVEL_STRING) do
    local fileName = 'screens/level/all/' .. value .. '.lua'
    local file = love.filesystem.getInfo(fileName)
    if file ~= nil then
        table.insert(LevelScreenList, require('screens.level.all.' .. value))
    end
end


-- LOAD GAME
function love.load()
    -- DEBUG
    DEBUG_MODE = true        -- work when ./debug/ have files, so remember not git ./debug/
    DEBUG_LEVEL = nil        -- pressed f1 to run level

    -- level
    LEVEL_CHOICE = 1         -- for goto next level
    RESET_LEVEL_PATH = nil  -- for reset level, set in screenManager.lua

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
    CANVAS_BG = love.graphics.newCanvas()
    love.graphics.setCanvas(CANVAS_BG)
        love.graphics.clear()
        local lineBorder = 40
        love.graphics.setColor(Base.color.darkGray)
        for i = 1, Base.gui.height/lineBorder-1 do
            local y = i * lineBorder
            love.graphics.line(0, y, Base.gui.width, y)
        end
        for i = 1, Base.gui.width/lineBorder-1 do
            local x = i * lineBorder
            love.graphics.line(x, 0, x, Base.gui.height)
        end
    love.graphics.setCanvas()

    -- register screens
    local screenManager = ScreenManager()
    screenManager:register('/', LangSwitchScreen)   -- frist
    screenManager:register('MainScreen', MainScreen)

    -- register level
    for i, level in ipairs(LevelScreenList) do
        local levelName = LEVEL_STRING[i]
        screenManager:register(levelName, level)
    end
end