require "maths"

local class = require "pl.class"

class.ShapeBuilder()

ShapeBuilder.POINTS = 1
ShapeBuilder.LINES = 2
ShapeBuilder.TRIANGLES = 3
ShapeBuilder.TRIANGLE_STRIP = 4
ShapeBuilder.TRIANGLE_FAN = 5
ShapeBuilder.QUADS = 6
ShapeBuilder.QUAD_STRIP = 7
ShapeBuilder.CLOSE = 8


function ShapeBuilder:_init(figType)
	self.Vertices = {}
	self.FigureType = figType or ShapeBuilder.CLOSE;
end

function ShapeBuilder:Render(graphPort)
	if self.FigureType == ShapeBuilder.CLOSE then
		graphPort:DrawPolygon(self.Vertices)
	elseif self.FigureType == ShapeBuilder.LINES then
		local lastPt = self.Vertices[1]
		for i=2,#self.Vertices do
			local currentPt = self.Vertices[i]
			graphPort:DrawLine(lastPt[1], lastPt[2], currentPt[1], currentPt[2])
			lastPt = currentPt;
		end
	elseif self.FigureType == ShapeBuilder.POINTS then
		for i=1,#self.Vertices do
			local currentPt = self.Vertices[i]
			graphPort:DrawPoint(currentPt[1], currentPt[2]);
		end
	elseif self.FigureType == ShapeBuilder.TRIANGLES then
	elseif self.FigureType == ShapeBuilder.TRIANGLE_STRIP then
	elseif self.FigureType == ShapeBuilder.TRIANGLE_FAN then
	elseif self.FigureType == ShapeBuilder.QUADS then
	elseif self.FigureType == ShapeBuilder.QUAD_STRIP then
	end
end

function ShapeBuilder.Close(self, figType)
	self.FigureType = figType
end

function ShapeBuilder.AddVertex(self, vtx)
	table.insert(self.Vertices, Point3D(vtx))
end

function ShapeBuilder.Bezier(self, p1, p2, p3)
	-- If there isn't already a starting point,
	-- then add one
	local p0 = {0,0,0}
	if #self.Vertices < 1 then
		self:AddVertex(p0)
	else
		p0 = self.Vertices[#self.Vertices]
	end


	local pts = {p0, p1, p2, p3}

	local curveSteps = 30;


	local cv4 = cubic_vec3_to_cubic_vec4(pts);

	for i=0, curveSteps do
		local u = i/curveSteps;
		local cpt = bezier_eval(u, cv4);
		self:AddVertex(cpt)
	end
end

function ShapeBuilder.Bezier2(self, p1, p2)
	-- If there isn't already a starting point,
	-- then add one
	local p0 = {0,0,0}
	if #self.Vertices < 1 then
		self:AddVertex(p0)
	else
		p0 = self.Vertices[#self.Vertices]
	end


	local pts = {p0, p1, p1, p2}

	local curveSteps = 30;


	local cv4 = cubic_vec3_to_cubic_vec4(pts);

	for i=0, curveSteps do
		local u = i/curveSteps;
		local cpt = bezier_eval(u, cv4);
		self:AddVertex(cpt)
	end
end

function ShapeBuilder.LineTo(self, pt1)
	local p0 = {0,0,0}
	if #self.Vertices < 1 then
		self:AddVertex(pt0)
	else
		p0 = self.Vertices[#self.Vertices]
	end

	self:AddVertex(pt1)
end