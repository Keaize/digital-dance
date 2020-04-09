local P1 = GAMESTATE:IsHumanPlayer(PLAYER_1)
local P2 = GAMESTATE:IsHumanPlayer(PLAYER_2)
local profile = PROFILEMAN:GetLocalProfileFromIndex(0)
local nsj = GAMESTATE:GetNumSidesJoined()

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
			if IsUsingWideScreen() then
				self:diffuse(color("#a58cff"))
				self:horizalign(left)
				self:visible(P1)
				self:x(WideScale(78,94))
				self:y(WideScale(25,28))
				self:zoom(WideScale(0.6,0.8))
				self:settext("SONGS PLAYED (SET):")
			elseif nsj == 1 then
				self:diffuse(color("#a58cff"))
				self:horizalign(center)
				self:visible(P1 or P2)
				self:x(198)
				self:y(385)
				self:zoom(0.75)
				self:settext("SONGS PLAYED (SET/LIFETIME):")
			else
				self:visible(false)
			end
				
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
	-- Songs played lifetime
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#a58cff"))
				self:visible(P1)
				self:horizalign(left)
				self:x(WideScale(78,94))
				self:y(WideScale(40,43))
				self:zoom(WideScale(0.6,0.8))
				self:settext("SONGS (LIFETIME):")
			else
				self:visible(false)
			end
			
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
	-- Steps hit round
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#ff73e8"))
				self:visible(P1)
				self:horizalign(left)
				self:x(WideScale(78,94))
				self:y(WideScale(53,58))
				self:zoom(WideScale(0.6,0.8))
				self:settext("STEPS HIT (SET):")
			elseif nsj == 1 then
				self:diffuse(color("#ff73e8"))
				self:visible(P1 or P2)
				self:horizalign(center)
				self:x(198)
				self:y(412)
				self:zoom(0.75)
				self:settext("STEPS HIT (SET/LIFETIME):")
			else
				self:visible(false)
			end
			
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
	-- Steps hit lifetime
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#ff73e8"))
				self:visible(P1)
				self:horizalign(left)
				self:x(WideScale(78,94))
				self:y(WideScale(67,73))
				self:zoom(WideScale(0.6,0.8))
				self:settext("STEPS (LIFETIME):")
			else
				self:visible(false)
			end
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
		-- Average difficulty played
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#1fadff"))
				self:visible(P1)
				self:horizalign(left)
				self:x(WideScale(78,94))
				self:y(WideScale(81,88))
				self:zoom(WideScale(0.6,0.8))
				self:settext("AVERAGE DIFFICULTY:")
			elseif nsj == 1 then
				self:diffuse(color("#1fadff"))
				self:visible(P1 or P2)
				self:horizalign(left)
				self:x(98)
				self:y(440)
				self:zoom(0.75)
				self:settext("AVG DIFFICULTY:")
			else
				self:visible(false)
			end
			
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
		-- Average song bpm
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#1fadff"))
				self:visible(P1)
				self:horizalign(left)
				self:x(WideScale(78,94))
				self:y(WideScale(95,103))
				self:zoom(WideScale(0.6,0.8))
				self:settext("AVERAGE BPM:")
			elseif nsj == 1 then
				self:diffuse(color("#1fadff"))
				self:visible(P1 or P2)
				self:horizalign(left)
				self:x(212)
				self:y(440)
				self:zoom(0.75)
				self:settext("AVG BPM:")
			else
				self:visible(false)
			end

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
			if IsUsingWideScreen() then
				self:diffuse(color("#a58cff"))
				self:visible(P2)
				self:horizalign(left)
				self:x(WideScale(550,682))
				self:y(WideScale(25,28))
				self:zoom(WideScale(0.6,0.8))
				self:settext("SONGS PLAYED (SET):")
			else
				self:visible(false)
			end
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},
	-- Songs played lifetime
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#a58cff"))
				self:visible(P2)
				self:horizalign(left)
				self:x(WideScale(550,682))
				self:y(WideScale(40,43))
				self:zoom(WideScale(0.6,0.8))
				self:settext("SONGS (LIFETIME):")
			else
				self:visible(false)
			end
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},
	-- Steps hit round
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#ff73e8"))
				self:visible(P2)
				self:horizalign(left)
				self:x(WideScale(550,682))
				self:y(WideScale(53,58))
				self:zoom(WideScale(0.6,0.8))
				self:settext("STEPS HIT (SET):")
			else
				self:visible(false)
			end
			
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},
	-- Steps hit lifetime
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#ff73e8"))
				self:visible(P2)
				self:horizalign(left)
				self:x(WideScale(550,682))
				self:y(WideScale(67,73))
				self:zoom(WideScale(0.6,0.8))
				self:settext("STEPS (LIFETIME):")
			else
				self:visible(false)
			end
			
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},
		-- Average difficulty played
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#1fadff"))
				self:visible(P2)
				self:horizalign(left)
				self:x(WideScale(550,682))
				self:y(WideScale(81,88))
				self:zoom(WideScale(0.6,0.8))
				self:settext("AVERAGE DIFFICULTY:")
			else
				self:visible(false)
			end
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},
		-- Average song bpm
	 Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#1fadff"))
				self:visible(P2)
				self:horizalign(left)
				self:x(WideScale(550,682))
				self:y(WideScale(95,103))
				self:zoom(WideScale(0.6,0.8))
				self:settext("AVERAGE BPM:")
			else
				self:visible(false)
			end
			
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	}

}

return t