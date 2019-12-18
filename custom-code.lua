--CUSTOM_CODE
---@param x real---@param distance real---@param angle real radian---@return realfunction math.offsetX(x, distance, angle)	return distance * math.cos(angle) + xend---@param y real---@param distance real---@param angle real radian---@return realfunction math.offsetY(y, distance, angle)	return distance * math.sin(angle) + yend---@param x real---@param y real---@param distance real---@param angle real radian---@return real, realfunction math.offsetXY(x, y, distance, angle)	return distance * math.cos(angle) + x, distance * math.sin(angle) + yend---@param zs real начальная высота одного края дуги---@param ze real конечная высота другого края дуги---@param h real максимальная высота на середине расстояния (x = d / 2)---@param d real общее расстояние до цели---@param x real расстояние от исходной цели до точки---@return realfunction math.parabolaZ(zs, ze, h, d, x)	return (2 * (zs + ze - 2 * h) * (x / d - 1) + ze - zs) * (x / d) + zsend---@param xa real---@param ya real---@param xb real---@param yb real---@return realfunction math.distanceXY(xa, ya, xb, yb)	local dx, dy = xb - xa, yb - ya	return math.sqrt(dx * dx + dy * dy)end---@param xa real---@param ya real---@param za real---@param xb real---@param yb real---@param zb real---@return realfunction math.distanceXYZ(xa, ya, za, xb, yb, zb)	local dx, dy, dz = xb - xa, yb - ya, zb - za	return math.sqrt(dx * dx + dy * dy + dz * dz)end---@param xa real---@param ya real---@param xb real---@param yb real---@return real radianfunction math.angleXY(xa, ya, xb, yb)	return math.atan(yb - ya, xb - xa)end---@param a real radian---@param b real radian---@return real radianfunction math.angleDiff(a, b)	local c = a > b and a - b or b - a	local d = a > b and b - a + 2 * math.pi or a - b + 2 * math.pi	return c > d and d or cend--https://xgm.guru/p/wc3/iscoordsincircle-- Проверяет, находится ли [x,y] в окружности [cx,cy] радиусом r---@param x table---@param y table---@param cx table---@param cy table---@param r table---@return booleanfunction math.inCircleXY(x, y, cx, cy, r)	return (cx - x) * (cx - x) + (cy - y) * (cy - y) < r * rend-- xgm.guru/p/wc3/warden-math---@param a real degrees---@param b real degrees---@return real degreesfunction math.angleDiffDeg(a, b)	a, b = math.abs(a), math.abs(b)	if a > b then		a, b = b, a	end	local x = b - 360	if b - a > a - x then		b = x	end	return math.abs(a - b)end-- https://xgm.guru/p/wc3/perpendicular-- Находит длину перпендикуляра от линии проходящей через [xa, ya][xb, yb] к точке [xc, yc]---@param xa real---@param ya real---@param xb real---@param yb real---@param xc real---@param yc real---@return realfunction math.perpendicular(xa, ya, xb, yb, xc, yc)	return math.sqrt((xa - xc) * (xa - xc) + (ya - yc) * (ya - yc)) * math.sin(math.atan(yc - ya, xc - xa) - math.atan(yb - ya, xb - xa))end
do	local RANGE             = 10 -- Расстояние, на котором проходит проверка	local DUMMY             = FourCC('wolg') -- Ид предмета для проверки проходимости		local rect---@type rect	local item ---@type item		local InitGlobalsOrigin = InitGlobals	function InitGlobals()		InitGlobalsOrigin()		rect = Rect(0, 0, 128, 128)		item = CreateItem(DUMMY, 0, 0)		SetItemVisible(item, false)	end		local items = {}	local function hide()		local target = GetEnumItem()		if not IsItemVisible(target) then return end		table.insert(items, target)		SetItemVisible(target, false)	end		---@param x real	---@param y real	---@return boolean	function IsTerrainWalkable(x, y)		MoveRectTo(rect, x, y)		EnumItemsInRect(rect, nil, hide)				SetItemPosition(item, x, y)		local dx = GetItemX(item) - x		local dy = GetItemY(item) - y		SetItemVisible(item, false)				for i = 1, #items do			SetItemVisible(items[i], true)		end		items = {}				return dx * dx + dy * dy <= RANGE * RANGE and not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY)	endend---@param x real---@param y real---@return booleanfunction IsTerrainDeepWater (x, y)	return not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY) and IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY)end---@param x real---@param y real---@return booleanfunction IsTerrainShallowWater (x, y)	return not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY) and not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) and IsTerrainPathable(x, y, PATHING_TYPE_BUILDABILITY)end---@param x real---@param y real---@return booleanfunction IsTerrainLand(x, y)	return IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY)end---@param x real---@param y real---@return booleanfunction IsTerrainPlatform (x, y)	return not IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY) and not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) and not IsTerrainPathable(x, y, PATHING_TYPE_BUILDABILITY)end
do
	local InitGlobalsOrigin = InitGlobals
	function InitGlobals()
		InitGlobalsOrigin()
		
		-- enter map
		local heroEnterTrigger = CreateTrigger()
		local mapRegion        = CreateRegion()
		RegionAddRect(mapRegion, bj_mapInitialPlayableArea)
		for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
			TriggerRegisterEnterRegion(heroEnterTrigger, mapRegion, nil)
		end
		TriggerAddAction(heroEnterTrigger, function()
			local unit   = GetTriggerUnit()
			local player = GetOwningPlayer(unit)
			if GetPlayerController(player) ~= MAP_CONTROL_USER or
					GetPlayerSlotState(player) ~= PLAYER_SLOT_STATE_PLAYING or
					not IsUnitType(unit, UNIT_TYPE_HERO) or
					IsUnitIllusion(unit)
			then return end
			if GetLocalPlayer() == player then
				SelectUnit(unit, true)
				PanCameraToTimed(GetUnitX(unit), GetUnitY(unit), 0)
				print('catch')
				AddUnitToStock(unit, FourCC('hfoo'), 10, 10)
				AddItemToStock(unit, FourCC('aup1'), 10, 10)
			end
		end)
		
		-- item update
		local ItemTrigger = CreateTrigger()
		for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
			local player = Player(i)
			TriggerRegisterPlayerUnitEvent(ItemTrigger, player, EVENT_PLAYER_UNIT_PICKUP_ITEM)
			TriggerRegisterPlayerUnitEvent(ItemTrigger, player, EVENT_PLAYER_UNIT_DROP_ITEM)
			TriggerRegisterPlayerUnitEvent(ItemTrigger, player, EVENT_PLAYER_UNIT_SELL_ITEM)
			TriggerRegisterPlayerUnitEvent(ItemTrigger, player, EVENT_PLAYER_UNIT_USE_ITEM)
			TriggerRegisterPlayerUnitEvent(ItemTrigger, player, EVENT_PLAYER_UNIT_PAWN_ITEM)
		end
		
		TriggerAddAction(ItemTrigger, function()
			local eventId       = GetHandleId(GetTriggerEventId())
			local isEventPickUp = eventId == GetHandleId(EVENT_PLAYER_UNIT_PICKUP_ITEM)
			local isEventDrop   = eventId == GetHandleId(EVENT_PLAYER_UNIT_DROP_ITEM)
			local isEventSell   = eventId == GetHandleId(EVENT_PLAYER_UNIT_SELL_ITEM)
			local isEventUse    = eventId == GetHandleId(EVENT_PLAYER_UNIT_USE_ITEM)
			local isEventPawn   = eventId == GetHandleId(EVENT_PLAYER_UNIT_PAWN_ITEM)
			
			--{ FIXME DEBUG
			if true then
				print('-----------------------')
				print('pickup', isEventPickUp)
				print('drop', isEventDrop)
				print('sell', isEventSell)
				print('use', isEventUse)
				print('pawn', isEventPawn)
			end
			--}
		end)
		
		-- create test unit
		CreateUnit(Player(0), FourCC('Hpal'), 0, 0, 0)
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