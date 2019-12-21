do
	local InitGlobalsOrigin = InitGlobals
	function InitGlobals()
		InitGlobalsOrigin()
		FogEnable(false)
		FogMaskEnable(false)
		MeleeStartingHeroLimit()
	end
end