function Heal(caster, target, heal, show)
	TimerStart(CreateTimer(), 0.00, false, function()
		local lose = GetWidgetLife(target) - GetUnitState(target, UNIT_STATE_LIFE)
		local k    = 1
		heal       = heal * k
		--local over = heal > lose and heal > lose or 0 ---@type real
		
		SetWidgetLife(target, GetWidgetLife(target) + heal)
		if show == nil or show == true then
			local textSize = heal / 100000 + 0.012
			FlyTextTag('+' .. math.ceil(heal), textSize, GetUnitX(target) - 32, GetUnitY(target), 0, 30, 230, 29, 255, 0, 0.03, 1.5, 2, nil)
		end
	end)
end