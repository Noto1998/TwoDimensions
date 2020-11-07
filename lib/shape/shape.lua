Shape = Object:extend()

function Shape:new(x, y, z, cFill, cLine, cMesh)
    self.x = x
    self.y = y
    self.z = z

    -- fill
    self.cFill = Base.color.fill
	if cFill ~= nil then
		self.cFill = cFill
    end
    -- line
	self.cLine = Base.color.line
	if cLine ~= nil then
		self.cLine = cLine
    end
    -- mesh
    self.cMesh = Base.color.white
	if cMesh ~= nil then
        self.cMesh = cMesh
    end
end