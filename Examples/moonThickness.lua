local r = 30
local h = 2
local t = 2
local mt = 0.4

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
	USteps = 800,
	WSteps = 400,
    VertexFunction = dispSampler,
	Thickness = -t,
	ThicknessMap = thicknessMap,
	MinThickness = -mt,
	})

addshape(lshape)
