--CUSTOM_CODE
---@param x real
do
do
	local InitGlobalsOrigin = InitGlobals
	function InitGlobals()
		InitGlobalsOrigin()
		FogEnable(false)
		FogMaskEnable(false)
	
	
	end
end
--CUSTOM_CODE