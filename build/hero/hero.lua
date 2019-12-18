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
