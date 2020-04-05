local player = ...
local pn = ToEnumShortString(player)
local p = PlayerNumber:Reverse()[player]

local text_table, marquee_index

if GAMESTATE:IsCourseMode() then
return Def.ActorFrame { }
end

return Def.ActorFrame{
	Name="StepArtistAF_" .. pn,
	InitCommand=cmd(draworder,1),

	-- song and course changes
	OnCommand=cmd(queuecommand, "StepsHaveChanged"),
	CurrentSongChangedMessageCommand=cmd(queuecommand, "StepsHaveChanged"),
	CurrentCourseChangedMessageCommand=cmd(queuecommand, "StepsHaveChanged"),

	PlayerJoinedMessageCommand=function(self, params)
		if params.Player == player then
			self:queuecommand("Appear" .. pn)
		end
	end,
	PlayerUnjoinedMessageCommand=function(self, params)
		if params.Player == player then
			self:ease(0.5, 275):addy(scale(p,0,1,1,-1) * 30):diffusealpha(0)
		end
	end,

	-- depending on the value of pn, this will either become
	-- an AppearP1Command or an AppearP2Command when the screen initializes
	["Appear"..pn.."Command"]=function(self) self:visible(true):ease(0.5, 275):addy(scale(p,0,1,-1,1) * 30) end,

	InitCommand=function(self)
		self:visible( false ):halign( p )

		if player == PLAYER_1 then

			self:y(IsUsingWideScreen() and _screen.cy + 71 or _screen.cy + 153)
			self:x( _screen.cx - (IsUsingWideScreen() and WideScale(330,435) or 306))

		elseif player == PLAYER_2 then

			self:y(IsUsingWideScreen() and _screen.cy + 11 or _screen.cy + 13)
			self:x( _screen.cx - (IsUsingWideScreen() and -153 or 306))
		end

		if GAMESTATE:IsHumanPlayer(player) then
			self:queuecommand("Appear" .. pn)
		end
	end,

	-- colored background quad
	Def.Quad{
		Name="BackgroundQuad",
		InitCommand=cmd(zoomto, IsUsingWideScreen() and WideScale(160,265) or 265, _screen.h/28; x, IsUsingWideScreen() and WideScale(89,141) or 141; diffuse, DifficultyIndexColor(1) ),
		StepsHaveChangedCommand=function(self)
			if IsUsingWideScreen() then
			else
				self:zoomto(310, _screen.h/28)
			end
			local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
			
			if StepsOrTrail then
				local difficulty = StepsOrTrail:GetDifficulty()
				self:diffuse( DifficultyColor(difficulty) )
			else
				self:diffuse( PlayerColor(player) )
			end
		end
	},

	--STEPS label
	Def.BitmapText{
		Font="_miso",
		OnCommand=cmd(diffuse, color("0,0,0,1"); horizalign, left; x,IsUsingWideScreen() and 10 or -10; settext, Screen.String("STEPS"))
	},

	--stepartist text
	Def.BitmapText{
		Font="_miso",
		InitCommand=cmd(diffuse,color("#1e282f"); horizalign, left; x, 55;zoom,0.9),
		StepsHaveChangedCommand=function(self)
				if IsUsingWideScreen() then
					self:maxwidth(WideScale(165,240))
				else
					self:x(35)
					self:maxwidth(285)
				end
			
			local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local StepsOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSteps(player)

			-- always stop tweening when steps change in case a MarqueeCommand is queued
			self:stoptweening()

			-- clear the stepartist text, in case we're hovering over a group title
			self:settext("")

			if SongOrCourse and StepsOrCourse then
				text_table = GetStepsCredit(player)
				marquee_index = 0

				-- only queue a marquee if there are things in the text_table to display
				if #text_table > 0 then self:queuecommand("Marquee") end
			end
		end,
		MarqueeCommand=function(self)
			-- increment the marquee_index, and keep it in bounds
			marquee_index = (marquee_index % #text_table) + 1
			-- retrieve the text we want to display
			local text = text_table[marquee_index]

			-- set this BitmapText actor to display that text
			self:settext( text )

			-- account for the possibility that emojis shouldn't be diffused to Color.Black
			for i=1, text:utf8len() do
				if text:utf8sub(i,i):byte() >= 240 then
					self:AddAttribute(i-1, { Length=1, Diffuse={1,1,1,1} } )
				end
			end

			-- sleep 2 seconds before queueing the next Marquee command to do this again
			self:sleep(2):queuecommand("Marquee")
		end,
		OffCommand=function(self) self:stoptweening() end
	}
}