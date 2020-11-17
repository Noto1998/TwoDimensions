---@class Rect : Shape
local Rect = Shape:extend()

local function getVertices(self)
    local vertices = {}
    local xyTable = {
        {self:getPointX(1), self.position.y},
        {self:getPointX(2), self.position.y},
        {self:getPointX(2), self.position.y + self.lenY},
        {self:getPointX(1), self.position.y + self.lenY}
    }
    for i, value in ipairs(xyTable) do

        local x = value[1]
        local y = value[2]

        vertices[i] = {
            x, y,                                    -- position of the vertex
            x / Base.gui.width, y / Base.gui.height, -- texture coordinate at the vertex position(0~1)
            1, 1, 1                                  -- color of the vertex
        }
    end

    return vertices
end

local function initMesh(self)
    local vertices = getVertices(self)
    local mesh = love.graphics.newMesh(vertices, 'fan')
    mesh:setTexture(CANVAS_BG)

    return mesh
end


function Rect:new(position, lenX, lenY, radian, colorFill, colorLine, colorMesh)
    Rect.super.new(self, position, colorFill, colorLine, colorMesh)

    self.lenX = lenX
    self.lenY = lenY
    self.radian = Base.ternary(radian ~= nil,   radian,     0)
    self.mesh = initMesh(self)

    if radian > 0 or radian < -math.pi then
        error('radian expected 0 ~ -pi, got ' .. radian .. ' in ' .. self)
    end
end


function Rect:draw(mode)

    if mode == 1 then
        love.graphics.setColor(self.colorLine)
        love.graphics.line(self:getPointX(1), self:getPointZ(1), self:getPointX(2), self:getPointZ(2))
    else
        -- draw fill
        local x1 = self:getPointX(1)
        local y1 = self.position.y * (1 - mode)
        local x2 = self:getPointX(2)
        local y2 = (self.position.y + self.lenY) * (1 - mode)
        local xyTable = {
            x1, y1 + self:getPointZ(1) * mode,
            x2, y1 + self:getPointZ(2) * mode,
            x2, y2 + self:getPointZ(2) * mode,
            x1, y2 + self:getPointZ(1) * mode,
        }
        love.graphics.setColor(self.colorFill)
        love.graphics.polygon('fill', xyTable)

        -- update mesh position
        if mode ~= 0 then
            for i = 1, 4 do
                local x = xyTable[i * 2 - 1]
                local y = xyTable[i * 2]
                self.mesh:setVertexAttribute(i, 1, x, y)
            end
        end

        -- draw mesh
        love.graphics.setColor(self.colorMesh)
        love.graphics.draw(self.mesh)

        -- draw line
        love.graphics.setColor(self.colorLine)
        love.graphics.polygon('line', xyTable)
    end
end


--- get LenX between Points
---@return number x
function Rect:getVectorX()
    return Base.getVector(self.radian, self.lenX).x
end


--- get LenZ between Points
---@return number z
function Rect:getVectorZ()
    return Base.getVector(self.radian, self.lenX).y
end


---@param index number
---@return number pointX
function Rect:getPointX(index)
    if index == 1 then
        return self.position.x
    elseif index == 2 then
        return self.position.x + self:getVectorX()
    else
        error('index expected 1 or 2, got ' .. index .. ' in ' .. self)
    end
end


---@param index number
---@return number pointZ
function Rect:getPointZ(index)

    if index == 1 then
        return self.position.z
    elseif index == 2 then
        return self.position.z + self:getVectorZ()
    else
        error('index expected 1 or 2, got ' .. index .. ' in ' .. self)
    end
end


---@param string string
---@return number index
function Rect:getPointIndex(string)

    local x1 = self:getPointX(1)
    local x2 = self:getPointX(2)

    if string == 'left' then
        return Base.ternary(x1 < x2, 1, 2)
    elseif string == 'right' then
        return Base.ternary(x1 > x2, 1, 2)
    else
        error('expected \'left\' or \'right\', got ' .. string .. ' in ' .. self)
    end
end


---@return number
function Rect:getDistance()
    return self.lenX
end


---@param pointX number
---@param pointZ number
---@return boolean
function Rect:isCollisionPointInXZ(pointX, pointZ)
    local x = self:getPointX(1)
    local z = self:getPointZ(1)
    local len = self:getDistance()
    local checkBorder = 2-- todo:why?

    return Base.isLineWithPoint(x, z, self.radian, len, pointX, pointZ, nil, checkBorder)
end


function Rect:updateVertices()
    local vertices = getVertices(self)
    self.mesh:setVertices(vertices)
end


return Rect