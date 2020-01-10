do
	local InitGlobalsOrigin = InitGlobals
	function InitGlobals()
		InitGlobalsOrigin()
		print 'Тестим pfvtye'
		FogEnable(false)
		FogMaskEnable(false)
		MeleeStartingHeroLimit()
	end
end