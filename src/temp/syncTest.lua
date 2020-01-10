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