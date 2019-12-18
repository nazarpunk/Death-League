function InitGlobals()
end

function CreateUnitsForPlayer0()
    local p = Player(0)
    local u
    local unitID
    local t
    local life
    u = CreateUnit(p, FourCC("Hpal"), -343.3, 784.6, -82.940)
    u = CreateUnit(p, FourCC("Hblm"), 576.7, 846.2, -79.178)
    u = CreateUnit(p, FourCC("Ulic"), 437.3, 819.1, -60.582)
    u = CreateUnit(p, FourCC("Udre"), -174.5, 799.2, -84.605)
    u = CreateUnit(p, FourCC("Edem"), 258.9, 815.6, 259.169)
    u = CreateUnit(p, FourCC("Ewar"), 61.1, 823.8, -81.033)
end

function CreatePlayerBuildings()
end

function CreatePlayerUnits()
    CreateUnitsForPlayer0()
end

function CreateAllUnits()
    CreatePlayerBuildings()
    CreatePlayerUnits()
end

--CUSTOM_CODE
do	local IS_VISIBLE        = true -- is visible on map start	local InitGlobalsOrigin = InitGlobals	function InitGlobals()		InitGlobalsOrigin()				local GAME_UI = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)		local menu    = BlzCreateFrame('LoadingPlayerSlot', GAME_UI, 0, 0)		BlzFrameSetSize(menu, 0.256, 0.0217)		BlzFrameSetPoint(menu, FRAMEPOINT_BOTTOM, GAME_UI, FRAMEPOINT_BOTTOM, 0, 0.16)		BlzFrameSetVisible(menu, IS_VISIBLE)				local left  = BlzGetFrameByName('LoadingPlayerSlotName', 0)		local right = BlzGetFrameByName('LoadingPlayerSlotRace', 0)		BlzFrameSetVisible(BlzGetFrameByName('LoadingPlayerSlotReadyHighlight', 0), true)				local ChatTrigger = CreateTrigger()		for i = 0, bj_MAX_PLAYER_SLOTS - 1 do			TriggerRegisterPlayerChatEvent(ChatTrigger, Player(i), '-', false)		end				TriggerAddAction(ChatTrigger, function()			local param = {}			for w in GetEventPlayerChatString():gmatch('[^%s]+') do				table.insert(param, w)			end			if param[1] ~= '-garbage' then return end			local arg = param[2]			if arg == 'collect' or arg == 'stop' or arg == 'restart' then				print('collectgarbage(' .. arg .. ')')				collectgarbage(arg)			elseif arg == 'count' or arg == 'isrunning' or arg == 'step' then				print('collectgarbage(' .. arg .. ') -->', collectgarbage(arg))			elseif arg == 'show' then				BlzFrameSetVisible(menu, true)			elseif arg == 'hide' then				BlzFrameSetVisible(menu, false)			end		end)				local t = CreateTimer()		TimerStart(t, 0.025, true, function()			BlzFrameSetText(left, math.ceil(collectgarbage('count')))			BlzFrameSetText(right, math.ceil(os.clock()))		end)	endend
---@param x real---@param distance real---@param angle real radian---@return realfunction math.offsetX(x, distance, angle)	return distance * math.cos(angle) + xend---@param y real---@param distance real---@param angle real radian---@return realfunction math.offsetY(y, distance, angle)	return distance * math.sin(angle) + yend---@param x real---@param y real---@param distance real---@param angle real radian---@return real, realfunction math.offsetXY(x, y, distance, angle)	return distance * math.cos(angle) + x, distance * math.sin(angle) + yend---@param zs real начальная высота одного края дуги---@param ze real конечная высота другого края дуги---@param h real максимальная высота на середине расстояния (x = d / 2)---@param d real общее расстояние до цели---@param x real расстояние от исходной цели до точки---@return realfunction math.parabolaZ(zs, ze, h, d, x)	return (2 * (zs + ze - 2 * h) * (x / d - 1) + ze - zs) * (x / d) + zsend---@param xa real---@param ya real---@param xb real---@param yb real---@return realfunction math.distanceXY(xa, ya, xb, yb)	local dx, dy = xb - xa, yb - ya	return math.sqrt(dx * dx + dy * dy)end---@param xa real---@param ya real---@param za real---@param xb real---@param yb real---@param zb real---@return realfunction math.distanceXYZ(xa, ya, za, xb, yb, zb)	local dx, dy, dz = xb - xa, yb - ya, zb - za	return math.sqrt(dx * dx + dy * dy + dz * dz)end---@param xa real---@param ya real---@param xb real---@param yb real---@return real radianfunction math.angleXY(xa, ya, xb, yb)	return math.atan(yb - ya, xb - xa)end---@param a real radian---@param b real radian---@return real radianfunction math.angleDiff(a, b)	local c = a > b and a - b or b - a	local d = a > b and b - a + 2 * math.pi or a - b + 2 * math.pi	return c > d and d or cend--https://xgm.guru/p/wc3/iscoordsincircle-- Проверяет, находится ли [x,y] в окружности [cx,cy] радиусом r---@param x table---@param y table---@param cx table---@param cy table---@param r table---@return booleanfunction math.inCircleXY(x, y, cx, cy, r)	return (cx - x) * (cx - x) + (cy - y) * (cy - y) < r * rend-- xgm.guru/p/wc3/warden-math---@param a real degrees---@param b real degrees---@return real degreesfunction math.angleDiffDeg(a, b)	a, b = math.abs(a), math.abs(b)	if a > b then		a, b = b, a	end	local x = b - 360	if b - a > a - x then		b = x	end	return math.abs(a - b)end-- https://xgm.guru/p/wc3/perpendicular-- Находит длину перпендикуляра от линии проходящей через [xa, ya][xb, yb] к точке [xc, yc]---@param xa real---@param ya real---@param xb real---@param yb real---@param xc real---@param yc real---@return realfunction math.perpendicular(xa, ya, xb, yb, xc, yc)	return math.sqrt((xa - xc) * (xa - xc) + (ya - yc) * (ya - yc)) * math.sin(math.atan(yc - ya, xc - xa) - math.atan(yb - ya, xb - xa))end
do	local RANGE             = 10 -- Расстояние, на котором проходит проверка	local DUMMY             = FourCC('wolg') -- Ид предмета для проверки проходимости		local rect---@type rect	local item ---@type item		local InitGlobalsOrigin = InitGlobals	function InitGlobals()		InitGlobalsOrigin()		rect = Rect(0, 0, 128, 128)		item = CreateItem(DUMMY, 0, 0)		SetItemVisible(item, false)	end		local items = {}	local function hide()		local target = GetEnumItem()		if not IsItemVisible(target) then return end		table.insert(items, target)		SetItemVisible(target, false)	end		---@param x real	---@param y real	---@return boolean	function IsTerrainWalkable(x, y)		MoveRectTo(rect, x, y)		EnumItemsInRect(rect, nil, hide)				SetItemPosition(item, x, y)		local dx = GetItemX(item) - x		local dy = GetItemY(item) - y		SetItemVisible(item, false)				for i = 1, #items do			SetItemVisible(items[i], true)		end		items = {}				return dx * dx + dy * dy <= RANGE * RANGE and not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY)	endend---@param x real---@param y real---@return booleanfunction IsTerrainDeepWater (x, y)	return not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY) and IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY)end---@param x real---@param y real---@return booleanfunction IsTerrainShallowWater (x, y)	return not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY) and not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) and IsTerrainPathable(x, y, PATHING_TYPE_BUILDABILITY)end---@param x real---@param y real---@return booleanfunction IsTerrainLand(x, y)	return IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY)end---@param x real---@param y real---@return booleanfunction IsTerrainPlatform (x, y)	return not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY) and not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) and not IsTerrainPathable(x, y, PATHING_TYPE_BUILDABILITY)end
do
	local InitGlobalsOrigin = InitGlobals
	function InitGlobals()
		InitGlobalsOrigin()
		
		print(123)
	end
end
--CUSTOM_CODE
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
end

function config()
    SetMapName("TRIGSTR_001")
    SetMapDescription("TRIGSTR_003")
    SetPlayers(1)
    SetTeams(1)
    SetGamePlacement(MAP_PLACEMENT_USE_MAP_SETTINGS)
    DefineStartLocation(0, -2688.0, 2560.0)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
end

