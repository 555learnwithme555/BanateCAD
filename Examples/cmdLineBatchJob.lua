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
require "Icosahedron"

function GenerateMoon(outputSize, outputName)
	local extrudeSize = 0.4
	local heightFactor = 1.6 -- bump map height factor
	local shadowFactor = 4.8 -- larger is darker
	local refinementLevel = 288 -- output resolution
	local h = outputSize * heightFactor
	local r = ((outputSize * 25.4) / 2) - (h / 2)
	local t = extrudeSize * shadowFactor --color map thickness

	local heightmap = ImageSampler({
		Filename = 'Examples/moonBumpMultiplyColorMap.png',
		-- Blur = 1,
	})

	local thicknessMap = ImageSampler({
		Filename = 'Examples/moonColorMap.png',
		-- Blur = 4, -- smoothen internal surface
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

	local lshape =  Icosahedron({
		RefinementLevel = refinementLevel,
	-- local lshape =  BiParametric({
	-- 	USteps = 1440,
	-- 	WSteps = 720,
		VertexFunction = dispSampler,
		Thickness = -t,
		ThicknessMap = thicknessMap,
		BasicThickness = -(extrudeSize + 0.1), -- a little bit thicker
	})

	--direct output to STL
	local f = io.open('Examples/' .. outputName .. '.stl', 'w+')
	local writer = STLASCIIWriter({file = f})
	writer:WriteBiParametric(lshape, outputName)
	f:close()

	collectgarbage()

	-- local lshape =  Icosahedron({
	-- 	RefinementLevel = refinementLevel,
	-- 	VertexFunction = dispSampler,
	-- })

	-- local f = io.open('Examples/' .. outputName .. 'OuterOnly.stl', 'w+')
	-- local writer = STLASCIIWriter({file = f})
	-- writer:WriteBiParametric(lshape, outputName)
	-- f:close()

	-- collectgarbage()
end

-- GenerateMoon(2, 'moonLamp2inches')
GenerateMoon(3, 'moonLamp3inches')
-- GenerateMoon(4, 'moonLamp4inches')
-- GenerateMoon(5, 'moonLamp5inches')
-- GenerateMoon(6, 'moonLamp6inches')
-- GenerateMoon(7, 'moonLamp7inches')
-- GenerateMoon(8, 'moonLamp8inches')
-- GenerateMoon(9, 'moonLamp9inches')
