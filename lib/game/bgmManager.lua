local BgmManager = Object:extend()

function BgmManager:new(bgm)
    self.bgm = bgm
    self.turnOn = true
end


function BgmManager:update()
    if Base.isPressed(Base.keys.music) then
        self.turnOn = not self.turnOn
    end

    if self.turnOn then
        if not self.bgm:isPlaying() then
            self.bgm:play()
        end
    else
        if self.bgm:isPlaying() then
            self.bgm:pause()
        end
    end
end


function BgmManager:draw()
    love.graphics.setColor(Base.color.darkGray)
    Base.print('♫', Base.gui.width-Base.gui.border, 0, 'right')
    if not self.turnOn then
        love.graphics.setColor(Base.color.red)
        Base.print('x', Base.gui.width-Base.gui.border, 0, 'right')
    end
end


return BgmManager