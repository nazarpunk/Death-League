do
	--globals
	PLAYER_CAM_TARGET_X, PLAYER_CAM_TARGET_Y = {}, {}
	---@param player player
	---@return real,real
	function GetPlayerMouseXY(player)
		local playerId = GetPlayerId(player)
		return PLAYER_CAM_TARGET_X[playerId] or 0, PLAYER_CAM_TARGET_Y[playerId] or 0
	end
	-- locals
	local mouseMoveTrigger, mouseMoveSyncTrigger = CreateTrigger(), CreateTrigger()
	local prefixX, prefixY                       = 'SyncMouseX', 'SyncMouseY'
	-- events
	for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
		local player = Player(i)
		if GetPlayerController(player) == MAP_CONTROL_USER and GetPlayerSlotState(player) == PLAYER_SLOT_STATE_PLAYING then
			TriggerRegisterPlayerEvent(mouseMoveTrigger, player, EVENT_PLAYER_MOUSE_MOVE)
			BlzTriggerRegisterPlayerSyncEvent(mouseMoveSyncTrigger, player, prefixX, false)
			BlzTriggerRegisterPlayerSyncEvent(mouseMoveSyncTrigger, player, prefixY, false)
		end
	end
	-- actions
	TriggerAddAction(mouseMoveTrigger, function()
		local player = GetTriggerPlayer()
		BlzSendSyncData('SyncMouseX', BlzGetTriggerPlayerMouseX())
		BlzSendSyncData('SyncMouseY', BlzGetTriggerPlayerMouseY())
	
	end)
	TriggerAddAction(mouseMoveSyncTrigger, function()
		local data                            = BlzGetTriggerSyncPrefix() == prefixX and PLAYER_CAM_TARGET_X or PLAYER_CAM_TARGET_Y ---@type table
		data[GetPlayerId(GetTriggerPlayer())] = tonumber(BlzGetTriggerSyncData())
	end)
end