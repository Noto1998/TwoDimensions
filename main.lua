-- LOADING SCREEN
local img = love.graphics.newImage('img/loading.png')
love.graphics.clear(0, 0, 0)
love.graphics.draw(img)
love.graphics.present()


-- FONT
-- for lib.base.lua can get font's height
local font = love.graphics.newFont('font/SourceHanSansCN-Medium.otf', 20)
love.graphics.setFont(font)


-- IMPORT CLASSIC
Object = require 'lib.base.classic'-- oop
base = require 'lib.base.base'-- helpful tool
Position = require 'lib.base.position'
-- shape
require 'lib.shape.shape'
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
require 'lib.game.destination'-- destination
require 'lib.game.keyTips'-- keyTips

local ScreenManager = require 'lib.game.screenManager'
local BgmManager = require 'lib.game.bgmManager'

lang = {}-- language table


-- LOAD SCREENS
local MainScreen = require 'screens.mainScreen'
local LangSwitchScreen = require 'screens.langSwitchScreen'
-- load level data
levelString = require 'screens.level.levelConf'
local LevelScreenList = {}
for i, value in ipairs(levelString) do
    local fileName = 'screens/level/all/' .. value .. '.lua'
    local file = love.filesystem.getInfo(fileName)
    if file ~= nil then
        table.insert(LevelScreenList, require('screens.level.all.' .. value))
    end
end


-- LOAD GAME
function love.load()
    -- DEBUG
    debugMode = true        -- work when ./debug/ have files, so remember not git ./debug/
    debugLevel = nil        -- pressed f1 to run level
    
    -- level
    levelChoice = 1         -- for goto next level
    resetLevelString = nil  -- for reset level, set in screenManager.lua

    -- sound
    sfx_menu        = love.audio.newSource('sound/bibi.mp3', 'static')
    sfx_touchGound  = love.audio.newSource('sound/touchGound.mp3', 'static')
    sfx_shift       = love.audio.newSource('sound/shift.mp3', 'static')
    sfx_finish      = love.audio.newSource('sound/finish.mp3', 'static')
    sfx_restart     = love.audio.newSource('sound/dead.mp3', 'static')
    sfx_shoot       = love.audio.newSource('sound/shoot.mp3', 'static')
    bgm_main        = love.audio.newSource('sound/bgm_191208.mp3', 'stream')
    
    bgmManager = BgmManager(bgm_main)

    -- canvas
    canvasBG = love.graphics.newCanvas()
    love.graphics.setCanvas(canvasBG)
        love.graphics.clear()
        local lineBorder = 40
        love.graphics.setColor(base.cDarkGray)
        for i = 1, base.guiHeight/lineBorder-1 do
            local y = i * lineBorder
            love.graphics.line(0, y, base.guiWidth, y)
        end
        for i = 1, base.guiWidth/lineBorder-1 do
            local x = i * lineBorder
            love.graphics.line(x, 0, x, base.guiHeight)
        end
    love.graphics.setCanvas()

    -- register screens
    local screenManager = ScreenManager()
    screenManager:register('/', LangSwitchScreen)   -- frist
    screenManager:register('MainScreen', MainScreen)

    -- register level
    for i, level in ipairs(LevelScreenList) do
        local levelName = levelString[i]
        screenManager:register(levelName, level)
    end
end