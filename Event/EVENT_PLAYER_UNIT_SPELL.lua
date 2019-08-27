do
	--local EventChannelId = GetHandleId(EVENT_PLAYER_UNIT_SPELL_CHANNEL)
	local EventCastId   = GetHandleId(EVENT_PLAYER_UNIT_SPELL_CAST)
	--local EventEffectId  = GetHandleId(EVENT_PLAYER_UNIT_SPELL_EFFECT)
	--local EventEndCastId = GetHandleId(EVENT_PLAYER_UNIT_SPELL_ENDCAST)
	local EventFinishId = GetHandleId(EVENT_PLAYER_UNIT_SPELL_FINISH)
	
	local SpellTrigger  = CreateTrigger()
	for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
		--TriggerRegisterPlayerUnitEvent(SpellTrigger, Player(i), EVENT_PLAYER_UNIT_SPELL_CHANNEL)
		TriggerRegisterPlayerUnitEvent(SpellTrigger, Player(i), EVENT_PLAYER_UNIT_SPELL_CAST)
		--TriggerRegisterPlayerUnitEvent(SpellTrigger, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT)
		--TriggerRegisterPlayerUnitEvent(SpellTrigger, Player(i), EVENT_PLAYER_UNIT_SPELL_ENDCAST)
		TriggerRegisterPlayerUnitEvent(SpellTrigger, Player(i), EVENT_PLAYER_UNIT_SPELL_FINISH)
	end
	TriggerAddAction(SpellTrigger, function()
		local eventId = GetHandleId(GetTriggerEventId())
		local ability = ABILITY_INDEX[GetSpellAbilityId()]
		
		if ability ~= nil then
			if eventId == EventCastId and ability.onCast ~= nil then ability.onCast(GetTriggerUnit())
			elseif eventId == EventFinishId and ability.onFinish ~= nil then ability.onFinish(GetTriggerUnit()) end
		end
		
		--[[Battle Rush if isEventEffect and spellId == ABILITY.BattleRush.id then
			local ability     = ABILITY.BattleRush
			local effect      = AddSpecialEffectTarget('Effect/Ability/BattleRush/Caster.mdx', caster, 'origin')
			local speedInc    = 2000 * TIMER_PERIOD
			local damage      = BlzGetUnitBaseDamage(caster, 1)
			local damageGroup = CreateGroup()
			local range       = GetPlayerAbilityPerkLevel(casterOwner, ability.codename, 1, 1) > 0 and 150 or 75
			
			local isPush      = GetPlayerAbilityPerkLevel(casterOwner, ability.codename, 1, 3) > 0
			local isStun      = GetPlayerAbilityPerkLevel(casterOwner, ability.codename, 2, 2) > 0
			local isKill      = GetPlayerAbilityPerkLevel(casterOwner, ability.codename, 3, 2) > 0
			
			TimerStart(CreateTimer(), TIMER_PERIOD, true, function()
				casterX, casterY = casterX + speedInc * spellAngleCos, casterY + speedInc * spellAngleSin
				
				spellDistance    = spellDistance - speedInc
				
				if spellDistance <= 0 or not InMapXY(casterX, casterY) or not UnitAlive(caster) or not IsTerrainWalkable(casterX + 16 * spellAngleCos, casterY + 16 * spellAngleSin) then
					GroupClear(damageGroup)
					DestroyGroup(damageGroup)
					DestroyEffect(effect)
					
					if UnitAlive(caster) and GetPlayerAbilityPerkLevel(casterOwner, ability.codename, 4, 1) > 0 then
						ABILITY.ShakingBlow.data.Cast(caster, spellAngle, 0)
					end
					return DestroyTimer(GetExpiredTimer())
				end
				
				GroupEnumUnitsInRange(GROUP_ENUM_ONCE, casterX, casterY, range, nil)
				while true do
					target = FirstOfGroup(GROUP_ENUM_ONCE)
					if target == nil then break end
					
					if UnitAlive(target) and IsPlayerEnemy(casterOwner, GetOwningPlayer(target)) then
						if isPush then
							targetX, targetY  = GetUnitX(target), GetUnitY(target)
							
							local targetAngle = AngleBetweenXY(casterX, casterY, targetX, targetY)
							if DistanceBetweenXY(casterX, casterY, targetX, targetY) <= 256 and AngleDifference(spellAngle, targetAngle) < math.pi then
								SetUnitX(target, targetX + speedInc * math.cos(targetAngle))
								SetUnitY(target, targetY + speedInc * math.sin(targetAngle))
							end
						end
						
						if not IsUnitInGroup(target, damageGroup) then
							AddSpecialEffectTargetOnce('Abilities/Weapons/VengeanceMissile/VengeanceMissile.mdl', target, 'chest')
							GroupAddUnit(damageGroup, target)
							if isStun then DummyCastStun(target, 3) end
							if isKill and GetWidgetLife(target) / GetUnitState(target, UNIT_STATE_MAX_LIFE) <= 0.1 then
								SetWidgetLife(target, 1)
								SetUnitExploded(target, true)
							end
							UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_FIRE, WEAPON_TYPE_WHOKNOWS)
							if isKill then SetUnitExploded(target, false) end
						end
					end
					
					GroupAddUnit(damageGroup, target)
					GroupRemoveUnit(GROUP_ENUM_ONCE, target)
				end
				
				SetUnitX(caster, casterX)
				SetUnitY(caster, casterY)
			end)
		end
		--todo добавить способность в общаю таблицу
		if isEventEffect and spellId == FourCC('A000') then
			-- Топот лошади
			local id                 = GetPlayerId(GetOwningPlayer(caster))
			PLAYER[id].RealCDonStomp = BlzGetAbilityCooldown(FourCC('A000'), 0)
			
			TimerStart(CreateTimer(), 1, true, function()
				PLAYER[id].RealCDonStomp = PLAYER[id].RealCDonStomp - 1
				if PLAYER[id].RealCDonStomp <= 0 then
					PauseTimer(GetExpiredTimer())
					DestroyTimer(GetExpiredTimer())
				end
			end)
			--BlzGetUnitAbilityCooldownRemaining
		
		end
		]]
	
	end)
end