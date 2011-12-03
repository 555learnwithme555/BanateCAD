require ("BiParametric")

shape_heart = inheritsFrom(BiParametric)
function shape_heart.new(params)
	local new_inst = shape_heart.create()
	new_inst:Init(params)

	return new_inst
end

-- USteps
-- WSteps
-- XRadius
-- YRadius
function shape_heart.Init(self, params)
	params = params or {}

	self:superClass():Init(params)

	self.Radius = params.Radius or 1

	self.ParamFunction = self

	return self
end

function shape_heart.GetVertex(self, u,w)
	local theta = w*math.pi*2
	local phi = u*math.pi*2

	-- First, get the point along the outline path
	-- we'll use these as the center points of the curve
	cx=16*math.pow(math.sin(theta),3)
	cy=13*math.cos(theta)-5*math.cos(2*theta)-2*math.cos(3*theta)-math.cos(4*theta)

	-- Then calculate the points along the perimeter of
	-- the outlining curve, in this case a circle
	x = self.Radius * math.cos(phi)
	y = cy
	z = self.Radius * math.sin(phi)

	-- Finally, rotate the profile point by the
	-- outline angle
	r = math.sqrt(x*x+z*z)
	x = x*math.cos(theta+math.rad(90))+cx
	y = x*math.cos(theta+math.rad(90))+cy

	return {x,y,z}
end


--[[
heart = shape_heart.new({
	USteps = 10,
	WSteps = 38,
	Radius = 1
	})


verts = heart:GetVertices()

for _,v in ipairs(verts) do
	--translate(v)
	--tetrahedron()
	print(v)
end
--]]