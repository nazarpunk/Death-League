do
	local InitGlobalsOrigin = InitGlobals
	function InitGlobals()
		InitGlobalsOrigin()
		
		do
			local dummy  = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), FourCC('dumy'), 0, 0, 0)
			local stunId = FourCC('stun')
			UnitAddAbility(dummy, stunId)
			local stunAbility = BlzGetUnitAbility(dummy, stunId)
			
			---@param target unit
			---@param durationNormal real
			---@param durationHero real
			function DummyCastStun(target, durationNormal, durationHero)
				SetUnitX(dummy, GetUnitX(target))
				SetUnitY(dummy, GetUnitY(target))
				BlzSetAbilityRealLevelField(stunAbility, ABILITY_RLF_DURATION_NORMAL, 0, durationNormal)
				BlzSetAbilityRealLevelField(stunAbility, ABILITY_RLF_DURATION_HERO, 0, durationHero)
				IssueTargetOrderById(dummy, 852095, target) -- thunderbolt
			end
		end
		
		do
			local dummys      = {}
			local rootAbility = {}
			local rootId      = FourCC('root')
			for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
				dummys[i] = CreateUnit(Player(i), FourCC('dumy'), 0, 0, 0)
				UnitAddAbility(dummys[i], rootId)
				rootAbility[i] = BlzGetUnitAbility(dummys[i], rootId)
			end
			
			---@param player player
			---@param target unit
			---@param durationNormal real
			---@param durationHero real
			function DummyCastRoot(player, target, durationNormal, durationHero, damage)
				local id      = GetPlayerId(player)
				local dummy   = dummys[id]
				local ability = rootAbility[id]
				
				SetUnitX(dummy, GetUnitX(target))
				SetUnitY(dummy, GetUnitY(target))
				BlzSetAbilityRealLevelField(ability, ABILITY_RLF_DURATION_NORMAL, 0, durationNormal)
				BlzSetAbilityRealLevelField(ability, ABILITY_RLF_DURATION_HERO, 0, durationHero)
				BlzSetAbilityRealLevelField(ability, ABILITY_RLF_DAMAGE_PER_SECOND_EER1, 0, damage)
				UnitShareVision(target, player, true)
				IssueTargetOrderById(dummy, 852171, target) -- entanglingroots
				UnitShareVision(target, player, false)
			end
		end
	end
end