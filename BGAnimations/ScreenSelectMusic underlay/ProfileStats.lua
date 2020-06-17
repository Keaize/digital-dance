local player = ...
local SongsInSet = SL.Global.Stages.PlayedThisGame
local nsj = GAMESTATE:GetNumSidesJoined()

local P1 = GAMESTATE:IsHumanPlayer(PLAYER_1)
local P2 = GAMESTATE:IsHumanPlayer(PLAYER_2)

local p1profile = PROFILEMAN:GetProfile(0)
local p2profile = PROFILEMAN:GetProfile(1)

local P1numSongsPlayed = p1profile:GetNumTotalSongsPlayed()
local P1numRollsHit = p1profile:GetTotalRolls()
local P1numStepsHit = p1profile:GetTotalTapsAndHolds()
local P1numTotalSteps = ""

local P2numSongsPlayed = p2profile:GetNumTotalSongsPlayed()
local P2numRollsHit = p2profile:GetTotalRolls()
local P2numStepsHit = p2profile:GetTotalTapsAndHolds()
local P2numTotalSteps = ""



-------------------------------------------------------- CALCULATIONS -------------------------------------------------------

-- We don't calculate average bpm or difficulty here because of reasons. Go to 'ScreenEvaluationStage underlay.lua' for those

-- this is for showing what song you're on

-- Stepmania doesn't have a way to count steps, holds, and rolls at once so we have to do it manually
if P1numRollsHit == 0 then
	P1numTotalSteps = P1numStepsHit
else
	P1numTotalSteps = P1numRollsHit + P1numStepsHit
end

if P2numRollsHit == 0 then
	P2numTotalSteps = P2numStepsHit
else
	P2numTotalSteps = P2numRollsHit + P2numStepsHit
end

-- this is for steps per set
P1REALStepsPerSet = P1numTotalSteps - Player1StartingSteps
P2REALStepsPerSet = P2numTotalSteps - Player2StartingSteps

------------------- This is to make our numbers behave properly -------------------------------

-- for commas
local function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

-- for decimals
local function RoundTen(num, numDecimalPlaces)
  local mult = 10^(2 or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- This is to prevent logic issues
if SongsInSet == 0 then
P1SongsInSet = 0
P2SongsInSet = 0
SongsInSet = 0
AverageBPMPlayer1 = 0
AverageBPMPlayer2 = 0
TotalBPMPlayer1 = 0
TotalBPMPlayer2 = 0
TotalDifficultyPlayer1 = 0 
TotalDifficultyPlayer2 = 0
end

if P1SongsInSet == 0 then
P1SongsInSet = 0
AverageDifficultyPlayer1 = 0
P1REALStepsPerSet = 0
Player1StartingSteps = P1numTotalSteps

end

if P2SongsInSet == 0 then
P2SongsInSet = 0
AverageDifficultyPlayer2 = 0
P2REALStepsPerSet = 0
Player2StartingSteps = P2numTotalSteps
end

------------- it's time to d-d-d-d-d-d-d-reload our functions ----------------
local function getInputHandler(actor, player)
	return (function(event)
		if event.GameButton == "Start" and event.PlayerNumber == player and GAMESTATE:IsHumanPlayer(event.PlayerNumber) then
			actor:visible(true)
		end
	end)
end

local t = Def.ActorFrame{
	Name="DifficultyJawn",
	InitCommand=cmd(vertalign, top; draworder, 107),

	------------------------------------------ Player 1 STATS---------------------------------------------
	
		-- # of songs played this set
 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#FFFFFF"))
				self:visible(P1)
				self:horizalign(left)
				self:maxwidth(90)
				self:x(WideScale(160,202))
				self:y(WideScale(25,28))
				self:zoom(WideScale(0.6,0.7))
				self:settext(P1SongsInSet)
			elseif nsj == 1 then
				self:diffuse(color("#FFFFFF"))
				self:visible(P1)
				self:horizalign(center)
				self:maxwidth(140)
				self:x(198)
				self:y(398)
				self:zoom(0.75)
				self:settext(P1SongsInSet .. " / " .. comma_value(P1numSongsPlayed))
			else
				self:visible(false)
			end
			
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
	-- # of songs played lifetime
 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#FFFFFF"))
				self:visible(P1)
				self:horizalign(left)
				self:maxwidth(112)
				self:x(WideScale(146,186))
				self:y(WideScale(40,43))
				self:zoom(WideScale(0.6,0.7))
				self:settext(comma_value(P1numSongsPlayed))
			else
				self:visible(false)
			end
			
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
	
	-- # of steps hit set
 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#FFFFFF"))
				self:visible(P1)
				self:horizalign(left)
				self:maxwidth(112)
				self:x(WideScale(142,178))
				self:y(WideScale(53,58))
				self:zoom(WideScale(0.6,0.7))
				self:settext(comma_value(P1REALStepsPerSet))
			elseif nsj == 1 then
				self:diffuse(color("#FFFFFF"))
				self:visible(P1)
				self:horizalign(center)
				self:maxwidth(300)
				self:x(198)
				self:y(425)
				self:zoom(0.7)
				self:settext(comma_value(P1REALStepsPerSet) .. " / " .. comma_value(P1numTotalSteps))
			else
				self:visible(false)
			end
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
	
		-- # of steps hit lifetime
 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#FFFFFF"))
				self:visible(P1)
				self:horizalign(left)
				self:maxwidth(114)
				self:x(WideScale(146,184))
				self:y(WideScale(67,73))
				self:zoom(WideScale(0.6,0.7))
				self:settext(comma_value(P1numTotalSteps))
			else
				self:visible(false)
			end
			
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
	-- Average difficulty
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#FFFFFF"))
				self:visible(P1)
				self:horizalign(left)
				self:maxwidth(90)
				self:x(WideScale(160,203))
				self:y(WideScale(81,88))
				self:zoom(WideScale(0.6,0.7))
				self:settext(RoundTen(AverageDifficultyPlayer1))
			elseif nsj == 1 then
				self:diffuse(color("#FFFFFF"))
				self:visible(P1)
				self:horizalign(left)
				self:maxwidth(120)
				self:x(176)
				self:y(440)
				self:zoom(0.75)
				self:settext(RoundTen(AverageDifficultyPlayer1))
			else
				self:visible(false)
			end
			
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
	-- Average BPM
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#FFFFFF"))
				self:visible(P1)
				self:horizalign(left)
				self:maxwidth(90)
				self:x(WideScale(133,169))
				self:y(WideScale(95,103))
				self:zoom(WideScale(0.6,0.7))
				self:settext(RoundTen(AverageBPMPlayer1))
			elseif nsj == 1 then
				self:diffuse(color("#FFFFFF"))
				self:visible(P1)
				self:horizalign(left)
				self:maxwidth(100)
				self:x(260)
				self:y(440)
				self:zoom(0.75)
				self:settext(RoundTen(AverageBPMPlayer1))
			else
				self:visible(false)
			end
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
		------------------------------------------ Player 2 STATS---------------------------------------------
		-- # of songs played this set
 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#FFFFFF"))
				self:visible(P2)
				self:horizalign(left)
				self:maxwidth(90)
				self:x(WideScale(633,790))
				self:y(WideScale(25,28))
				self:zoom(WideScale(0.6,0.7))
				self:settext(P2SongsInSet)
			elseif nsj == 1 then
				self:diffuse(color("#FFFFFF"))
				self:visible(P2)
				self:horizalign(center)
				self:maxwidth(140)
				self:x(198)
				self:y(398)
				self:zoom(0.75)
				self:settext(P2SongsInSet .. " / " .. comma_value(P2numSongsPlayed))
			else
				self:visible(false)
			end
			
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},
-- # of songs played lifetime
 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#FFFFFF"))
				self:visible(P2)
				self:horizalign(left)
				self:maxwidth(112)
				self:x(WideScale(620,773))
				self:y(WideScale(40,43))
				self:zoom(WideScale(0.6,0.7))
				self:settext(comma_value(P2numSongsPlayed))
			else
				self:visible(false)
			end
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},
	-- steps hit in set
	Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#FFFFFF"))
				self:visible(P2)
				self:horizalign(left)
				self:maxwidth(112)
				self:x(WideScale(615,766))
				self:y(WideScale(53,58))
				self:zoom(WideScale(0.6,0.7))
				self:settext(comma_value(P2REALStepsPerSet))
			elseif nsj == 1 then
				self:diffuse(color("#FFFFFF"))
				self:visible(P2)
				self:horizalign(center)
				self:maxwidth(112)
				self:x(198)
				self:y(425)
				self:zoom(0.75)
				self:settext(comma_value(P2REALStepsPerSet) .. " / " .. comma_value(P2numTotalSteps))
			else
				self:visible(false)
			end
			
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},
		-- # of steps hit lifetime
 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#FFFFFF"))
				self:visible(P2)
				self:horizalign(left)
				self:maxwidth(300)
				self:x(WideScale(618,772))
				self:y(WideScale(67,73))
				self:zoom(WideScale(0.6,0.7))
				self:settext(comma_value(P2numTotalSteps))
			else
				self:visible(false)
			end
			
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},
		-- Average Difficulty
 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#FFFFFF"))
				self:visible(P2)
				self:horizalign(left)
				self:maxwidth(114)
				self:x(WideScale(632,790))
				self:y(WideScale(81,88))
				self:zoom(WideScale(0.6,0.7))
				self:settext(RoundTen(AverageDifficultyPlayer2))
			elseif nsj == 1 then
				self:diffuse(color("#FFFFFF"))
				self:visible(P2)
				self:horizalign(left)
				self:maxwidth(120)
				self:x(176)
				self:y(440)
				self:zoom(0.75)
				self:settext(RoundTen(AverageDifficultyPlayer2))
			else
				self:visible(false)
			end
			
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},
		-- Average BPM
 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#FFFFFF"))
				self:visible(P2)
				self:horizalign(left)
				self:maxwidth(114)
				self:x(WideScale(608,756))
				self:y(WideScale(95,103))
				self:zoom(WideScale(0.6,0.7))
				self:settext(RoundTen(AverageBPMPlayer2))
			elseif nsj == 1 then
				self:diffuse(color("#FFFFFF"))
				self:visible(P2)
				self:horizalign(left)
				self:maxwidth(100)
				self:x(260)
				self:y(440)
				self:zoom(0.75)
				self:settext(RoundTen(AverageBPMPlayer2))
			else
				self:visible(false)
			end
			
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},
}

return t