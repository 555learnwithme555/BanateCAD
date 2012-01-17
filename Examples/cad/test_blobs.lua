--someballs  = {{-10, -13, 0, 5},{10, -13, 0, 5}, {-2, 11, 0, 5},{-2, 11, 5, 3}}
--someballs  = {{-10, -13, 0, 5},{10, -13, 0, 5}, {-2, 11, 0, 5},{-2, 11, 5, 3},{-2, 18, 7, 2}}
--someballs  = {{-8, -13, 0, 5}, {10, -13, 0, 5}}
local someballs = {{-10, -13, 0, 5}, {10, -13, 0, 5}, {-2, 11, 0, 5}}

function balls()
	color(crayola.rgba("Yellow", 1))
	blobs(someballs, 100, 18, 18)
end

function peanut()
	local pballs = {{0, -2, -13,4}, {0,0,0,3}, {0, 1, 14, 4}}

	local texturesampler = ImageSampler.new({
		Filename='PeanutTexture_200_200.png',
		Size = size,
		Resolution = res,
		MaxHeight=16,
	})

	local heightsampler = ImageSampler.new({
		Filename='PeanutTexture_200_200.png',
		Size = {200,200},
		Resolution = {1,1},
		MaxHeight=16,
	})

	local vertsampler = shape_metaball.new({
		balls = pballs,
		radius = 60,
		stacksteps = 60,
		anglesteps = 60,

		USteps = 200,
		WSteps = 200,
		ColorSampler = texturesampler,
--		VertexFunction = nil,
--		Thickness = -1,
	})

	local dispSampler = DisplacementSampler.new({
			VertexSampler = vertsampler,
			HeightSampler = heightsampler,
			MaxHeight = 4,
		})

	local lshape =  BiParametric.new({
		USteps = 200,
		WSteps = 200,
		ColorSampler = texturesampler,
		VertexFunction=dispSampler,
		--Thickness = -2,
		})

	addshape(lshape)

--[[
	local apeanut = shape_metaball.new({
		balls = pballs,
		radius = 60,
		stacksteps = 60,
		anglesteps = 60,

		USteps = 200,
		WSteps = 200,
		ColorSampler = texturesampler,
--		VertexFunction = nil,
--		Thickness = -1,
	})

	color(crayola.rgb("Purple"))
	for _,v in ipairs(pballs) do
		translate(v)
		sphere(v[4])
	end

	color(crayola.rgba("Almond", 0.65))
	addmesh(apeanut:GetMesh())
--]]


end

function boundingballs()
	local blobula = shape_metaball.new({
		balls = someballs,
		radius = 60,
		stacksteps = 180,
		anglesteps = 180,
	})

print(blobula.anglesteps, blobula.stacksteps)

	addmesh(blobula:GetMesh())

	local bounds = blobula.Bounds

	addshape(bounds)
end

function fingers()

-- Some 'fingers'
-- finger1
seg1 = {{0, -10, 0, 3}, {0, 0, 0, 3}}
seg2 = {{0, 0, 0, 3}, {0, 10, 3, 3}}

-- Show the influencing balls
color(crayola.rgb("Purple"))
for _,v in ipairs(seg1) do
	translate(v)
	sphere(2)
end

color(crayola.rgb("Purple"))
for _,v in ipairs(seg2) do
	translate(v)
	sphere(2)
end

	local radius = 100
	local beamsteps = 300
	color(crayola.rgba("Flesh", 0.65))
	blobs(seg1, radius, 30, 30, beamsteps)

	--color(crayola.rgba("Yellow", 0.65))
	blobs(seg2, radius, 30, 30, beamsteps)
end

local triballs = {
	{-10,-5,12,5},		-- eye
	{10,-5,12,5},		-- eye

	--{0,10,0,5},
	{0,-30,0,5},		-- snout

	{0,0,5,5}
	}

function tripod()
	local radius = 30
	local beamsteps = 300

	color(crayola.rgb("Purple"))
	for _,v in ipairs(triballs) do
		translate(v)
		sphere(v[4])
	end

	color(crayola.rgba("Asparagus", 0.75))
	blobs(triballs, radius, 180, 180, beamsteps)
end

function deciballs(theballs)
	searchvolume = {60,80,60}	-- Describes the search volume.  
	resolution = {2,2,2}			-- How many blocks per unit of measure
	dotradius = 1/resolution[1]	-- The size of each of the blocks

	for v in IterateMetaballs(theballs, searchvolume, resolution) do
		color({v[1]/30,v[2]/10,v[3]/20,1})	-- Create some interesting color
		translate(v)
		--tetrahedron(dotradius)
		hexahedron(dotradius)	-- This sould be 1/resolution for a water tight print
	end
end



--fingers()
--balls()
--tripod()
--deciballs(triballs)
--boundingballs()
peanut()