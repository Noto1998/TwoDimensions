---@class Shape
local Shape = Object:extend()

---@param x number
---@param y number
---@param z number
---@param cFill ColorType
---@param cLine ColorType
---@param cMesh ColorType
function Shape:new(x, y, z, cFill, cLine, cMesh)
    self.position = Base.createPosition(x, y, z)

    self.cFill = Base.ternary(cFill ~= nil,     cFill,      Base.color.fill)
    self.cLine = Base.ternary(cLine ~= nil,     cLine,      Base.color.line)
    self.cMesh = Base.ternary(cMesh ~= nil,     cMesh,      Base.color.white)
end

---@param position PositionType
---@param cFill ColorType
---@param cLine ColorType
---@param cMesh ColorType
function Shape:new(position, cFill, cLine, cMesh)
    Shape:new(position.x, position.y, position.z, cFill, cLine, cMesh)
end

return Shape