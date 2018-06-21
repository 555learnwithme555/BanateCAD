local gd = require("gd")

local class = require "pl.class"

class.ImageSampler();

function ImageSampler:_init(params)
	params = params or {}

	self.Image = params.Image or nil
	self.Blur = params.Blur or nil

	if params.Image == nil then
		self.Filename = params.Filename or nil

		-- Need to load the image data
		-- Assume a .png file for now
		self.Image = gd.createFromPng(self.Filename)
	end


	if self.Image == nil then return nil end

	self.Width, self.Height = self.Image:sizeXY()
	self.Size = params.Size
	self.Resolution = params.Resolution
	self.MaxHeight = params.MaxHeight or 1
end

function ImageSampler.GetColor(self, u, w)
	local width,height = self.Image:sizeXY()
	-- calculate pixel coordinates
	local x = math.floor(u*(width-1))
	local y = math.floor((height-1)-(w*(height-1)))

	local pixel = self.Image:getPixel(x,y)
	local r = self.Image:red(pixel)
	local g = self.Image:green(pixel)
	local b = self.Image:blue(pixel)
	if self.Blur ~= nil then
		local i = 1
		for dx = x - self.Blur, x + self.Blur do
			if (dx >= 0) and (dx < width) then
				for dy = y - self.Blur, y - self.Blur do
					if (dy >= 0) and (dy < height) then
						pixel = self.Image:getPixel(dx, dy)
						r = r + self.Image:red(pixel)
						g = g + self.Image:green(pixel)
						b = b + self.Image:blue(pixel)
						i = i + 1
					end
				end
			end
		end
		r = r / i
		g = g / i
		b = b / i
	end

	return {r/255,g/255,b/255,1}
end

function luminance(rgb)
	local lum = vec3_dot({0.2125, 0.7154, 0.0721}, rgb);
	return lum;
end

function ImageSampler.GetHeight(self, u, w)
	local col = self:GetColor(u,w)

	-- Turn it to a grayscale value
	local height = luminance(col)

	return height
end

function ImageSampler.GetVertex(self, u, w)
	-- Turn it to a grayscale value
	local height = self:GetHeight(u, w)

	local x = u*self.Size[1]
	local y = w*self.Size[2]
	local z = height*self.MaxHeight
	local vert = {x,y,z}

	return vert, {0,0,1}
end

--[[
--local is = ImageSampler:new({Filename='profile_80_60.png'})
local is = ImageSampler:new({Filename='profile_1024_768.png'})

c = is:GetColor(0.5,0.5)
vec3_print_tuple(c)
--]]
