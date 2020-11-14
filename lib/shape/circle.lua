local Circle = Shape:extend()

function Circle:new(x, y, z, radius, colorFill, colorLine, colorMesh)
	Circle.super.new(self, x, y, z, colorFill, colorLine, colorMesh)

	self.radius = radius
end

function Circle:draw(mode)

	if mode == 0 then
		love.graphics.setColor(self.colorFill)
		love.graphics.circle('fill' , self.position.x, self.position.y, self.radius)

		love.graphics.setColor(self.colorLine)
		love.graphics.circle('line' , self.position.x, self.position.y, self.radius)
	elseif mode == 1 then
		love.graphics.setColor(self.colorLine)
		love.graphics.line(self.position.x - self.radius, self.position.z, self.position.x + self.radius, self.position.z)
	else
		local x1 = self.position.x
		local y1 = self.position.y + (-self.position.y + self.position.z) * mode
		local x2 = self.radius
		local y2 = self.radius * (1 - mode)

		love.graphics.setColor(self.colorFill)
		love.graphics.ellipse('fill', x1, y1, x2, y2)

		love.graphics.setColor(self.colorLine)
		love.graphics.ellipse('line', x1, y1, x2, y2)
	end
end

return Circle