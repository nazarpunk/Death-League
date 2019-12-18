do
	local InitGlobalsOrigin = InitGlobals
	function InitGlobals()
		InitGlobalsOrigin()
		local SkillId            = FourCC('aup1')
		
		-- enter map
		local enterRegionTrigger = CreateTrigger()
		local mapRegion          = CreateRegion()
		RegionAddRect(mapRegion, bj_mapInitialPlayableArea)
		TriggerRegisterEnterRegion(enterRegionTrigger, mapRegion, nil)
		TriggerAddAction(enterRegionTrigger, function()
			local unit     = GetTriggerUnit()
			local unitId   = GetUnitTypeId(unit)
			local player   = GetOwningPlayer(unit)
			local playerId = GetPlayerId(player)
			-- skill
			if unitId >= SkillId and unitId < SkillId + 4 then
				local num = unitId - SkillId + 1
				print(playerId, num)
				return RemoveUnit(unit)
			end
			
			-- hero
			if GetPlayerController(player) == MAP_CONTROL_USER and
					GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING and
					IsUnitType(unit, UNIT_TYPE_HERO) and
					not IsUnitIllusion(unit)
			then
				PLAYER.hero = unit
				for i = 0, 3 do
					AddUnitToStock(unit, SkillId + i, 3, 3)
				end
				for i = 0, 8 do
					local ability = BlzGetUnitAbilityByIndex(unit, i)
					print(i,
					      ability,
					      BlzGetAbilityIntegerField(ability, ABILITY_IF_BUTTON_POSITION_NORMAL_X),
					      BlzGetAbilityIntegerField(ability, ABILITY_IF_BUTTON_POSITION_NORMAL_Y)
					)
				end
				
				if GetLocalPlayer() == player then
					SelectUnit(unit, true)
					PanCameraToTimed(GetUnitX(unit), GetUnitY(unit), 0)
				end
				return
			end
		end)
		
		-- create test unit
		CreateUnit(Player(0), FourCC('Hpal'), 0, 0, 0)
	end
end
