-- this is to calculate the average bpm but not let it increment unless the song was finished. HELP
local LastBPM = GetLowerDisplayBPM()
local SongInSet = SL.Global.Stages.PlayedThisGame
local SongsInSet = SongInSet + 1
local P1 = GAMESTATE:IsHumanPlayer(PLAYER_1)
local P2 = GAMESTATE:IsHumanPlayer(PLAYER_2)


TheCurrentSongBPM = GetLowerDisplayBPM()
TotalBPM = LastBPM + TotalBPM

-- insert more junk for calculating average difficulty here
local PlayerOneChart = GAMESTATE:GetCurrentSteps(0)
local PlayerTwoChart = GAMESTATE:GetCurrentSteps(1)

local PlayerOneDifficulty = PlayerOneChart:GetMeter()
local PlayerTwoDifficulty = PlayerTwoChart:GetMeter()

if SongInSet == 0 or nil then
TotalDifficultyPlayer1 = 0
TotalDifficultyPlayer2 = 0
else
end


if P1 then
P1SongsInSet = P1SongsInSet + 1
TotalBPMPlayer1 = LastBPM + TotalBPMPlayer1
AverageBPMPlayer1 = TotalBPMPlayer1 / P1SongsInSet
TotalDifficultyPlayer1 = PlayerOneDifficulty + TotalDifficultyPlayer1
AverageDifficultyPlayer1 = TotalDifficultyPlayer1 / P1SongsInSet
end

if P2 then
P2SongsInSet = P2SongsInSet + 1
TotalBPMPlayer2 = LastBPM + TotalBPMPlayer2
AverageBPMPlayer2 = TotalBPMPlayer2 / P2SongsInSet
TotalDifficultyPlayer2 = PlayerTwoDifficulty + TotalDifficultyPlayer2
AverageDifficultyPlayer2 = TotalDifficultyPlayer2 / P2SongsInSet
end





return Def.ActorFrame { }