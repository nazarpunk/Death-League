ABILITY.ShakingBlow = {
	id       = FourCC('AShB'),
	onFinish = function(caster)
		local angle    = math.rad(GetUnitFacing(caster))
		local cos, sin = math.cos(angle), math.sin(angle)
		local x, y     = GetUnitX(caster) + 128 * cos, GetUnitY(caster) + 128 * sin
		DestroyEffect(AddSpecialEffect('Objects/Spawnmodels/Undead/ImpaleTargetDust/ImpaleTargetDust.mdl', x, y))
		DestroyEffect(AddSpecialEffect('Abilities/Spells/Human/Thunderclap/ThunderClapCaster.mdl', x, y))
	end
}




--[[



		--128
---@param target unit
---@param order integer
DATA.DummyCastTarget = function(target, order)
	SetUnitX(DATA.Dummy, GetUnitX(target))
	SetUnitY(DATA.Dummy, GetUnitY(target))
	IssueTargetOrderById(DATA.Dummy, order, target)
end

---@param caster unit
---@param target unit
---@param damage real
---@param isCastSlow boolean
---@param isCastDefence boolean
---@param isCastAttack boolean
---@param isProvocate boolean
---@return integer
DATA.Damage          = function(caster, target, damage, isCastSlow, isCastDefence, isCastAttack, isProvocate)
	local casterOwner = GetOwningPlayer(caster)
	if not UnitAlive(target) or not IsPlayerEnemy(casterOwner, GetOwningPlayer(target)) then return 0 end
	
	DestroyEffect(AddSpecialEffectTarget('Effect/Ability/ShakingBlow/Target.mdx', target, 'origin'))
	if isCastSlow then DATA.DummyCastTarget(target, 852075) end -- slow
	if isCastDefence then DATA.DummyCastTarget(target, 852662) end -- acidbomb
	if isCastAttack then DATA.DummyCastTarget(target, 852189) end -- cripple
	if isProvocate then IssueTargetOrderById(target, 851983, caster) end -- 851983
	
	UnitDamageTarget(caster, target, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_FIRE, WEAPON_TYPE_WHOKNOWS)
	return 1
end

---@param caster unit
---@param angle real
---@param offset real
DATA.Cast            = function(caster, angle, offset)
	local player           = GetOwningPlayer(caster)
	local ability          = ABILITY.ShakingBlow
	local spellId          = ability.id
	
	local cos, sin         = math.cos(angle), math.sin(angle)
	local casterX, casterY = GetUnitX(caster) + offset * cos, GetUnitY(caster) + offset * sin
	
	local target---@type unit
	local range            = GetPlayerAbilityPerkLevel(player, ability.codename, 1, 1) > 0 and 600 or 400
	local scale            = range / 300
	
	local damage, damaged  = BlzGetUnitBaseDamage(caster, 1) + GetPlayerAbilityPerkLevel(player, ability.codename, 1, 2) > 0 and GetHeroStr(caster, true) or 0, 0 ---@type integer
	local isDamageCenter   = GetPlayerAbilityPerkLevel(player, ability.codename, 3, 1) > 0
	if isDamageCenter then AddSpecialEffectOnce('Effect/Ability/ShakingBlow/AreaExtend.mdx', casterX, casterY) end
	local isCastSlow    = GetPlayerAbilityPerkLevel(player, ability.codename, 1, 3) > 0
	local isCastDefence = GetPlayerAbilityPerkLevel(player, ability.codename, 2, 2) > 0
	local isCastAttack  = GetPlayerAbilityPerkLevel(player, ability.codename, 2, 3) > 0
	local isProvocate   = GetPlayerAbilityPerkLevel(player, ability.codename, 3, 3) > 0
	
	
	GroupEnumUnitsInRange(GROUP_ENUM_ONCE, casterX, casterY, range, nil)
	while true do
		target = FirstOfGroup(GROUP_ENUM_ONCE)
		if target == nil then break end
		
		local distance     = DistanceBetweenXY(casterX, casterY, GetUnitX(target), GetUnitY(target))
		local damageCenter = isDamageCenter and damage * ((range - distance) / distance) or 0
		damaged            = damaged + ability.data.Damage(caster, target, damage + damageCenter, isCastSlow, isCastDefence, isCastAttack, isProvocate)
		GroupRemoveUnit(GROUP_ENUM_ONCE, target)
	end
	
	if GetPlayerAbilityPerkLevel(player, ability.codename, 2, 1) > 0 then
		local level    = GetUnitAbilityLevel(caster, spellId)
		local cooldown = BlzGetAbilityCooldown(spellId, level - 1)
		BlzSetUnitAbilityCooldown(caster, spellId, level - 1, math.max(0.1, cooldown - damaged * 0.2))
	end
	
	if GetPlayerAbilityPerkLevel(player, ability.codename, 4, 1) > 0 then
		local dummy = CreateUnit(player, ability.data.DummyId, casterX, casterY, 0)
		UnitAddAbility(dummy, ability.data.earthquakeId)
		UnitApplyTimedLife(dummy, BTLF_ID, 10)
		IssuePointOrderById(dummy, 852121, casterX, casterY)
	end
	
	if GetPlayerAbilityPerkLevel(player, ability.codename, 3, 2) > 0 then
		local missile = AddSpecialEffect('Effect/Ability/ShakingBlow/Wave/Wave.mdx', casterX, casterY)
		BlzSetSpecialEffectScale(missile, 0.5)
		local speedInc    = 1200 * TIMER_PERIOD
		local distance    = range * 2
		local damageGroup = CreateGroup()
		BlzSetSpecialEffectYaw(missile, angle)
		BlzSetSpecialEffectHeight(missile, 0)
		TimerStart(CreateTimer(), TIMER_PERIOD, true, function()
			local x, y = GetUnitX(caster) + speedInc * cos, GetUnitY(caster) + speedInc * sin
			distance   = distance - speedInc
			
			if distance <= 0 or not InMapXY(x, y) then
				DestroyEffect(missile)
				GroupClear(damageGroup)
				DestroyGroup(damageGroup)
				return DestroyTimer(GetExpiredTimer())
			end
			
			GroupEnumUnitsInRange(GROUP_ENUM_ONCE, x, y, 150, nil)
			while true do
				target = FirstOfGroup(GROUP_ENUM_ONCE)
				if target == nil then break end
				
				if not IsUnitInGroup(target, damageGroup) then
					ability.data.Damage(caster, target, damage, isCastSlow, isCastDefence, isCastAttack, isProvocate)
				end
				
				GroupAddUnit(damageGroup, target)
				GroupRemoveUnit(GROUP_ENUM_ONCE, target)
			end
			
			BlzSetSpecialEffectX(missile, x)
			BlzSetSpecialEffectY(missile, y)
		end)
	end
end
]]
