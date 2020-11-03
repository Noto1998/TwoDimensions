KeyTips = Object:extend()

local tipsList
local showFlag

function KeyTips:new()
    tipsList = {}
    for i, string in ipairs(lang.ui_key_keyTipsList) do
        table.insert(tipsList, Tips(string, base.guiBorder, base.guiHeight/(#lang.ui_key_keyTipsList+1)*i, 0, "left", "center"))
    end

    showFlag = false
end

function KeyTips:update()
    if base.isPressed(base.keys.keyTips) then
		showFlag = not showFlag
	end
end

function KeyTips:draw()
    if showFlag then
        -- bg
        local c = base.cloneTable(base.cBlack)
        c[4] = 0.75
        love.graphics.setColor(c)
        love.graphics.rectangle("fill", 0, 0, base.guiWidth, base.guiHeight)
        --text
        for i, tips in ipairs(tipsList) do
            tips:draw(0)
        end
    end
end

function KeyTips:getShowFlag()
    return showFlag
end