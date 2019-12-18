do
	local InitGlobalsOrigin = InitGlobals
	function InitGlobals()
		InitGlobalsOrigin()
		FogEnable(false)
		FogMaskEnable(false)
	
	
	end
end