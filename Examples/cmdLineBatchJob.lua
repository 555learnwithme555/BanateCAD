require "BAppContext"
local appctx = BAppContext({
	Modules={
		"physics",
		"animation",
		"codec",		-- Coder/Decoder for files
		"BanateCAD",	-- For BanateCAD specifics
		"UI",
		"Solids",
		"core",			-- Guts of the system
		}
	})
require "BCADLanguage"

function GenerateMoon(outputSize, outputFilename)
	local extrudeSize = 0.4
	local heightFactor = 1.5 -- bump map height factor
	local h = outputSize * heightFactor
	local r = ((outputSize * 25.4) / 2) - h
	local t = extrudeSize * 6 --visual map thickness

	local heightmap = ImageSampler({
		Filename = 'Examples/moonBumpMap.png',
	})

	local thicknessMap = ImageSampler({
		Filename = 'Examples/moonInvertedVisualMap.png',
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
		BasicThickness = -(extrudeSize + 0.1), -- a little bit thicker
		})

	--direct output to STL
	local f= io.open(outputFilename, 'w+')
	local writer = STLASCIIWriter({file = f})
	writer:WriteBiParametric(lshape, "BiParametric")
end

GenerateMoon(2, 'Examples/moon2inches.stl')
GenerateMoon(3, 'Examples/moon3inches.stl')
GenerateMoon(4, 'Examples/moon4inches.stl')
GenerateMoon(5, 'Examples/moon5inches.stl')
GenerateMoon(6, 'Examples/moon6inches.stl')
GenerateMoon(7, 'Examples/moon7inches.stl')
GenerateMoon(8, 'Examples/moon6inches.stl')
GenerateMoon(9, 'Examples/moon9inches.stl')
GenerateMoon(10, 'Examples/moon10inches.stl')
