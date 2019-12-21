ABILITY[FourCC('aHhb')] = {
	EFFECT = function()
		local caster  = GetTriggerUnit()
		local target  = GetSpellTargetUnit()
		local ability = GetSpellAbility()
		
		local level   = GetAbilityCustomLevel(ability)
		local heal    = level * 50
		
		if IsUnitType(target, UNIT_TYPE_UNDEAD) then
			DestroyEffect(AddSpecialEffectTarget('Effect/Heal/Green.mdx', target, 'origin'))
			UnitDamageTarget(caster, target, heal / 2, false, true, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
		else
			DestroyEffect(AddSpecialEffectTarget('Effect/Heal/Yellow.mdx', target, 'origin'))
			Heal(caster, target, heal, true)
		end
	
	end
}
