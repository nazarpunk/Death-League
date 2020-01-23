gg_trg_s = nil
function InitGlobals()
end

function CreateNeutralPassive()
    local p = Player(PLAYER_NEUTRAL_PASSIVE)
    local u
    local unitID
    local t
    local life
    u = CreateUnit(p, FourCC("hfoo"), -207.6, 1028.5, 85.103)
    u = CreateUnit(p, FourCC("hfoo"), -377.6, 961.2, 355.638)
    u = CreateUnit(p, FourCC("hfoo"), -689.0, 1065.7, 80.609)
    u = CreateUnit(p, FourCC("hfoo"), -242.1, 965.1, 244.959)
    u = CreateUnit(p, FourCC("hfoo"), 65.3, 937.9, 240.454)
    u = CreateUnit(p, FourCC("hfoo"), 56.9, 775.8, 320.569)
    u = CreateUnit(p, FourCC("hfoo"), 186.2, 576.1, 119.161)
    u = CreateUnit(p, FourCC("hfoo"), 171.2, 724.7, 265.328)
    u = CreateUnit(p, FourCC("hfoo"), 85.4, 1012.2, 330.819)
    u = CreateUnit(p, FourCC("hfoo"), 196.7, 996.4, 269.426)
    u = CreateUnit(p, FourCC("hfoo"), 353.5, 838.9, 284.928)
    u = CreateUnit(p, FourCC("hfoo"), 439.3, 624.9, 8.130)
    u = CreateUnit(p, FourCC("hfoo"), 425.3, 450.9, 305.748)
    u = CreateUnit(p, FourCC("hfoo"), 293.8, 590.0, 261.636)
    u = CreateUnit(p, FourCC("hfoo"), 260.7, 772.1, 81.675)
    u = CreateUnit(p, FourCC("hfoo"), 245.2, 853.9, 299.507)
    u = CreateUnit(p, FourCC("hfoo"), 321.9, 444.2, 36.904)
    u = CreateUnit(p, FourCC("hfoo"), 159.6, 467.5, 187.487)
    u = CreateUnit(p, FourCC("hfoo"), 242.7, 521.3, 299.661)
    u = CreateUnit(p, FourCC("hfoo"), 503.5, 514.6, 304.166)
    u = CreateUnit(p, FourCC("hfoo"), 527.0, 649.5, 153.945)
    u = CreateUnit(p, FourCC("hfoo"), 614.6, 484.2, 139.410)
    u = CreateUnit(p, FourCC("hfoo"), 651.0, 251.9, 247.453)
    u = CreateUnit(p, FourCC("hfoo"), 648.0, 124.3, 282.148)
    u = CreateUnit(p, FourCC("hfoo"), 472.5, 289.4, 62.855)
    u = CreateUnit(p, FourCC("hfoo"), 472.0, 359.4, 305.594)
    u = CreateUnit(p, FourCC("hfoo"), 581.8, 242.6, 218.799)
    u = CreateUnit(p, FourCC("hfoo"), 715.1, 172.2, 252.968)
    u = CreateUnit(p, FourCC("hfoo"), 684.4, 333.7, 143.771)
    u = CreateUnit(p, FourCC("hfoo"), 741.5, 7.7, 194.079)
    u = CreateUnit(p, FourCC("hfoo"), 723.0, -186.9, 223.864)
    u = CreateUnit(p, FourCC("hfoo"), 684.5, -324.4, 316.965)
    u = CreateUnit(p, FourCC("hfoo"), 629.0, -450.9, 286.225)
    u = CreateUnit(p, FourCC("hfoo"), 566.6, 39.3, 247.661)
    u = CreateUnit(p, FourCC("hfoo"), 673.2, 10.6, 242.564)
    u = CreateUnit(p, FourCC("hfoo"), 758.4, -93.2, 316.998)
    u = CreateUnit(p, FourCC("hfoo"), 774.5, -218.9, 38.201)
    u = CreateUnit(p, FourCC("hfoo"), 742.7, -288.7, 284.203)
    u = CreateUnit(p, FourCC("hfoo"), 673.3, -396.1, 236.103)
    u = CreateUnit(p, FourCC("hfoo"), 600.9, -557.3, 247.793)
    u = CreateUnit(p, FourCC("hfoo"), 548.8, -592.6, 33.213)
    u = CreateUnit(p, FourCC("hfoo"), 533.2, -507.0, 164.723)
    u = CreateUnit(p, FourCC("hfoo"), 457.5, -578.5, 69.447)
    u = CreateUnit(p, FourCC("hfoo"), 422.7, -659.5, 98.419)
    u = CreateUnit(p, FourCC("hfoo"), 360.9, -746.0, 263.669)
    u = CreateUnit(p, FourCC("hfoo"), 308.4, -799.4, 140.091)
    u = CreateUnit(p, FourCC("hfoo"), 233.0, -841.0, 159.471)
    u = CreateUnit(p, FourCC("hfoo"), 528.4, -656.6, 218.821)
    u = CreateUnit(p, FourCC("hfoo"), 595.5, -720.3, 359.791)
    u = CreateUnit(p, FourCC("hfoo"), 615.7, -799.4, 335.840)
    u = CreateUnit(p, FourCC("hfoo"), 683.6, -621.2, 224.293)
    u = CreateUnit(p, FourCC("hfoo"), 719.9, -540.0, 276.479)
    u = CreateUnit(p, FourCC("hfoo"), 845.6, -377.0, 237.136)
    u = CreateUnit(p, FourCC("hfoo"), 921.4, -791.1, 306.385)
    u = CreateUnit(p, FourCC("hfoo"), 841.0, -582.4, 220.360)
    u = CreateUnit(p, FourCC("hfoo"), 978.9, -907.7, 234.774)
    u = CreateUnit(p, FourCC("hfoo"), 923.1, -950.3, 72.347)
    u = CreateUnit(p, FourCC("hfoo"), 695.7, -936.2, 178.116)
    u = CreateUnit(p, FourCC("hfoo"), 489.0, -860.1, 334.225)
    u = CreateUnit(p, FourCC("hfoo"), 468.0, -934.1, 316.119)
    u = CreateUnit(p, FourCC("hfoo"), 466.0, -1008.9, 236.334)
end

function CreatePlayerBuildings()
end

function CreatePlayerUnits()
end

function CreateAllUnits()
    CreatePlayerBuildings()
    CreateNeutralPassive()
    CreatePlayerUnits()
end

--CUSTOM_CODE
do
	local DamageTrigger = CreateTrigger()
	for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
		TriggerRegisterPlayerUnitEvent(DamageTrigger, Player(i), EVENT_PLAYER_UNIT_DAMAGING) -- до вычета брони
		TriggerRegisterPlayerUnitEvent(DamageTrigger, Player(i), EVENT_PLAYER_UNIT_DAMAGED) -- после вычета брони
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

-- https://xgm.guru/p/wc3/iscoordsincircle
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
--CUSTOM_CODE
function Trig_s_Actions()
end

function InitTrig_s()
    gg_trg_s = CreateTrigger()
    TriggerRegisterPlayerEventEndCinematic(gg_trg_s, Player(0))
    TriggerAddAction(gg_trg_s, Trig_s_Actions)
end

function InitCustomTriggers()
    InitTrig_s()
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
    CreateAllUnits()
    InitBlizzard()
    InitGlobals()
    InitCustomTriggers()
end

function config()
    SetMapName("TRIGSTR_003")
    SetMapDescription("")
    SetPlayers(1)
    SetTeams(1)
    SetGamePlacement(MAP_PLACEMENT_USE_MAP_SETTINGS)
    DefineStartLocation(0, 0.0, -1408.0)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
end

