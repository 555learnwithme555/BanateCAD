local r = 36.1 -- 3 inches
--local r = 48.8 -- 4 inches
--local r = 61.5 -- 5 inches
--local r = 74.2 -- 6 inches
--local r = 86.9 -- 7 inches
--local r = 99.6 -- 8 inches
--local r = 112.3 -- 9 inches
--local r = 125.0 -- 10 inches
--local r = 137.7 -- 11 inches
--local r = 150.4 -- 12 inches

local h = 2 --bump map height
local t = 2 --visual map thickness
local mt = 0.4 --minimum thickness (extrude size)

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
	USteps = 720,
	WSteps = 360,
    VertexFunction = dispSampler,
	Thickness = -t,
	ThicknessMap = thicknessMap,
	MinThickness = -mt,
	})

addshape(lshape)