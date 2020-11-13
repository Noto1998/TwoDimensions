---@class Shape
local Shape = Object:extend()

---@param x number
---@param y number
---@param z number
---@param colorFill ColorType
---@param colorLine ColorType
---@param colorMesh ColorType
function Shape:new(x, y, z, colorFill, colorLine, colorMesh)
    self.position = Base.createPosition(x, y, z)

    self.colorFill = Base.ternary(colorFill ~= nil,     colorFill,      Base.color.fill)
    self.colorLine = Base.ternary(colorLine ~= nil,     colorLine,      Base.color.line)
    self.colorMesh = Base.ternary(colorMesh ~= nil,     colorMesh,      Base.color.white)
end

--[[
---@param position PositionType
---@param colorFill ColorType
---@param colorLine ColorType
---@param colorMesh ColorType
function Shape:new(position, colorFill, colorLine, colorMesh)
    Shape:new(position.x, position.y, position.z, colorFill, colorLine, colorMesh)
end
]]

return Shape