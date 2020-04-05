local player = ...
local pn = ToEnumShortString(player)
local p = PlayerNumber:Reverse()[player]
local show = false
local nsj = GAMESTATE:GetNumSidesJoined()

local function getInputHandler(actor)
    return (function (event)
	if event.GameButton == "MenuLeft" and event.PlayerNumber == player and GAMESTATE:IsHumanPlayer(event.PlayerNumber) and nsj == 1 then
        if event.type == "InputEventType_FirstPress" then
                show = false
                actor:queuecommand("UpdateGraphState")
		elseif event.type == "InputEventType_Release" or not GAMESTATE:IsHumanPlayer(event.PlayerNumber) then
                show = true
                actor:queuecommand("UpdateGraphState")
		end
	end
	if event.GameButton == "MenuRight" and event.PlayerNumber == player and GAMESTATE:IsHumanPlayer(event.PlayerNumber) and nsj == 1 then
        if event.type == "InputEventType_FirstPress" then
                show = false
                actor:queuecommand("UpdateGraphState")
		elseif event.type == "InputEventType_Release" or not GAMESTATE:IsHumanPlayer(event.PlayerNumber) then
                show = true
                actor:queuecommand("UpdateGraphState")
		end
	end
	if event.GameButton == "MenuLeft" and nsj == 2 then
        if event.type == "InputEventType_FirstPress" then
                show = false
                actor:queuecommand("UpdateGraphState")
		elseif event.type == "InputEventType_Release" then
                show = true
                actor:queuecommand("UpdateGraphState")
		end
	end
	if event.GameButton == "MenuRight" and nsj == 2 then
        if event.type == "InputEventType_FirstPress" then
                show = false
                actor:queuecommand("UpdateGraphState")
		elseif event.type == "InputEventType_Release" then
                show = true
                actor:queuecommand("UpdateGraphState")
		end
	end

        return false
    end)
end

local bannerWidth = IsUsingWideScreen() and WideScale(235,370) or 370
local bannerHeight = 160
local padding = 12

return Def.ActorFrame {
    -- song and course changes
    OnCommand=cmd(queuecommand, "StepsHaveChanged"),
    CurrentSongChangedMessageCommand=cmd(queuecommand, "StepsHaveChanged"),
    CurrentCourseChangedMessageCommand=cmd(queuecommand, "StepsHaveChanged"),

    InitCommand=function(self)
        local zoom, xPos

        if IsUsingWideScreen() then
            zoom = 0.7655
            xPos = WideScale(242,293)
        else
            zoom = 0.895
            xPos = 165
        end
		
		self:zoom(zoom)
        self:x(_screen.cx - xPos - ((bannerWidth / 2 - padding) * zoom))
		self:y(IsUsingWideScreen() and 275 - ((bannerHeight / 2 - padding) * zoom) or 359 - ((bannerHeight / 2 - padding) * zoom))

        if (player == PLAYER_1 and GAMESTATE:IsHumanPlayer(PLAYER_1)) then
            show = true
        end

        if (player == PLAYER_2 and GAMESTATE:IsHumanPlayer(PLAYER_2)) then
            show = true
            if IsUsingWideScreen() then
				self:addx(WideScale(482,587))
			else
				--self:addx(330)
				self:addy(-80)
			end
        end

        self:diffusealpha(0)
        self:queuecommand("Capture")
    end,

    CaptureCommand=function(self)
        SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self))
    end,
    
    StepsHaveChangedCommand=function(self, params)
        if show then
            self:queuecommand("UpdateGraphState")
        end
    end,

    PlayerJoinedMessageCommand=function(self, params)
        nsj = GAMESTATE:GetNumSidesJoined()
		if params.Player == player then
            self:playcommand("Init")
		end
	end,

    UpdateGraphStateCommand=function(self, params)
        if show and not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSong() then
            local song = GAMESTATE:GetCurrentSong()
            local steps = GAMESTATE:GetCurrentSteps(player)
            self:playcommand("ChangeSteps", {song=song, steps=steps})
            self:stoptweening()
            self:linear(0.1):diffusealpha(0.9)
        else
            self:stoptweening()
            self:linear(0.1):diffusealpha(0)
        end
    end,

    CreateDensityGraph(bannerWidth - (padding * 2), bannerHeight / 2 - (padding * 1.5)),

    Def.Quad {
        InitCommand=function(self)
            self:zoomto(bannerWidth - (padding * 2)+1, 20)
                :diffuse(color("#000000"))
                :diffusealpha(0.8)
                :align(0, 0)
                :y(bannerHeight / 2 - (padding * 1.5) - 20)
        end,
    },
    
    Def.BitmapText{
        Font="_miso",
        InitCommand=function(self)
            self:diffuse(color("#ffffff"))
                :horizalign("left")
                :y(bannerHeight / 2 - (padding * 1.5) - 20 + 2)
                :x(5)
                :maxwidth(bannerWidth - (padding * 2) - 10)
                :align(0, 0)
                :Stroke(color("#000000"))
        end,

        StepsHaveChangedCommand=function(self, params)
            if show then
                self:queuecommand("UpdateGraphState")
            end
        end,

        UpdateGraphStateCommand=function(self)
            if show and not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSong() then
                local song_dir = GAMESTATE:GetCurrentSong():GetSongDir()
                local steps = GAMESTATE:GetCurrentSteps(player)
				
				if steps == nil then return end
				
                local steps_type = ToEnumShortString( steps:GetStepsType() ):gsub("_", "-"):lower()
                local difficulty = ToEnumShortString( steps:GetDifficulty() )
                local breakdown = GetStreamBreakdown(song_dir, steps_type, difficulty)
                
                if breakdown == "" or breakdown == nil then
                    self:settext("No streams!")
                else
                    self:settext("Streams: " .. breakdown)
                end
                
                return true
            end
        end
    }
}