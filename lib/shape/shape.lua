Shape = Object:extend()

function Shape:new(x, y, z, cFill, cLine, cMesh)
    self.x = x
    self.y = y
    self.z = z
    
    -- fill
    self.cFill = Base.cFill
	if cFill ~= nil then
		self.cFill = cFill
    end
    -- line
	self.cLine = Base.cLine
	if cLine ~= nil then
		self.cLine = cLine
    end
    -- mesh
    self.cMesh = Base.cWhite
	if cMesh ~= nil then
        self.cMesh = cMesh
    end
end