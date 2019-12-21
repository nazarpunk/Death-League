function InitGlobals()
end

function CreateUnitsForPlayer0()
    local p = Player(0)
    local u
    local unitID
    local t
    local life
    u = CreateUnit(p, FourCC("crab"), -94.2, 1782.0, 335.660)
    u = CreateUnit(p, FourCC("ugho"), 328.6, 93.7, 24.764)
    u = CreateUnit(p, FourCC("ugho"), 327.4, 230.9, 341.553)
    u = CreateUnit(p, FourCC("ugho"), 346.5, 374.8, 307.390)
end

function CreateNeutralHostile()
    local p = Player(PLAYER_NEUTRAL_AGGRESSIVE)
    local u
    local unitID
    local t
    local life
    u = CreateUnit(p, FourCC("nban"), 1376.8, -239.5, 188.147)
    u = CreateUnit(p, FourCC("nban"), 1404.5, -346.0, 351.397)
    u = CreateUnit(p, FourCC("nban"), 1413.5, -412.2, 40.640)
    u = CreateUnit(p, FourCC("nban"), 1394.0, -471.2, 283.093)
    u = CreateUnit(p, FourCC("earc"), 606.5, 454.3, 238.751)
    u = CreateUnit(p, FourCC("earc"), 616.5, 291.2, 209.177)
    u = CreateUnit(p, FourCC("earc"), 621.9, 135.1, 159.403)
    u = CreateUnit(p, FourCC("earc"), 620.9, -19.4, 127.773)
    u = CreateUnit(p, FourCC("nban"), 1350.1, -550.6, 279.391)
    u = CreateUnit(p, FourCC("nban"), 1400.6, -589.4, 143.793)
    u = CreateUnit(p, FourCC("nban"), 1450.1, -552.0, 285.477)
    u = CreateUnit(p, FourCC("nban"), 290.6, -1524.5, 99.946)
    u = CreateUnit(p, FourCC("nban"), 175.4, -1505.5, 240.630)
    u = CreateUnit(p, FourCC("nban"), 96.5, -1492.2, 320.712)
    u = CreateUnit(p, FourCC("nban"), 32.5, -1534.7, 129.818)
    u = CreateUnit(p, FourCC("nban"), 85.8, -1590.0, 39.980)
    u = CreateUnit(p, FourCC("nban"), 154.0, -1595.5, 316.361)
    u = CreateUnit(p, FourCC("nban"), 234.8, -1573.2, 357.396)
    u = CreateUnit(p, FourCC("nban"), 321.9, -1456.1, 327.216)
    u = CreateUnit(p, FourCC("nban"), -1370.7, -554.0, 148.990)
    u = CreateUnit(p, FourCC("nban"), -1327.9, -653.0, 105.780)
    u = CreateUnit(p, FourCC("nban"), -1279.5, -752.5, 228.632)
    u = CreateUnit(p, FourCC("nban"), -1250.6, -838.0, 269.184)
    u = CreateUnit(p, FourCC("nban"), -1386.8, -631.4, 311.263)
    u = CreateUnit(p, FourCC("nban"), -1375.2, -763.2, 315.482)
    u = CreateUnit(p, FourCC("nban"), -1319.9, -840.5, 147.815)
    u = CreateUnit(p, FourCC("nban"), -1540.9, 1045.0, 71.018)
    u = CreateUnit(p, FourCC("nban"), -1429.0, 1086.5, 174.303)
    u = CreateUnit(p, FourCC("nban"), -1300.7, 1115.4, 115.712)
    u = CreateUnit(p, FourCC("nban"), -1205.2, 1123.2, 321.942)
    u = CreateUnit(p, FourCC("nban"), -1130.5, 1082.7, 160.504)
    u = CreateUnit(p, FourCC("nban"), -1131.3, 1004.5, 6.790)
    u = CreateUnit(p, FourCC("nban"), -1238.3, 928.0, 112.767)
    u = CreateUnit(p, FourCC("nban"), -1379.8, 924.6, 89.080)
    u = CreateUnit(p, FourCC("nban"), -1446.3, 959.6, 72.391)
    u = CreateUnit(p, FourCC("nban"), -1269.9, 1039.4, 223.183)
    u = CreateUnit(p, FourCC("nban"), -1190.3, 1043.1, 235.521)
    u = CreateUnit(p, FourCC("nban"), -1414.8, 843.4, 112.470)
    u = CreateUnit(p, FourCC("nban"), -1334.8, 881.8, 119.777)
    u = CreateUnit(p, FourCC("nban"), -1189.0, 878.4, 278.853)
    u = CreateUnit(p, FourCC("nban"), -1103.8, 870.0, 25.994)
end

function CreateNeutralPassiveBuildings()
    local p = Player(PLAYER_NEUTRAL_PASSIVE)
    local u
    local unitID
    local t
    local life
    u = CreateUnit(p, FourCC("tStr"), -256.0, 1984.0, 270.000)
    SetUnitColor(u, ConvertPlayerColor(0))
    u = CreateUnit(p, FourCC("tAgi"), 0.0, 1984.0, 270.000)
    SetUnitColor(u, ConvertPlayerColor(6))
    u = CreateUnit(p, FourCC("tInt"), 256.0, 1984.0, 270.000)
    SetUnitColor(u, ConvertPlayerColor(1))
end

function CreatePlayerBuildings()
end

function CreatePlayerUnits()
    CreateUnitsForPlayer0()
end

function CreateAllUnits()
    CreateNeutralPassiveBuildings()
    CreatePlayerBuildings()
    CreateNeutralHostile()
    CreatePlayerUnits()
end

--CUSTOM_CODE
do
	local DamageTrigger = CreateTrigger()
	for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
		TriggerRegisterPlayerUnitEvent(DamageTrigger, Player(i), EVENT_PLAYER_UNIT_DAMAGING) -- До вычета брони
		TriggerRegisterPlayerUnitEvent(DamageTrigger, Player(i), EVENT_PLAYER_UNIT_DAMAGED) -- После вычета брони
	end
	TriggerAddAction(DamageTrigger, function()
		local damage     = GetEventDamage() -- число урона
		local damageType = BlzGetEventDamageType()
		if damage < 1 then return end
		
		local eventId        = GetHandleId(GetTriggerEventId())
		--local isEventDamaging = eventId == GetHandleId(EVENT_PLAYER_UNIT_DAMAGING)
		local isEventDamaged = eventId == GetHandleId(EVENT_PLAYER_UNIT_DAMAGED)
		
		local target         = GetTriggerUnit() -- тот кто получил урон
		local caster         = GetEventDamageSource() -- тот кто нанёс урон
		local casterOwner    = GetOwningPlayer(caster)
		
		if isEventDamaged then
			damage         = GetEventDamage()
			local textSize = damage / 100000 + 0.012
			FlyTextTag('-' .. math.ceil(damage), textSize, GetUnitX(target) - 32, GetUnitY(target), 32, 255, 0, 0, 255, 0, 0.03, 1.5, 2, casterOwner)
		end
	end)
end

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
---@param text string
---@param textSize real
---@param x real
---@param y real
---@param z real
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
---@param xvel real
---@param yvel real
---@param fadepoint real
---@param lifespan real
---@param player player
---@return texttag
function FlyTextTag(text, textSize, x, y, z, red, green, blue, alpha, xvel, yvel, fadepoint, lifespan, player)
	local t = CreateTextTag()
	SetTextTagText(t, text, textSize)
	SetTextTagPos(t, x, y, z)
	SetTextTagColor(t, red, green, blue, alpha)
	SetTextTagVelocity(t, xvel, yvel)
	SetTextTagFadepoint(t, fadepoint)
	SetTextTagLifespan(t, lifespan)
	SetTextTagPermanent(t, false)
	if player ~= nil then
		SetTextTagVisibility(t, player == GetLocalPlayer())
	end
	return t
end

---@param target widget
---@param text string
---@param player player
---@return texttag
function FlyTextTagGoldBounty(target, text, player)
	return FlyTextTag(text, 0.024, GetWidgetX(target) - 16, GetWidgetY(target), 0, 255, 220, 0, 255, 0, 0.03, 2, 3, player)
end

---@param target widget
---@param text string
---@param player player
---@return texttag
function FlyTextTagLumberBounty(target, text, player)
	return FlyTextTag(text, 0.024, GetWidgetX(target) - 16, GetWidgetY(target), 0, 0, 200, 80, 255, 0, 0.03, 2, 3, player)
end

---@param target widget
---@param text string
---@param player player
---@return texttag
function FlyTextTagMiss(target, text, player)
	return FlyTextTag(text, 0.024, GetWidgetX(target), GetWidgetY(target), 0, 255, 0, 0, 255, 0, 0.03, 1, 3, player)
end

---@param target widget
---@param text string
---@param player player
---@return texttag
function FlyTextTagCriticalStrike(target, text, player)
	return FlyTextTag(text, 0.024, GetWidgetX(target), GetWidgetY(target), 0, 255, 0, 0, 255, 0, 0.04, 2, 5, player)
end

---@param target widget
---@param text string
---@param player player
---@return texttag
function FlyTextTagManaBurn(target, text, player)
	return FlyTextTag(text, 0.024, GetWidgetX(target), GetWidgetY(target), 0, 82, 82, 255, 255, 0, 0.04, 2, 5, player)
end

---@param target widget
---@param text string
---@param player player
---@return texttag
function FlyTextTagShadowStrike(target, text, player)
	return FlyTextTag(text, 0.024, GetWidgetX(target), GetWidgetY(target), 0, 160, 255, 0, 255, 0, 0.04, 2, 5, player)
end
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
---@param x real---@param distance real---@param angle real radian---@return realfunction math.offsetX(x, distance, angle)	return distance * math.cos(angle) + xend---@param y real---@param distance real---@param angle real radian---@return realfunction math.offsetY(y, distance, angle)	return distance * math.sin(angle) + yend---@param x real---@param y real---@param distance real---@param angle real radian---@return real, realfunction math.offsetXY(x, y, distance, angle)	return distance * math.cos(angle) + x, distance * math.sin(angle) + yend---@param zs real начальная высота одного края дуги---@param ze real конечная высота другого края дуги---@param h real максимальная высота на середине расстояния (x = d / 2)---@param d real общее расстояние до цели---@param x real расстояние от исходной цели до точки---@return realfunction math.parabolaZ(zs, ze, h, d, x)	return (2 * (zs + ze - 2 * h) * (x / d - 1) + ze - zs) * (x / d) + zsend---@param xa real---@param ya real---@param xb real---@param yb real---@return realfunction math.distanceXY(xa, ya, xb, yb)	local dx, dy = xb - xa, yb - ya	return math.sqrt(dx * dx + dy * dy)end---@param xa real---@param ya real---@param za real---@param xb real---@param yb real---@param zb real---@return realfunction math.distanceXYZ(xa, ya, za, xb, yb, zb)	local dx, dy, dz = xb - xa, yb - ya, zb - za	return math.sqrt(dx * dx + dy * dy + dz * dz)end---@param xa real---@param ya real---@param xb real---@param yb real---@return real radianfunction math.angleXY(xa, ya, xb, yb)	return math.atan(yb - ya, xb - xa)end---@param a real radian---@param b real radian---@return real radianfunction math.angleDiff(a, b)	local c = a > b and a - b or b - a	local d = a > b and b - a + 2 * math.pi or a - b + 2 * math.pi	return c > d and d or cend--https://xgm.guru/p/wc3/iscoordsincircle-- Проверяет, находится ли [x,y] в окружности [cx,cy] радиусом r---@param x table---@param y table---@param cx table---@param cy table---@param r table---@return booleanfunction math.inCircleXY(x, y, cx, cy, r)	return (cx - x) * (cx - x) + (cy - y) * (cy - y) < r * rend-- xgm.guru/p/wc3/warden-math---@param a real degrees---@param b real degrees---@return real degreesfunction math.angleDiffDeg(a, b)	a, b = math.abs(a), math.abs(b)	if a > b then		a, b = b, a	end	local x = b - 360	if b - a > a - x then		b = x	end	return math.abs(a - b)end-- https://xgm.guru/p/wc3/perpendicular-- Находит длину перпендикуляра от линии проходящей через [xa, ya][xb, yb] к точке [xc, yc]---@param xa real---@param ya real---@param xb real---@param yb real---@param xc real---@param yc real---@return realfunction math.perpendicular(xa, ya, xb, yb, xc, yc)	return math.sqrt((xa - xc) * (xa - xc) + (ya - yc) * (ya - yc)) * math.sin(math.atan(yc - ya, xc - xa) - math.atan(yb - ya, xb - xa))end
do	local RANGE             = 10 -- Расстояние, на котором проходит проверка	local DUMMY             = FourCC('wolg') -- Ид предмета для проверки проходимости		local rect---@type rect	local item ---@type item		local InitGlobalsOrigin = InitGlobals	function InitGlobals()		InitGlobalsOrigin()		rect = Rect(0, 0, 128, 128)		item = CreateItem(DUMMY, 0, 0)		SetItemVisible(item, false)	end		local items = {}	local function hide()		local target = GetEnumItem()		if not IsItemVisible(target) then return end		table.insert(items, target)		SetItemVisible(target, false)	end		---@param x real	---@param y real	---@return boolean	function IsTerrainWalkable(x, y)		MoveRectTo(rect, x, y)		EnumItemsInRect(rect, nil, hide)				SetItemPosition(item, x, y)		local dx = GetItemX(item) - x		local dy = GetItemY(item) - y		SetItemVisible(item, false)				for i = 1, #items do			SetItemVisible(items[i], true)		end		items = {}				return dx * dx + dy * dy <= RANGE * RANGE and not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY)	endend---@param x real---@param y real---@return booleanfunction IsTerrainDeepWater (x, y)	return not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY) and IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY)end---@param x real---@param y real---@return booleanfunction IsTerrainShallowWater (x, y)	return not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY) and not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) and IsTerrainPathable(x, y, PATHING_TYPE_BUILDABILITY)end---@param x real---@param y real---@return booleanfunction IsTerrainLand(x, y)	return IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY)end---@param x real---@param y real---@return booleanfunction IsTerrainPlatform (x, y)	return not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY) and not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) and not IsTerrainPathable(x, y, PATHING_TYPE_BUILDABILITY)end
ABILITY = {}
do
	local EventChannelId = GetHandleId(EVENT_PLAYER_UNIT_SPELL_CHANNEL)
	local EventCastId    = GetHandleId(EVENT_PLAYER_UNIT_SPELL_CAST)
	local EventEffectId  = GetHandleId(EVENT_PLAYER_UNIT_SPELL_EFFECT)
	local EventEndCastId = GetHandleId(EVENT_PLAYER_UNIT_SPELL_ENDCAST)
	local EventFinishId  = GetHandleId(EVENT_PLAYER_UNIT_SPELL_FINISH)
	
	local AbilityTrigger = CreateTrigger()
	for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
		TriggerRegisterPlayerUnitEvent(AbilityTrigger, Player(i), EVENT_PLAYER_UNIT_SPELL_CHANNEL)
		TriggerRegisterPlayerUnitEvent(AbilityTrigger, Player(i), EVENT_PLAYER_UNIT_SPELL_CAST)
		TriggerRegisterPlayerUnitEvent(AbilityTrigger, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT)
		TriggerRegisterPlayerUnitEvent(AbilityTrigger, Player(i), EVENT_PLAYER_UNIT_SPELL_ENDCAST)
		TriggerRegisterPlayerUnitEvent(AbilityTrigger, Player(i), EVENT_PLAYER_UNIT_SPELL_FINISH)
	end
	
	local ABILITYS = ABILITY ---@type table
	TriggerAddAction(AbilityTrigger, function()
		local eventId = GetHandleId(GetTriggerEventId())
		local ability = ABILITYS[GetSpellAbilityId()]
		
		if ability ~= nil then
			if eventId == EventChannelId and ability.CHANNEL ~= nil then ability.CHANNEL()
			elseif eventId == EventCastId and ability.CAST ~= nil then ability.CAST()
			elseif eventId == EventEffectId and ability.EFFECT ~= nil then ability.EFFECT()
			elseif eventId == EventEndCastId and ability.ENDCAST ~= nil then ability.ENDCAST()
			elseif eventId == EventFinishId and ability.FINISH ~= nil then ability.FINISH()
			end
		end
	end)
end

---@param ability ability
---@return integer
function GetAbilityCustomLevel(ability)
	return BlzGetAbilityIntegerField(ability, ABILITY_IF_BUTTON_POSITION_ACTIVATED_X)
end

---@param ability ability
---@param level integer
function SetAbilityCustomLevel(ability, level)
	BlzSetAbilityIntegerField(ability, ABILITY_IF_BUTTON_POSITION_ACTIVATED_X, level)
end
PLAYER = {}
for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
	PLAYER[i] = {
		hero    = nil,
		ability = {}
	}
end
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
			for w in GetEventPlayerChatString():gmatch('[^%s]+') do
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

do
	local InitGlobalsOrigin = InitGlobals
	function InitGlobals()
		InitGlobalsOrigin()
		FogEnable(false)
		FogMaskEnable(false)
		MeleeStartingHeroLimit()
	end
end
--CUSTOM_CODE
function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(0), true)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(1), 1)
    SetPlayerColor(Player(1), ConvertPlayerColor(1))
    SetPlayerRacePreference(Player(1), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(1), true)
    SetPlayerController(Player(1), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(2), 2)
    SetPlayerColor(Player(2), ConvertPlayerColor(2))
    SetPlayerRacePreference(Player(2), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(2), true)
    SetPlayerController(Player(2), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(3), 3)
    SetPlayerColor(Player(3), ConvertPlayerColor(3))
    SetPlayerRacePreference(Player(3), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(3), true)
    SetPlayerController(Player(3), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(4), 4)
    SetPlayerColor(Player(4), ConvertPlayerColor(4))
    SetPlayerRacePreference(Player(4), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(4), true)
    SetPlayerController(Player(4), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(5), 5)
    SetPlayerColor(Player(5), ConvertPlayerColor(5))
    SetPlayerRacePreference(Player(5), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(5), true)
    SetPlayerController(Player(5), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(6), 6)
    SetPlayerColor(Player(6), ConvertPlayerColor(6))
    SetPlayerRacePreference(Player(6), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(6), true)
    SetPlayerController(Player(6), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(7), 7)
    SetPlayerColor(Player(7), ConvertPlayerColor(7))
    SetPlayerRacePreference(Player(7), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(7), true)
    SetPlayerController(Player(7), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(8), 8)
    SetPlayerColor(Player(8), ConvertPlayerColor(8))
    SetPlayerRacePreference(Player(8), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(8), true)
    SetPlayerController(Player(8), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(9), 9)
    SetPlayerColor(Player(9), ConvertPlayerColor(9))
    SetPlayerRacePreference(Player(9), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(9), true)
    SetPlayerController(Player(9), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(10), 10)
    SetPlayerColor(Player(10), ConvertPlayerColor(10))
    SetPlayerRacePreference(Player(10), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(10), true)
    SetPlayerController(Player(10), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(11), 11)
    SetPlayerColor(Player(11), ConvertPlayerColor(11))
    SetPlayerRacePreference(Player(11), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(11), true)
    SetPlayerController(Player(11), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(12), 12)
    SetPlayerColor(Player(12), ConvertPlayerColor(12))
    SetPlayerRacePreference(Player(12), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(12), true)
    SetPlayerController(Player(12), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(13), 13)
    SetPlayerColor(Player(13), ConvertPlayerColor(13))
    SetPlayerRacePreference(Player(13), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(13), true)
    SetPlayerController(Player(13), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(14), 14)
    SetPlayerColor(Player(14), ConvertPlayerColor(14))
    SetPlayerRacePreference(Player(14), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(14), true)
    SetPlayerController(Player(14), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(15), 15)
    SetPlayerColor(Player(15), ConvertPlayerColor(15))
    SetPlayerRacePreference(Player(15), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(15), true)
    SetPlayerController(Player(15), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(16), 16)
    SetPlayerColor(Player(16), ConvertPlayerColor(16))
    SetPlayerRacePreference(Player(16), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(16), true)
    SetPlayerController(Player(16), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(17), 17)
    SetPlayerColor(Player(17), ConvertPlayerColor(17))
    SetPlayerRacePreference(Player(17), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(17), true)
    SetPlayerController(Player(17), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(18), 18)
    SetPlayerColor(Player(18), ConvertPlayerColor(18))
    SetPlayerRacePreference(Player(18), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(18), true)
    SetPlayerController(Player(18), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(19), 19)
    SetPlayerColor(Player(19), ConvertPlayerColor(19))
    SetPlayerRacePreference(Player(19), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(19), true)
    SetPlayerController(Player(19), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(20), 20)
    SetPlayerColor(Player(20), ConvertPlayerColor(20))
    SetPlayerRacePreference(Player(20), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(20), true)
    SetPlayerController(Player(20), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(21), 21)
    SetPlayerColor(Player(21), ConvertPlayerColor(21))
    SetPlayerRacePreference(Player(21), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(21), true)
    SetPlayerController(Player(21), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(22), 22)
    SetPlayerColor(Player(22), ConvertPlayerColor(22))
    SetPlayerRacePreference(Player(22), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(22), true)
    SetPlayerController(Player(22), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(23), 23)
    SetPlayerColor(Player(23), ConvertPlayerColor(23))
    SetPlayerRacePreference(Player(23), RACE_PREF_RANDOM)
    SetPlayerRaceSelectable(Player(23), true)
    SetPlayerController(Player(23), MAP_CONTROL_USER)
end

function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
    SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(1), 0)
    SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(2), 0)
    SetPlayerState(Player(2), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(3), 0)
    SetPlayerState(Player(3), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(4), 0)
    SetPlayerState(Player(4), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(5), 0)
    SetPlayerState(Player(5), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(6), 0)
    SetPlayerState(Player(6), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(7), 0)
    SetPlayerState(Player(7), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(8), 0)
    SetPlayerState(Player(8), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(9), 0)
    SetPlayerState(Player(9), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(10), 0)
    SetPlayerState(Player(10), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(11), 0)
    SetPlayerState(Player(11), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(12), 0)
    SetPlayerState(Player(12), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(13), 0)
    SetPlayerState(Player(13), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(14), 0)
    SetPlayerState(Player(14), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(15), 0)
    SetPlayerState(Player(15), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(16), 0)
    SetPlayerState(Player(16), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(17), 0)
    SetPlayerState(Player(17), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(18), 0)
    SetPlayerState(Player(18), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(19), 0)
    SetPlayerState(Player(19), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(20), 0)
    SetPlayerState(Player(20), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(21), 0)
    SetPlayerState(Player(21), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(22), 0)
    SetPlayerState(Player(22), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(23), 0)
    SetPlayerState(Player(23), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(4), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(5), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(6), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(7), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(8), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(9), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(10), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(11), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(12), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(13), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(14), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(15), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(16), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(17), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(18), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(19), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(20), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(22), true)
    SetPlayerAllianceStateAllyBJ(Player(21), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(22), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(4), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(5), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(6), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(7), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(8), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(9), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(10), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(11), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(12), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(13), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(14), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(15), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(16), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(17), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(18), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(19), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(20), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(21), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(2), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(3), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(4), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(5), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(6), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(7), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(8), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(9), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(10), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(11), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(12), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(13), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(14), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(15), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(16), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(17), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(18), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(19), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(20), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(22), true)
    SetPlayerAllianceStateVisionBJ(Player(21), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(22), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(2), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(3), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(4), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(5), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(6), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(7), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(8), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(9), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(10), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(11), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(12), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(13), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(14), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(15), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(16), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(17), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(18), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(19), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(20), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(21), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(22), true)
end

function InitAllyPriorities()
    SetStartLocPrioCount(0, 23)
    SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 1, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 2, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 3, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 4, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 5, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 6, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 7, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 8, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 9, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 10, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 11, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 12, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 13, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 14, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 15, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 16, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(1, 23)
    SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 1, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 2, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 3, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 4, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 5, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 6, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 7, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 8, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 9, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 10, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 11, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 12, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 13, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 14, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 15, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 16, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(2, 23)
    SetStartLocPrio(2, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 2, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 3, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 4, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 5, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 6, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 7, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 8, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 9, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 10, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 11, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 12, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 13, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 14, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 15, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 16, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(3, 23)
    SetStartLocPrio(3, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 3, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 4, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 5, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 6, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 7, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 8, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 9, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 10, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 11, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 12, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 13, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 14, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 15, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 16, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(4, 23)
    SetStartLocPrio(4, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 4, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 5, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 6, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 7, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 8, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 9, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 10, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 11, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 12, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 13, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 14, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 15, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 16, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(4, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(5, 23)
    SetStartLocPrio(5, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 5, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 6, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 7, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 8, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 9, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 10, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 11, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 12, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 13, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 14, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 15, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 16, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(5, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(6, 23)
    SetStartLocPrio(6, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 6, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 7, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 8, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 9, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 10, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 11, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 12, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 13, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 14, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 15, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 16, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(6, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(7, 23)
    SetStartLocPrio(7, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 6, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 7, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 8, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 9, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 10, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 11, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 12, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 13, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 14, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 15, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 16, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(7, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(8, 23)
    SetStartLocPrio(8, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 6, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 7, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 8, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 9, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 10, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 11, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 12, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 13, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 14, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 15, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 16, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(8, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(9, 23)
    SetStartLocPrio(9, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 6, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 7, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 8, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 9, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 10, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 11, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 12, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 13, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 14, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 15, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 16, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(9, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(10, 23)
    SetStartLocPrio(10, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 6, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 7, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 8, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 9, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 10, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 11, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 12, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 13, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 14, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 15, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 16, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(10, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(11, 23)
    SetStartLocPrio(11, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 6, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 7, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 8, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 9, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 10, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 11, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 12, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 13, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 14, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 15, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 16, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(11, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(12, 23)
    SetStartLocPrio(12, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 6, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 7, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 8, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 9, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 10, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 11, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 12, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 13, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 14, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 15, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 16, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(12, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(13, 23)
    SetStartLocPrio(13, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 6, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 7, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 8, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 9, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 10, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 11, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 12, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 13, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 14, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 15, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 16, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(13, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(14, 23)
    SetStartLocPrio(14, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 6, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 7, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 8, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 9, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 10, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 11, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 12, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 13, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 14, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 15, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 16, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(14, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(15, 23)
    SetStartLocPrio(15, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 6, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 7, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 8, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 9, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 10, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 11, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 12, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 13, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 14, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 15, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 16, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(15, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(16, 23)
    SetStartLocPrio(16, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 6, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 7, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 8, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 9, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 10, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 11, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 12, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 13, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 14, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 15, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 16, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(16, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(17, 23)
    SetStartLocPrio(17, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 6, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 7, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 8, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 9, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 10, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 11, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 12, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 13, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 14, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 15, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 16, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 17, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(17, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(18, 23)
    SetStartLocPrio(18, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 6, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 7, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 8, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 9, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 10, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 11, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 12, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 13, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 14, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 15, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 16, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 17, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 18, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(18, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(19, 23)
    SetStartLocPrio(19, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 6, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 7, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 8, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 9, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 10, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 11, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 12, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 13, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 14, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 15, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 16, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 17, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 18, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 19, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(19, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(20, 23)
    SetStartLocPrio(20, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 6, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 7, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 8, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 9, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 10, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 11, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 12, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 13, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 14, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 15, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 16, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 17, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 18, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 19, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 20, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(20, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(21, 23)
    SetStartLocPrio(21, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 6, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 7, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 8, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 9, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 10, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 11, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 12, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 13, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 14, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 15, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 16, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 17, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 18, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 19, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 20, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 21, 22, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(21, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(22, 23)
    SetStartLocPrio(22, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 6, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 7, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 8, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 9, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 10, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 11, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 12, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 13, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 14, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 15, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 16, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 17, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 18, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 19, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 20, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 21, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(22, 22, 23, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(23, 23)
    SetStartLocPrio(23, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 3, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 4, 4, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 5, 5, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 6, 6, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 7, 7, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 8, 8, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 9, 9, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 10, 10, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 11, 11, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 12, 12, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 13, 13, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 14, 14, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 15, 15, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 16, 16, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 17, 17, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 18, 18, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 19, 19, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 20, 20, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 21, 21, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(23, 22, 22, MAP_LOC_PRIO_HIGH)
end

function main()
    SetCameraBounds(-2048.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -2048.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 2048.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 2048.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -2048.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 2048.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 2048.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -2048.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCDalaran\\DNCDalaranTerrain\\DNCDalaranTerrain.mdl", "Environment\\DNC\\DNCDalaran\\DNCDalaranUnit\\DNCDalaranUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("DalaranRuinsDay")
    SetAmbientNightSound("DalaranRuinsNight")
    SetMapMusic("Music", true, 0)
    CreateAllUnits()
    InitBlizzard()
    InitGlobals()
end

function config()
    SetMapName("TRIGSTR_001")
    SetMapDescription("TRIGSTR_003")
    SetPlayers(24)
    SetTeams(24)
    SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
    DefineStartLocation(0, 0.0, 1792.0)
    DefineStartLocation(1, 0.0, 1792.0)
    DefineStartLocation(2, 0.0, 1792.0)
    DefineStartLocation(3, 0.0, 1792.0)
    DefineStartLocation(4, 0.0, 1792.0)
    DefineStartLocation(5, 0.0, 1792.0)
    DefineStartLocation(6, 0.0, 1792.0)
    DefineStartLocation(7, 0.0, 1792.0)
    DefineStartLocation(8, 0.0, 1792.0)
    DefineStartLocation(9, 0.0, 1792.0)
    DefineStartLocation(10, 0.0, 1792.0)
    DefineStartLocation(11, 0.0, 1792.0)
    DefineStartLocation(12, 0.0, 1792.0)
    DefineStartLocation(13, 0.0, 1792.0)
    DefineStartLocation(14, 0.0, 1792.0)
    DefineStartLocation(15, 0.0, 1792.0)
    DefineStartLocation(16, 0.0, 1792.0)
    DefineStartLocation(17, 0.0, 1792.0)
    DefineStartLocation(18, 0.0, 1792.0)
    DefineStartLocation(19, 0.0, 1792.0)
    DefineStartLocation(20, 0.0, 1792.0)
    DefineStartLocation(21, 0.0, 1792.0)
    DefineStartLocation(22, 0.0, 1792.0)
    DefineStartLocation(23, 0.0, 1792.0)
    InitCustomPlayerSlots()
    InitCustomTeams()
    InitAllyPriorities()
end

