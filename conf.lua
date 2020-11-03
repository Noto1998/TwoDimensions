function love.conf(t)
    --t.version = "11.2"                  -- The LÖVE version this game was made for (string)
    t.window.title = "Two Dimensions"
    t.window.width = 320
    t.window.height = 240

    t.modules.mouse = false
    t.modules.touch = false

    t.accelerometerjoystick = false     -- false, because Gameshell doesn't have a accelerometer
end