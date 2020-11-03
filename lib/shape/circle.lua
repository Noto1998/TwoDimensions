Circle = Shape:extend()

function Circle:new(x, y, z, radius, cFill, cLine, cMesh)
    Circle.super.new(self, x, y, z, cFill, cLine, cMesh)
	self.radius = radius
end

function Circle:draw(mode)
	-- mode from 0 to 1
	if mode == 0 then
		love.graphics.setColor(self.cFill)
		love.graphics.circle("fill" , self.x, self.y, self.radius)
		love.graphics.setColor(self.cLine)
		love.graphics.circle("line" , self.x, self.y, self.radius)
	elseif mode == 1 then
		love.graphics.setColor(self.cLine)
		love.graphics.line(self.x - self.radius, self.z, self.x + self.radius, self.z)
	else
		local _x = self.x
		local _y = self.y + (-self.y+self.z) * mode
		local _rX = self.radius
		local _rY = self.radius * (1 - mode)
		
		love.graphics.setColor(self.cFill)
		love.graphics.ellipse("fill", _x, _y, _rX, _rY)
		love.graphics.setColor(self.cLine)
		love.graphics.ellipse("line", _x, _y, _rX, _rY)
	end
end