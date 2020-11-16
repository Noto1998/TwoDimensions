---@class Shape
local Shape = Object:extend()

---@param position PositionType
---@param colorFill ColorType
---@param colorLine ColorType
---@param colorMesh ColorType
function Shape:new(position, colorFill, colorLine, colorMesh)
    self.position = Base.cloneTable(position)

    self.colorFill = Base.ternary(colorFill ~= nil,     colorFill,      Base.color.fill)
    self.colorLine = Base.ternary(colorLine ~= nil,     colorLine,      Base.color.line)
    self.colorMesh = Base.ternary(colorMesh ~= nil,     colorMesh,      Base.color.white)
end

return Shape