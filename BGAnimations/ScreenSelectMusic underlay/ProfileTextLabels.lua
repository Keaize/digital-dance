if IsUsingWideScreen() then
local P1 = GAMESTATE:IsHumanPlayer(PLAYER_1)
local P2 = GAMESTATE:IsHumanPlayer(PLAYER_2)
local profile = PROFILEMAN:GetLocalProfileFromIndex(0)

local function getInputHandler(actor, player)
	return (function(event)
		if event.GameButton == "Start" and event.PlayerNumber == player and GAMESTATE:IsHumanPlayer(event.PlayerNumber) then
			actor:visible(true)
		end
	end)
end



local t = Def.ActorFrame{
	Name="DifficultyJawn",
	InitCommand=cmd(vertalign, top; draworder, 106),
	
	 ---------------------------- Player 1's profile stat labels -------------------------------------
 
 -- Songs played this round
 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			self:diffuse(color("#a58cff"))
			self:visible(P1)
			self:horizalign(left)
			self:x(94)
			self:y(28)
			self:zoom(0.8)
			self:settext("SONGS PLAYED (SET):")
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
	-- Songs played lifetime
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			self:diffuse(color("#a58cff"))
			self:visible(P1)
			self:horizalign(left)
			self:x(94)
			self:y(43)
			self:zoom(0.8)
			self:settext("SONGS (LIFETIME):")
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
	-- Steps hit round
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			self:diffuse(color("#ff73e8"))
			self:visible(P1)
			self:horizalign(left)
			self:x(94)
			self:y(58)
			self:zoom(0.8)
			self:settext("STEPS HIT (SET):")
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
	-- Steps hit lifetime
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			self:diffuse(color("#ff73e8"))
			self:visible(P1)
			self:horizalign(left)
			self:x(94)
			self:y(73)
			self:zoom(0.8)
			self:settext("STEPS (LIFETIME):")
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
		-- Average difficulty played
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			self:diffuse(color("#1fadff"))
			self:visible(P1)
			self:horizalign(left)
			self:x(94)
			self:y(88)
			self:zoom(0.8)
			self:settext("AVERAGE DIFFICULTY:")
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
		-- Average song bpm
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			self:diffuse(color("#1fadff"))
			self:visible(P1)
			self:horizalign(left)
			self:x(94)
			self:y(103)
			self:zoom(0.8)
			self:settext("AVERAGE BPM:")
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
	
	---------------------------- Player 2's profile stat labels -------------------------------------
	 -- Songs played this round
 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			self:diffuse(color("#a58cff"))
			self:visible(P2)
			self:horizalign(left)
			self:x(682)
			self:y(28)
			self:zoom(0.8)
			self:settext("SONGS PLAYED (SET):")
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},
	-- Songs played lifetime
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			self:diffuse(color("#a58cff"))
			self:visible(P2)
			self:horizalign(left)
			self:x(682)
			self:y(43)
			self:zoom(0.8)
			self:settext("SONGS (LIFETIME):")
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},
	-- Steps hit round
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			self:diffuse(color("#ff73e8"))
			self:visible(P2)
			self:horizalign(left)
			self:x(682)
			self:y(58)
			self:zoom(0.8)
			self:settext("STEPS HIT (SET):")
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},
	-- Steps hit lifetime
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			self:diffuse(color("#ff73e8"))
			self:visible(P2)
			self:horizalign(left)
			self:x(682)
			self:y(73)
			self:zoom(0.8)
			self:settext("STEPS (LIFETIME):")
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},
		-- Average difficulty played
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			self:diffuse(color("#1fadff"))
			self:visible(P2)
			self:horizalign(left)
			self:x(682)
			self:y(88)
			self:zoom(0.8)
			self:settext("AVERAGE DIFFICULTY:")
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},
		-- Average song bpm
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			self:diffuse(color("#1fadff"))
			self:visible(P2)
			self:horizalign(left)
			self:x(682)
			self:y(103)
			self:zoom(0.8)
			self:settext("AVERAGE BPM:")
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	}

}

return t

else return end