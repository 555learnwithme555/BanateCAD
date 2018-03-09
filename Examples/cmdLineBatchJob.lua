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
	local shadowFactor = 3 -- larger is darker
	local h = outputSize * heightFactor
	local r = ((outputSize * 25.4) / 2) - h
	local t = extrudeSize * shadowFactor --visual map thickness

	local heightmap = ImageSampler({
		Filename = 'Examples/moonBumpPlusVisualMap.png',
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
		USteps = 1440,
		WSteps = 720,
		VertexFunction = dispSampler,
		Thickness = -t,
		ThicknessMap = thicknessMap,
		BasicThickness = -(extrudeSize + 0.1), -- a little bit thicker
	})

	--direct output to STL
	local f = io.open(outputFilename, 'w+')
	local writer = STLASCIIWriter({file = f})
	writer:WriteBiParametric(lshape, "BiParametric")
	f:close()

	collectgarbage();
end

GenerateMoon(2, 'Examples/moonLamp2inches.stl')
GenerateMoon(3, 'Examples/moonLamp3inches.stl')
GenerateMoon(4, 'Examples/moonLamp4inches.stl')
GenerateMoon(5, 'Examples/moonLamp5inches.stl')
GenerateMoon(6, 'Examples/moonLamp6inches.stl')
GenerateMoon(7, 'Examples/moonLamp7inches.stl')
GenerateMoon(8, 'Examples/moonLamp6inches.stl')
GenerateMoon(9, 'Examples/moonLamp9inches.stl')
GenerateMoon(10, 'Examples/moonLamp10inches.stl')
