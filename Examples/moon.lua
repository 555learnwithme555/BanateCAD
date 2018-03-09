local r = 30
local h = 3

heightsampler = ImageSampler({
	Filename='moonBumpMap.png',
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
