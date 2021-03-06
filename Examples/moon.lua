local r = 30 -- radius
local h = 3 -- height

local heightsampler = ImageSampler({
	Filename = 'moonBumpMap.png',
})

-- optional
local colorsampler = ImageSampler({
	Filename = 'moonColorMap.png',
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
	VertexFunction = dispSampler,
	ColorSampler = colorsampler, -- optional
})

addshape(lshape)
