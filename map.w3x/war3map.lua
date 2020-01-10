gg_trg___________________________u = nil
function InitGlobals()
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
---@param x real
---@param distance real
---@param angle real radian
---@return real
function math.offsetX(x, distance, angle)
	return distance * math.cos(angle) + x
end
---@param y real
---@param distance real
---@param angle real radian
---@return real
function math.offsetY(y, distance, angle)
	return distance * math.sin(angle) + y
end
---@param x real
---@param y real
---@param distance real
---@param angle real radian
---@return real, real
function math.offsetXY(x, y, distance, angle)
	return distance * math.cos(angle) + x, distance * math.sin(angle) + y
end
---@param zs real начальная высота одного края дуги
---@param ze real конечная высота другого края дуги
---@param h real максимальная высота на середине расстояния (x = d / 2)
---@param d real общее расстояние до цели
---@param x real расстояние от исходной цели до точки
---@return real
function math.parabolaZ(zs, ze, h, d, x)
	return (2 * (zs + ze - 2 * h) * (x / d - 1) + ze - zs) * (x / d) + zs
end
---@param xa real
---@param ya real
---@param xb real
---@param yb real
---@return real
function math.distanceXY(xa, ya, xb, yb)
	local dx, dy = xb - xa, yb - ya
	return math.sqrt(dx * dx + dy * dy)
end
---@param xa real
---@param ya real
---@param za real
---@param xb real
---@param yb real
---@param zb real
---@return real
function math.distanceXYZ(xa, ya, za, xb, yb, zb)
	local dx, dy, dz = xb - xa, yb - ya, zb - za
	return math.sqrt(dx * dx + dy * dy + dz * dz)
end
---@param xa real
---@param ya real
---@param xb real
---@param yb real
---@return real radian
function math.angleXY(xa, ya, xb, yb)
	return math.atan(yb - ya, xb - xa)
end
---@param a real radian
---@param b real radian
---@return real radian
function math.angleDiff(a, b)
	local c = a > b and a - b or b - a
	local d = a > b and b - a + 2 * math.pi or a - b + 2 * math.pi
	return c > d and d or c
end
--https://xgm.guru/p/wc3/iscoordsincircle
-- Проверяет, находится ли [x,y] в окружности [cx,cy] радиусом r
---@param x table
---@param y table
---@param cx table
---@param cy table
---@param r table
---@return boolean
function math.inCircleXY(x, y, cx, cy, r)
	return (cx - x) * (cx - x) + (cy - y) * (cy - y) < r * r
end
-- xgm.guru/p/wc3/warden-math
---@param a real degrees
---@param b real degrees
---@return real degrees
function math.angleDiffDeg(a, b)
	a, b = math.abs(a), math.abs(b)
	if a > b then
		a, b = b, a
	end
	local x = b - 360
	if b - a > a - x then
		b = x
	end
	return math.abs(a - b)
end
-- https://xgm.guru/p/wc3/perpendicular
-- Находит длину перпендикуляра от линии проходящей через [xa, ya][xb, yb] к точке [xc, yc]
---@param xa real
---@param ya real
---@param xb real
---@param yb real
---@param xc real
---@param yc real
---@return real
function math.perpendicular(xa, ya, xb, yb, xc, yc)
	return math.sqrt((xa - xc) * (xa - xc) + (ya - yc) * (ya - yc)) * math.sin(math.atan(yc - ya, xc - xa) - math.atan(yb - ya, xb - xa))
end
do
	local RANGE             = 10 -- Расстояние, на котором проходит проверка
	local DUMMY             = FourCC('wolg') -- Ид предмета для проверки проходимости
	
	local rect---@type rect
	local item ---@type item
	
	local InitGlobalsOrigin = InitGlobals
	function InitGlobals()
		InitGlobalsOrigin()
		rect = Rect(0, 0, 128, 128)
		item = CreateItem(DUMMY, 0, 0)
		SetItemVisible(item, false)
	end
	
	local items = {}
	local function hide()
		local target = GetEnumItem()
		if not IsItemVisible(target) then return end
		table.insert(items, target)
		SetItemVisible(target, false)
	end
	
	---@param x real
	---@param y real
	---@return boolean
	function IsTerrainWalkable(x, y)
		MoveRectTo(rect, x, y)
		EnumItemsInRect(rect, nil, hide)
		
		SetItemPosition(item, x, y)
		local dx = GetItemX(item) - x
		local dy = GetItemY(item) - y
		SetItemVisible(item, false)
		
		for i = 1, #items do
			SetItemVisible(items[i], true)
		end
		items = {}
		
		return dx * dx + dy * dy <= RANGE * RANGE and not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY)
	end
end
---@param x real
---@param y real
---@return boolean
function IsTerrainDeepWater (x, y)
	return not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY) and IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY)
end
---@param x real
---@param y real
---@return boolean
function IsTerrainShallowWater (x, y)
	return not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY) and not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) and IsTerrainPathable(x, y, PATHING_TYPE_BUILDABILITY)
end
---@param x real
---@param y real
---@return boolean
function IsTerrainLand(x, y)
	return IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY)
end
---@param x real
---@param y real
---@return boolean
function IsTerrainPlatform (x, y)
	return not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY) and not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) and not IsTerrainPathable(x, y, PATHING_TYPE_BUILDABILITY)
end
do
	local syncInterval                       = 0.25
	PLAYER_CAM_TARGET_X, PLAYER_CAM_TARGET_Y = {}, {}
	
	---@param player player
	---@return real,real
	function GetPlayerCameraTargetXY(player)
		local playerId = GetPlayerId(player)
		return PLAYER_CAM_TARGET_X[playerId] or 0, PLAYER_CAM_TARGET_Y[playerId] or 0
	end
	
	local prefixX, prefixY = 'SyncCameraTargetX', 'SyncCameraTargetY'
	TimerStart(CreateTimer(), syncInterval, true, function()
		for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
			local player = Player(i)
			if GetPlayerController(player) == MAP_CONTROL_USER and GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING then
				BlzSendSyncData(prefixX, GetCameraTargetPositionX())
				BlzSendSyncData(prefixY, GetCameraTargetPositionY())
			end
		end
	end)
	local cameraSyncTrigger = CreateTrigger()
	TriggerAddAction(cameraSyncTrigger, function()
		local data                            = BlzGetTriggerSyncPrefix() == prefixX and PLAYER_CAM_TARGET_X or PLAYER_CAM_TARGET_Y ---@type table
		data[GetPlayerId(GetTriggerPlayer())] = tonumber(BlzGetTriggerSyncData())
	end)
end
do
	local sync              = {
		'GetCameraBoundMaxX'
	}
	
	local InitGlobalsOrigin = InitGlobals ---@type function
	function InitGlobals()
		InitGlobalsOrigin()
		--print(123)
		
		--print(_G['GetCameraBoundMaxX'])
	end
end
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
		print 'Тестим pfvtye'
		FogEnable(false)
		FogMaskEnable(false)
		MeleeStartingHeroLimit()
	end
end
--CUSTOM_CODE
function Trig___________________________u_Actions()
    MeleeStartingVisibility()
    MeleeStartingHeroLimit()
    MeleeGrantHeroItems()
    MeleeStartingResources()
    MeleeClearExcessUnits()
    MeleeStartingUnits()
    MeleeStartingAI()
    MeleeInitVictoryDefeat()
end
function InitTrig___________________________u()
    gg_trg___________________________u = CreateTrigger()
    TriggerAddAction(gg_trg___________________________u, Trig___________________________u_Actions)
end
function InitCustomTriggers()
    InitTrig___________________________u()
end
function RunInitializationTriggers()
    ConditionalTriggerExecute(gg_trg___________________________u)
end
function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(0), true)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
end
function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
end
function main()
    SetCameraBounds(-3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("LordaeronSummerDay")
    SetAmbientNightSound("LordaeronSummerNight")
    SetMapMusic("Music", true, 0)
    InitBlizzard()
    InitGlobals()
    InitCustomTriggers()
    RunInitializationTriggers()
end
function config()
    SetMapName("TRIGSTR_003")
    SetMapDescription("TRIGSTR_005")
    SetPlayers(1)
    SetTeams(1)
    SetGamePlacement(MAP_PLACEMENT_USE_MAP_SETTINGS)
    DefineStartLocation(0, 0.0, -1408.0)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
end
