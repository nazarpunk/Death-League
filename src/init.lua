do
	local InitGlobalsOrigin = InitGlobals
	function InitGlobals()
		InitGlobalsOrigin()
		FogEnable(false)
		FogMaskEnable(false)
		
		for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
			local player = Player(i)
			if GetPlayerController(player) == MAP_CONTROL_USER and GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING then
				local x, y = 0, 0
				local hero = CreateUnit(player, FourCC('hfoo'), x, y, 0)
				if player == GetLocalPlayer() then
					SelectUnit(hero, true)
					PanCameraToTimed(x, y, 0)
				end
			end
		end
		
		print 'Press ESC to test'
		local escTrigger = CreateTrigger()
		TriggerRegisterPlayerEventEndCinematic(escTrigger, Player(0))
		TriggerAddAction(escTrigger, function()
			--BlzSetAbilityResearchExtendedTooltip()
			print 'work'
		end)
	
	end
end