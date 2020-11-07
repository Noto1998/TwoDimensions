KeyTips = Object:extend()

local tipsList
local showFlag

function KeyTips:new()
    tipsList = {}
    for i, string in ipairs(Lang.ui_key_keyTipsList) do
        table.insert(tipsList, Tips(string, Base.gui.border, Base.gui.height/(#Lang.ui_key_keyTipsList+1)*i, 0, 'left', 'center'))
    end

    showFlag = false
end

function KeyTips:update()
    if Base.isPressed(Base.keys.keyTips) then
		showFlag = not showFlag
	end
end

function KeyTips:draw()
    if showFlag then
        -- bg
        local c = Base.cloneTable(Base.color.black)
        c[4] = 0.75
        love.graphics.setColor(c)
        love.graphics.rectangle('fill', 0, 0, Base.gui.width, Base.gui.height)
        --text
        for i, tips in ipairs(tipsList) do
            tips:draw(0)
        end
    end
end

function KeyTips:getShowFlag()
    return showFlag
end