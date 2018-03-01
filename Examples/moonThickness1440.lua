local outputSize = 3 -- inches
local extrudeSize = 0.4

local heightFactor = 1 -- bump map height factor
local h = outputSize * heightFactor
local r = ((outputSize * 25.4) / 2) - h
local t = 2 --visual map thickness

local heightmap = ImageSampler({
	Filename = 'moonBumpMap.png',
})

local thicknessMap = ImageSampler({
	Filename = 'moonInvertedVisualMap.png',
})

local vertsampler = shape_ellipsoid({
	XRadius = r,
	ZRadius = r,
	MaxTheta = math.rad(360),
	MaxPhi = math.rad(180),
})

local dispSampler = DisplacementSampler({
	VertexSampler = vertsampler,
	HeightSampler = heightmap,
	MaxHeight = h,
})

local lshape =  BiParametric({
	USteps = 1440,
	WSteps = 720,
    VertexFunction = dispSampler,
	Thickness = -t,
	ThicknessMap = thicknessMap,
	BasicThickness = -extrudeSize,
	})

--direct output to STL
local f= io.open('moonThickness1440.stl', 'w+')
local writer = STLASCIIWriter({file = f})
writer:WriteBiParametric(lshape, "BiParametric")

--not enough memory to rendering
--addshape(lshape)