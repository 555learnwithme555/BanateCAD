local r = 30
local h = 5

local heightsampler = ImageSampler({
	Filename='moonInteriorMap.png',
})

local vertsampler = shape_ellipsoid({
	XRadius = r,
	ZRadius = r,
	MaxTheta = math.rad(360),
	MaxPhi = math.rad(180),
})

local dispSampler = DisplacementSampler({
	VertexSampler = vertsampler,
	HeightSampler = heightsampler,
	MaxHeight = h,
})

local lshape =  BiParametric({
	USteps = 720,
	WSteps = 360,
	VertexFunction=dispSampler,
	})

addshape(lshape)

heightsampler = ImageSampler({
	Filename='moonSurfaceMap.png',
})

vertsampler = shape_ellipsoid({
	XRadius = r,
	ZRadius = r,
	MaxTheta = math.rad(360),
	MaxPhi = math.rad(180),
})

dispSampler = DisplacementSampler({
	VertexSampler = vertsampler,
	HeightSampler = heightsampler,
	MaxHeight = h,
})

lshape =  BiParametric({
	USteps = 720,
	WSteps = 360,
	VertexFunction=dispSampler,
	})

addshape(lshape)