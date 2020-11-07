Rectangle = Shape:extend()

function Rectangle:new(x, y, z, lenX, lenY, dir, cFill, cLine, cMesh)
    Rectangle.super.new(self, x, y, z, cFill, cLine, cMesh)
    self.lenX = lenX
    self.lenY = lenY
    -- dir between 0 ~ -math.pi, so the z alway be bottom
    self.dir = 0
    if dir ~= nil then
        if dir > 0 or dir < -math.pi then
            error('dir, expected 0 to -pi, got ' .. dir)
        end

        self.dir = dir
    end

    -- mesh
    local vertices = {}
    local xy = {
        {self:getX(1), self.y},
        {self:getX(2), self.y},
        {self:getX(2), self.y + self.lenY},
        {self:getX(1), self.y + self.lenY}
    }
    for i, value in ipairs(xy) do
        vertices[i] = {
            value[1], value[2],                                  -- position of the vertex
            value[1]/Base.gui.width, value[2]/Base.gui.height,   -- texture coordinate at the vertex position(0~1)
            1, 1, 1                                              -- color of the vertex
        }
    end
    self.mesh = love.graphics.newMesh(vertices, 'fan')
    self.mesh:setTexture(CANVAS_BG)
end


function Rectangle:draw(mode)
    if mode == 1 then
        love.graphics.setColor(self.cLine)
        love.graphics.line(self:getX(1), self:getZ(1), self:getX(2), self:getZ(2))
    else
        -- fill
        local x1 = self:getX(1)
        local y1 = self.y*(1-mode)
        local x2 = self:getX(2)
        local y2 = (self.y+self.lenY)*(1-mode)
        local _table = {
            x1, y1 + self:getZ(1) * mode,
            x2, y1 + self:getZ(2) * mode,
            x2, y2 + self:getZ(2) * mode,
            x1, y2 + self:getZ(1) * mode,
        }
        love.graphics.setColor(self.cFill)
        love.graphics.polygon('fill', _table)

        -- mesh
        if mode ~= 0 then
            -- update point location
            for i = 2, 4*2, 2 do
                self.mesh:setVertexAttribute(i/2, 1, _table[i-1], _table[i])
            end
        end
        love.graphics.setColor(self.cMesh)
        love.graphics.draw(self.mesh)

        -- line
        love.graphics.setColor(self.cLine)
        love.graphics.polygon('line', _table)
    end
end


function Rectangle:getXByDir()
    return Base.getXYbyDir(self.dir, self.lenX).x
end

function Rectangle:getZByDir()
    return Base.getXYbyDir(self.dir, self.lenX).y
end

function Rectangle:getX(num)
    if num == 1 then
        return self.x
    elseif num == 2 then
        return self.x + self:getXByDir()
    else
        error('expected 1~2, got ' .. num)
    end
end

function Rectangle:getZ(num)
    if num == 1 then
        return self.z
    elseif num == 2 then
        return self.z + self:getZByDir()
    else
        error('expected 1~2, got ' .. num)
    end
end

function Rectangle:getRightX()
	local pointRight = 1
	if self:getX(2) > self:getX(pointRight) then
		pointRight = 2
	end

	return pointRight
end

function Rectangle:getLeftX()
	local pointLeft = 1
	if self:getX(pointLeft) > self:getX(2) then
		pointLeft = 2
	end

	return pointLeft
end

function Rectangle:collisionPointXZ(x, z)
    local checkBorder = 2
    local flag = false
    local absX = math.abs(self:getXByDir())

    for i = 1, absX do
        local oX = self:getX(1) + i * Base.sign(self:getXByDir())
        local oZ = self:getZ(1) + i * (self:getZByDir()/absX)
        if math.abs(x-oX) <= 1 and math.abs(z - oZ) <= checkBorder then
            flag = true
        end
    end

    return flag
end