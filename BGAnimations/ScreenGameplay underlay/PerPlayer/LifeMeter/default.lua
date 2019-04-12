local player = ...
if SL[ToEnumShortString(player)].ActiveModifiers.HideLifebar then return end

local lifemeter_actor

-- in StomperZ, the LifeMeterType is forced to be Surround-StomperZ style in all its purple glory
if SL.Global.GameMode == "Competitive" then

	local lifemeter_type = SL[ToEnumShortString(player)].ActiveModifiers.LifeMeterType or CustomOptionRow("LifeMeterType").Choices[1]
	lifemeter_actor = LoadActor(lifemeter_type .. ".lua", player)
end

-- Casual doesn't have a LifeMeter, so in Casual GameMode,
-- lifemeter_actor will be returned as nil
return lifemeter_actor