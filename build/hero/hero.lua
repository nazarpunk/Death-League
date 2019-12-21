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
			local unit   = GetTriggerUnit()
			local unitId = GetUnitTypeId(unit)
			local player = GetOwningPlayer(unit)
			local data   = PLAYER[GetPlayerId(player)]
			-- skill
			if unitId >= SkillId and unitId < SkillId + 4 then
				local num     = unitId - SkillId
				local ability = data.ability[num]
				local level   = GetAbilityCustomLevel(ability) + 1
				SetAbilityCustomLevel(ability, level)
				AddUnitToStock(data.hero, SkillId + num, level, level)
				return RemoveUnit(unit)
			end
			
			-- hero
			if GetPlayerController(player) == MAP_CONTROL_USER and
					GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING and
					IsUnitType(unit, UNIT_TYPE_HERO) and
					not IsUnitIllusion(unit)
			then
				data.hero = unit
				for i = 0, 3 do
					AddUnitToStock(unit, SkillId + i, 1, 1)
				end
				for i = 0, 8 do
					local ability = BlzGetUnitAbilityByIndex(unit, i)
					if BlzGetAbilityIntegerField(ability, ABILITY_IF_BUTTON_POSITION_NORMAL_Y) == 2 then
						BlzSetAbilityIntegerField(ability, ABILITY_IF_BUTTON_POSITION_ACTIVATED_X, 300)
						data.ability[BlzGetAbilityIntegerField(ability, ABILITY_IF_BUTTON_POSITION_NORMAL_X)] = ability
						SetAbilityCustomLevel(ability, 1)
					end
				end
				
				if GetLocalPlayer() == player then
					SelectUnit(unit, true)
					PanCameraToTimed(GetUnitX(unit), GetUnitY(unit), 0)
				end
				return
			end
		end)
		
		-- hero level
		local heroLevelTrigger = CreateTrigger()
		for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
			TriggerRegisterPlayerUnitEvent(heroLevelTrigger, Player(i), EVENT_PLAYER_HERO_LEVEL, nil)
		end
		TriggerAddAction(heroLevelTrigger, function()
			local unit   = GetTriggerUnit()
			local player = GetOwningPlayer(unit)
			if GetPlayerController(player) == MAP_CONTROL_USER and
					GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING and
					IsUnitType(unit, UNIT_TYPE_HERO)
			then
				SetPlayerState(player, PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(player, PLAYER_STATE_RESOURCE_LUMBER) + 1)
				SetWidgetLife(unit, GetUnitState(unit, UNIT_STATE_MAX_LIFE))
				SetUnitState(unit, UNIT_STATE_MANA, GetUnitState(unit, UNIT_STATE_MAX_MANA))
				UnitResetCooldown(unit)
			end
		end)
		
		-- chat
		local chatTrigger = CreateTrigger()
		for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
			TriggerRegisterPlayerChatEvent(chatTrigger, Player(i), '-', false)
		end
		TriggerAddAction(chatTrigger, function()
			local param = {}
			for w in GetEventPlayerChatString():gmatch('[^%%s]+') do
				table.insert(param, w)
			end
			local hero = PLAYER[GetPlayerId(GetTriggerPlayer())].hero
			if param[1] == '-level' then
				local current = GetHeroLevel(hero)
				local max     = param[2] == nil and current + 1 or tonumber(param[2])
				if max > current then
					for i = current, max do
						SetHeroLevel(hero, i, true)
					end
				else
					SetHeroLevel(hero, max, true)
				end
			
			elseif param[1] == '-kill' then
				if UnitAlive(hero) then KillUnit(hero) end
			elseif param[1] == '-revive' then
				if not UnitAlive(hero) then ReviveHero(hero, GetUnitX(hero), GetUnitY(hero), true) end
			end
		end)
		
		-- create test unit
		CreateUnit(Player(0), FourCC('Hpal'), 0, 0, 0)
		SetPlayerState(Player(0), PLAYER_STATE_RESOURCE_LUMBER, 300)
	end
end
