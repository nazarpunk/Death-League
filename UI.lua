do
	local InitGlobalsOrigin = InitGlobals
	function InitGlobals()
		InitGlobalsOrigin()
		
		FogEnable(false)
		FogMaskEnable(false)
		EnableMinimapFilterButtons(false, false)
		
		EnableDragSelect(false, false)
		EnablePreSelect(false, true)
		EnableSelect(false, false)
		
		BlzEnableUIAutoPosition(false)
		ShowInterface(false, 0)
		
		BlzLoadTOCFile('UI/Frame/Main.toc')
		
		local GameUI     = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
		local WorldFrame = BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)
		BlzFrameSetAllPoints(WorldFrame, GameUI)
		
		BlzFrameSetVisible(BlzGetOriginFrame(ORIGIN_FRAME_PORTRAIT, 0), false)
		
		local Map         = BlzGetOriginFrame(ORIGIN_FRAME_MINIMAP, 0)
		local MapBackdrop = BlzCreateFrame('Map-Backdrop', WorldFrame, 0, 0)
		BlzFrameSetSize(MapBackdrop, 0.15, 0.15)
		BlzFrameSetPoint(MapBackdrop, FRAMEPOINT_CENTER, Map, FRAMEPOINT_CENTER, 0, 0)
		local MapBtnPing = BlzGetOriginFrame(ORIGIN_FRAME_MINIMAP_BUTTON, 0)
		BlzFrameClearAllPoints(MapBtnPing)
		BlzFrameSetPoint(MapBtnPing, FRAMEPOINT_TOPRIGHT, MapBackdrop, FRAMEPOINT_TOPLEFT, 0, 0)
		local MapBtnOpacity = BlzGetOriginFrame(ORIGIN_FRAME_MINIMAP_BUTTON, 1)
		BlzFrameClearAllPoints(MapBtnOpacity)
		BlzFrameSetPoint(MapBtnOpacity, FRAMEPOINT_TOP, MapBtnPing, FRAMEPOINT_BOTTOM, 0, 0)
		for i = 2, 4 do
			BlzFrameSetVisible(BlzGetOriginFrame(ORIGIN_FRAME_MINIMAP_BUTTON, i), false)
		end
		
		local StatusBackdrop = BlzCreateFrame('Steel-Backdrop', WorldFrame, 0, 0)
		BlzFrameSetSize(StatusBackdrop, 0.172, 0.026)
		BlzFrameSetPoint(StatusBackdrop, FRAMEPOINT_BOTTOMLEFT, MapBackdrop, FRAMEPOINT_BOTTOMRIGHT, 0.170, 0)
		
		local HpBackdrop = BlzCreateFrame('HP-Backdrop', WorldFrame, 0, 0)
		BlzFrameSetSize(HpBackdrop, 0.168, 0.054)
		BlzFrameSetPoint(HpBackdrop, FRAMEPOINT_BOTTOMLEFT, MapBackdrop, FRAMEPOINT_BOTTOMRIGHT, 0.001, -0.008)
		
		local InfoBackdrop = BlzCreateFrame('Steel-Backdrop', WorldFrame, 0, 0)
		BlzFrameSetSize(InfoBackdrop, 0.172, 0.124)
		BlzFrameSetPoint(InfoBackdrop, FRAMEPOINT_BOTTOMLEFT, StatusBackdrop, FRAMEPOINT_TOPLEFT, 0, 0)
		BlzFrameSetPoint(InfoBackdrop, FRAMEPOINT_BOTTOMRIGHT, StatusBackdrop, FRAMEPOINT_TOPRIGHT, 0, 0)
		
		local IconAttack = BlzGetFrameByName('InfoPanelIconBackdrop', 0)
		BlzFrameClearAllPoints(IconAttack)
		BlzFrameSetPoint(IconAttack, FRAMEPOINT_TOPLEFT, InfoBackdrop, FRAMEPOINT_TOPLEFT, 0.008, -0.008)
		
		local IconArmor = BlzGetFrameByName('InfoPanelIconBackdrop', 2)
		BlzFrameClearAllPoints(IconArmor)
		BlzFrameSetPoint(IconArmor, FRAMEPOINT_LEFT, InfoBackdrop, FRAMEPOINT_LEFT, 0.008, 0)
		
		local IconAttr = BlzGetFrameByName('InfoPanelIconHeroIcon', 6)
		BlzFrameClearAllPoints(IconAttr)
		BlzFrameSetPoint(IconAttr, FRAMEPOINT_BOTTOMLEFT, InfoBackdrop, FRAMEPOINT_BOTTOMLEFT, 0.008, 0.008)
		
		local InfoFrames = { { '', 0 }, { '', 2 }, { 'HeroStrength', 6 }, { 'HeroAgility', 6 }, { 'HeroIntellect', 6 } }
		local InfoFrame  = {}
		for i = 1, #InfoFrames do
			InfoFrame[i] = BlzGetFrameByName('InfoPanelIcon' .. InfoFrames[i][1] .. 'Label', InfoFrames[i][2])
			BlzFrameClearAllPoints(InfoFrame[i])
			BlzFrameSetSize(InfoFrame[i], 0.05, BlzFrameGetHeight(InfoFrame[i]))
			local val = BlzGetFrameByName('InfoPanelIcon' .. InfoFrames[i][1] .. 'Value', InfoFrames[i][2])
			BlzFrameClearAllPoints(val)
			BlzFrameSetPoint(val, FRAMEPOINT_LEFT, InfoFrame[i], FRAMEPOINT_RIGHT, 0, 0)
		end
		
		local ResourceBar = BlzGetFrameByName('ResourceBarFrame', 0)
		BlzFrameSetSize(ResourceBar, 0, 0)
		
		local GoldIcon = BlzCreateFrame('Steel-Backdrop', WorldFrame, 0, 0)
		BlzFrameSetTexture(GoldIcon, 'UI/Widgets/ToolTips/Human/ToolTipGoldIcon.blp', 0, true)
		BlzFrameSetSize(GoldIcon, 0.018, 0.018)
		BlzFrameSetPoint(GoldIcon, FRAMEPOINT_RIGHT, InfoBackdrop, FRAMEPOINT_RIGHT, -0.038, 0.008)
		
		local GoldText = BlzGetFrameByName('ResourceBarGoldText', 0)
		BlzFrameClearAllPoints(GoldText)
		BlzFrameSetPoint(GoldText, FRAMEPOINT_LEFT, GoldIcon, FRAMEPOINT_LEFT, 0.018, 0)
		
		local LumberIcon = BlzCreateFrame('Steel-Backdrop', WorldFrame, 0, 0)
		BlzFrameSetTexture(LumberIcon, 'UI/Widgets/ToolTips/Human/ToolTipStonesIcon.blp', 0, true)
		BlzFrameSetSize(LumberIcon, 0.018, 0.018)
		BlzFrameSetPoint(LumberIcon, FRAMEPOINT_RIGHT, InfoBackdrop, FRAMEPOINT_RIGHT, -0.038, -0.008)
		
		local LumberText = BlzGetFrameByName('ResourceBarLumberText', 0)
		BlzFrameClearAllPoints(LumberText)
		BlzFrameSetPoint(LumberText, FRAMEPOINT_LEFT, LumberIcon, FRAMEPOINT_LEFT, 0.018, 0)
		
		BlzFrameSetSize(BlzGetOriginFrame(ORIGIN_FRAME_HERO_BUTTON, 0), 0, 0)
		
		local MpBar = BlzGetOriginFrame(ORIGIN_FRAME_HERO_MANA_BAR, 0)
		BlzFrameSetSize(MpBar, 0.08, 0.014)
		BlzFrameClearAllPoints(MpBar)
		BlzFrameSetPoint(MpBar, FRAMEPOINT_BOTTOMLEFT, HpBackdrop, FRAMEPOINT_BOTTOMLEFT, 0.004, 0.002)
		BlzFrameSetPoint(MpBar, FRAMEPOINT_BOTTOMRIGHT, HpBackdrop, FRAMEPOINT_BOTTOMRIGHT, -0.004, 0.002)
		
		local HpBar = BlzGetOriginFrame(ORIGIN_FRAME_HERO_HP_BAR, 0)
		BlzFrameSetSize(HpBar, 0.08, 0.014)
		BlzFrameClearAllPoints(HpBar)
		BlzFrameSetPoint(HpBar, FRAMEPOINT_BOTTOMLEFT, MpBar, FRAMEPOINT_TOPLEFT, 0, 0)
		BlzFrameSetPoint(HpBar, FRAMEPOINT_BOTTOMRIGHT, MpBar, FRAMEPOINT_TOPRIGHT, 0, 0)
		
		local LevelBar = BlzGetFrameByName('SimpleHeroLevelBar', 0)
		BlzFrameSetSize(LevelBar, 0.08, 0.014)
		BlzFrameClearAllPoints(LevelBar)
		BlzFrameSetPoint(LevelBar, FRAMEPOINT_BOTTOMLEFT, HpBar, FRAMEPOINT_TOPLEFT, 0, 0)
		BlzFrameSetPoint(LevelBar, FRAMEPOINT_BOTTOMRIGHT, HpBar, FRAMEPOINT_TOPRIGHT, 0, 0)
		
		local LevelVal = BlzGetFrameByName('SimpleNameValue', 0)
		BlzFrameClearAllPoints(LevelVal)
		BlzFrameSetPoint(LevelVal, FRAMEPOINT_CENTER, LevelBar, FRAMEPOINT_CENTER, 0.014, 0.016)
		
		local InvBackdrop = {}
		for i = 0, 5 do
			InvBackdrop[i] = BlzCreateFrame('Item-Backdrop', WorldFrame, 0, 0)
			BlzFrameSetSize(InvBackdrop[i], 0.042, 0.042)
			if i == 0 then
				BlzFrameSetPoint(InvBackdrop[i], FRAMEPOINT_TOPLEFT, InfoBackdrop, FRAMEPOINT_TOPRIGHT, 0, 0)
			elseif i < 2 then
				BlzFrameSetPoint(InvBackdrop[i], FRAMEPOINT_LEFT, InvBackdrop[i - 1], FRAMEPOINT_RIGHT, -0.001, 0)
			else
				BlzFrameSetPoint(InvBackdrop[i], FRAMEPOINT_TOP, InvBackdrop[i - 2], FRAMEPOINT_BOTTOM, 0, 0.001)
			end
			local item = BlzGetOriginFrame(ORIGIN_FRAME_ITEM_BUTTON, i)
			BlzFrameClearAllPoints(item)
			BlzFrameSetSize(item, 0.034, 0.034)
			BlzFrameSetPoint(item, FRAMEPOINT_CENTER, InvBackdrop[i], FRAMEPOINT_CENTER, 0, 0)
		end
		
		local BtnBackdrop = {}
		for i = 0, 7 do
			BtnBackdrop[i] = BlzCreateFrame('Button-Backdrop', WorldFrame, 0, 0)
			BlzFrameSetSize(BtnBackdrop[i], 0.0425, 0.0425)
			if i == 0 then
				BlzFrameSetPoint(BtnBackdrop[i], FRAMEPOINT_TOPLEFT, MapBackdrop, FRAMEPOINT_TOPRIGHT, 0, -0.016)
			elseif i < 4 then
				BlzFrameSetPoint(BtnBackdrop[i], FRAMEPOINT_LEFT, BtnBackdrop[i - 1], FRAMEPOINT_RIGHT, 0, 0)
			else
				BlzFrameSetPoint(BtnBackdrop[i], FRAMEPOINT_TOP, BtnBackdrop[i - 4], FRAMEPOINT_BOTTOM, 0, 0)
			end
		end
		
		local MenuBtn = {}
		for i = 0, 3 do
			MenuBtn[i] = BlzGetOriginFrame(ORIGIN_FRAME_SYSTEM_BUTTON, i)
			BlzFrameClearAllPoints(MenuBtn[i])
			if i == 0 then
				BlzFrameSetPoint(MenuBtn[i], FRAMEPOINT_BOTTOMLEFT, StatusBackdrop, FRAMEPOINT_BOTTOMRIGHT, 0, 0)
			else
				BlzFrameSetPoint(MenuBtn[i], FRAMEPOINT_LEFT, MenuBtn[i - 1], FRAMEPOINT_RIGHT, 0, 0)
			end
		end
		
		TimerStart(CreateTimer(), 0, false, function()
			BlzFrameSetPoint(InfoFrame[1], FRAMEPOINT_LEFT, IconAttack, FRAMEPOINT_RIGHT, 0, 0)
			BlzFrameSetPoint(InfoFrame[2], FRAMEPOINT_LEFT, IconArmor, FRAMEPOINT_RIGHT, 0, 0)
			BlzFrameSetPoint(InfoFrame[3], FRAMEPOINT_TOPLEFT, IconAttr, FRAMEPOINT_TOPRIGHT, 0, 0)
			BlzFrameSetPoint(InfoFrame[4], FRAMEPOINT_LEFT, IconAttr, FRAMEPOINT_RIGHT, 0, 0)
			BlzFrameSetPoint(InfoFrame[5], FRAMEPOINT_BOTTOMLEFT, IconAttr, FRAMEPOINT_BOTTOMRIGHT, 0, 0)
			
			for i = 0, 100 do
				BlzFrameSetVisible(BlzGetOriginFrame(ORIGIN_FRAME_PORTRAIT, i), false)
			end
			
			for i = 0, 11 do
				local btn = BlzGetOriginFrame(ORIGIN_FRAME_COMMAND_BUTTON, i)
				BlzFrameSetSize(btn, 0.034, 0.034)
				BlzFrameClearAllPoints(btn)
				if i <= 7 then
					BlzFrameSetPoint(btn, FRAMEPOINT_CENTER, BtnBackdrop[i], FRAMEPOINT_CENTER, 0, 0)
				else
					BlzFrameSetPoint(btn, FRAMEPOINT_TOPRIGHT, WorldFrame, FRAMEPOINT_BOTTOMLEFT, 0, 0)
				end
			end
			
			for i = 0, 3 do
				BlzFrameSetSize(MenuBtn[i], 0.07, 0.022)
			end
			
			local UberTooltip = BlzGetOriginFrame(ORIGIN_FRAME_UBERTOOLTIP, 0)
			BlzFrameClearAllPoints(UberTooltip)
			BlzFrameSetAbsPoint(UberTooltip, FRAMEPOINT_BOTTOM, 0.4, 0.16)
			
			ShowInterface(true, 0)
			
			BlzFrameSetAlpha(LevelBar, 100)
			BlzFrameSetAlpha(HpBar, 100)
			BlzFrameSetAlpha(MpBar, 100)
			
			DestroyTimer(GetExpiredTimer())
			
			local X, Y = GetPlayerStartLocationX(GetLocalPlayer()), GetPlayerStartLocationY(GetLocalPlayer())
			local HERO = CreateUnit(GetLocalPlayer(), FourCC('Ogrh'), X, Y, 270)
			
			SelectUnit(HERO, true)
			PanCameraToTimed(X, Y, 0)
		end)
		
		--{ TEST
		local V = 0
		local function change(add)
			V = V + add
			ClearTextMessages()
			print(V)
		end
		--} TEST
		
		--{ Debug frame values
		local OnKeyArrow = function(event, count)
			local OnKeyArrowTrigger = CreateTrigger()
			for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
				TriggerRegisterPlayerEvent(OnKeyArrowTrigger, Player(i), event)
			end
			TriggerAddAction(OnKeyArrowTrigger, function()
				change(count)
			end)
		end
		OnKeyArrow(EVENT_PLAYER_ARROW_UP_DOWN, 0.001)
		OnKeyArrow(EVENT_PLAYER_ARROW_DOWN_DOWN, -0.001)
		OnKeyArrow(EVENT_PLAYER_ARROW_LEFT_DOWN, 0.01)
		OnKeyArrow(EVENT_PLAYER_ARROW_RIGHT_DOWN, -0.01)
		--}
	end
end