local KeyTips = Object:extend()

local tipsList, isShow

function KeyTips:new()

    isShow = false

    tipsList = {}
    local w = Base.gui.height / (#Lang.ui_key_keyTipsList + 1)

    for i, string in ipairs(Lang.ui_key_keyTipsList) do
        table.insert(
            tipsList,
            Tips(string, Base.gui.border, w * i, 0, 'left', 'center')
        )
    end
end

function KeyTips:update()
    if Base.isPressed(Base.keys.keyTips) then
		isShow = not isShow
	end
end

function KeyTips:draw()
    if isShow then
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


---@return boolean
function KeyTips:isShow()
    return isShow
end


return KeyTips