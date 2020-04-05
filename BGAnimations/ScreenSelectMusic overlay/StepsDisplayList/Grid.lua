local GridColumns = 0
local GridRows = 5
local GridZoomX = IsUsingWideScreen() and 0.435 or 0.39
local BlockZoomY = 0.275
local StepsToDisplay, SongOrCourse, StepsOrTrails

local P1 = GAMESTATE:IsHumanPlayer(PLAYER_1)
local P2 = GAMESTATE:IsHumanPlayer(PLAYER_2)

local function getInputHandler(actor, player)
	return (function(event)
		if event.GameButton == "Start" and event.PlayerNumber == player and GAMESTATE:IsHumanPlayer(event.PlayerNumber) then
			actor:visible(true)
		end
	end)
end

local t = Def.ActorFrame{
	Name="StepsDisplayList",
	InitCommand=cmd(vertalign, top; draworder, 101; x, _screen.cx-294;y, _screen.cy - 154;zoom,IsUsingWideScreen() and WideScale(0.7,1) or 1),
	-- - - - - - - - - - - - - -

	OnCommand=cmd(queuecommand, "RedrawStepsDisplay"),
	CurrentSongChangedMessageCommand=cmd(queuecommand, "RedrawStepsDisplay"),
	CurrentCourseChangedMessageCommand=cmd(queuecommand, "RedrawStepsDisplay"),
	StepsHaveChangedCommand=cmd(queuecommand, "RedrawStepsDisplay"),

	-- - - - - - - - - - - - - -

	RedrawStepsDisplayCommand=function(self)

		SongOrCourse = (GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse()) or GAMESTATE:GetCurrentSong()

		if SongOrCourse then
			StepsOrTrails = (GAMESTATE:IsCourseMode() and SongOrCourse:GetAllTrails()) or SongUtil.GetPlayableSteps( SongOrCourse )

			if StepsOrTrails then

				StepsToDisplay = GetStepsToDisplay(StepsOrTrails)

				for RowNumber=1,GridRows do
					if StepsToDisplay[RowNumber] then
						-- if this particular song has a stepchart for this row, update the Meter
						-- and BlockRow coloring appropriately
						local meter = StepsToDisplay[RowNumber]:GetMeter()
						local difficulty = StepsToDisplay[RowNumber]:GetDifficulty()
						self:GetChild("Grid"):GetChild("Meter_"..RowNumber):playcommand("Set", {Meter=meter, Difficulty=difficulty})
						self:GetChild("Grid"):GetChild("Meter_1"..RowNumber):playcommand("Set", {Meter=meter, Difficulty=difficulty})
						self:GetChild("Grid"):GetChild("Meter_2"..RowNumber):playcommand("Set", {Meter=meter, Difficulty=difficulty})
						self:GetChild("Grid"):GetChild("Meter_3"..RowNumber):playcommand("Set", {Meter=meter, Difficulty=difficulty})
						self:GetChild("Grid"):GetChild("Meter_4"..RowNumber):playcommand("Set", {Meter=meter, Difficulty=difficulty})
						self:GetChild("Grid"):GetChild("Meter_5"..RowNumber):playcommand("Set", {Meter=meter, Difficulty=difficulty})
						self:GetChild("Grid"):GetChild("Meter_6"..RowNumber):playcommand("Set", {Meter=meter, Difficulty=difficulty})
						self:GetChild("Grid"):GetChild("Meter_7"..RowNumber):playcommand("Set", {Meter=meter, Difficulty=difficulty})
						self:GetChild("Grid"):GetChild("Meter_8"..RowNumber):playcommand("Set", {Meter=meter, Difficulty=difficulty})
						self:GetChild("Grid"):GetChild("Meter_9"..RowNumber):playcommand("Set", {Meter=meter, Difficulty=difficulty})
						self:GetChild("Grid"):GetChild("Blocks_"..RowNumber):playcommand("Set", {Meter=meter, Difficulty=difficulty})
					else
						-- otherwise, set the meter to an empty string and hide this particular colored BlockRow
						self:GetChild("Grid"):GetChild("Meter_"..RowNumber):playcommand("Unset")
						self:GetChild("Grid"):GetChild("Meter_1"..RowNumber):playcommand("Unset")
						self:GetChild("Grid"):GetChild("Meter_2"..RowNumber):playcommand("Unset")
						self:GetChild("Grid"):GetChild("Meter_3"..RowNumber):playcommand("Unset")
						self:GetChild("Grid"):GetChild("Meter_4"..RowNumber):playcommand("Unset")
						self:GetChild("Grid"):GetChild("Meter_5"..RowNumber):playcommand("Unset")
						self:GetChild("Grid"):GetChild("Meter_6"..RowNumber):playcommand("Unset")
						self:GetChild("Grid"):GetChild("Meter_7"..RowNumber):playcommand("Unset")
						self:GetChild("Grid"):GetChild("Meter_8"..RowNumber):playcommand("Unset")
						self:GetChild("Grid"):GetChild("Meter_9"..RowNumber):playcommand("Unset")
						self:GetChild("Grid"):GetChild("Blocks_"..RowNumber):playcommand("Unset")

					end
				end
			end
		else
			StepsOrTrails, StepsToDisplay = nil, nil
			self:playcommand("Unset")
		end
	end,

}


local Grid = Def.ActorFrame{
	Name="Grid",
	InitCommand=cmd(horizalign, left; vertalign, top; x,IsUsingWideScreen() and WideScale(-95,-149.5) or -21.5;y,IsUsingWideScreen() and WideScale(308,232) or 106),
}


-- A grid of decorative faux-blocks that will exist
-- behind the changing difficulty blocks.

for RowNumber=1,GridRows do

	Grid[#Grid+1] =	Def.Sprite{
		Name="Blocks_"..RowNumber,
		Texture=THEME:GetPathB("ScreenSelectMusic", "overlay/StepsDisplayList/_block.png"),

		InitCommand=cmd(diffusealpha,0),
		OnCommand=function(self)
			local width = self:GetWidth()
			local height= self:GetHeight()
			self:y( RowNumber * height * BlockZoomY)
			self:zoomto(width * GridColumns * GridZoomX, height * BlockZoomY)
		end,
		SetCommand=function(self, params)
			-- our grid only supports charts with up to a 20-block difficulty meter
			-- but charts can have higher difficulties
			-- handle that here by clamping the value to be between 1 and, at most, 20
			local meter = clamp( params.Meter, 1, GridColumns )

			self:customtexturerect(0, 0, GridColumns, 1)
			self:cropright( 1 - (meter * (1/GridColumns)) )

			-- diffuse and set each chart's difficulty meter
			self:diffuse( DifficultyColor(params.Difficulty) )
		end,
		UnsetCommand=function(self)
			self:customtexturerect(0,0,0,0)
		end
	}
	
	------------------ stupid extra border stuff for the difficulty numbers---------------------
	Grid[#Grid+1] = Def.BitmapText{
		Name="Meter_1"..RowNumber,
		Font="_wendy small",

		InitCommand=function(self)
			local height = self:GetParent():GetChild("Blocks_"..RowNumber):GetHeight()
			self:horizalign(center)
			self:y(2)
			self:x(RowNumber * height/0.35 * BlockZoomY + 2)
			self:zoom(0.75)
				if IsUsingWideScreen() then
					self:visible(P1)
				else
					self:visible(true)
				end
		end,
		SetCommand=function(self, params)
			-- diffuse and set each chart's difficulty meter
			self:diffuse( Color.Black)
			self:settext(params.Meter)
		end,
		UnsetCommand=cmd(settext, ""; diffuse,color("#182025")),
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	}
	
	Grid[#Grid+1] = Def.BitmapText{
		Name="Meter_2"..RowNumber,
		Font="_wendy small",

		InitCommand=function(self)
			local height = self:GetParent():GetChild("Blocks_"..RowNumber):GetHeight()
			self:horizalign(center)
			self:y(-2)
			self:x(RowNumber * height/0.35 * BlockZoomY - 2)
			self:zoom(0.75)
				if IsUsingWideScreen() then
					self:visible(P1)
				else
					self:visible(true)
				end
		end,
		SetCommand=function(self, params)
			-- diffuse and set each chart's difficulty meter
			self:diffuse( Color.Black)
			self:settext(params.Meter)
		end,
		UnsetCommand=cmd(settext, ""; diffuse,color("#182025")),
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	}
	
	Grid[#Grid+1] = Def.BitmapText{
		Name="Meter_3"..RowNumber,
		Font="_wendy small",

		InitCommand=function(self)
			local height = self:GetParent():GetChild("Blocks_"..RowNumber):GetHeight()
			self:horizalign(center)
			self:y(2)
			self:x(RowNumber * height/0.35 * BlockZoomY-2)
			self:zoom(0.75)
				if IsUsingWideScreen() then
						self:visible(P1)
					else
						self:visible(true)
					end
		end,
		SetCommand=function(self, params)
			-- diffuse and set each chart's difficulty meter
			self:diffuse( Color.Black)
			self:settext(params.Meter)
		end,
		UnsetCommand=cmd(settext, ""; diffuse,color("#182025")),
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	}
	
	Grid[#Grid+1] = Def.BitmapText{
		Name="Meter_4"..RowNumber,
		Font="_wendy small",

		InitCommand=function(self)
			local height = self:GetParent():GetChild("Blocks_"..RowNumber):GetHeight()
			self:horizalign(center)
			self:y(-2)
			self:x(RowNumber * height/0.35 * BlockZoomY+2)
			self:zoom(0.75)
			if IsUsingWideScreen() then
					self:visible(P1)
				else
					self:visible(true)
				end
		end,
		SetCommand=function(self, params)
			-- diffuse and set each chart's difficulty meter
			self:diffuse( Color.Black)
			self:settext(params.Meter)
		end,
		UnsetCommand=cmd(settext, ""; diffuse,color("#182025")),
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	}
	
	----------------- the actual difficulty numbers -------------------
	Grid[#Grid+1] = Def.BitmapText{
		Name="Meter_"..RowNumber,
		Font="_wendy small",

		InitCommand=function(self)
			local height = self:GetParent():GetChild("Blocks_"..RowNumber):GetHeight()
			self:horizalign(center)
			self:x(RowNumber * height/0.35 * BlockZoomY)
			self:zoom(0.75)
			if IsUsingWideScreen() then
					self:visible(P1)
				else
					self:visible(true)
				end
		end,
		SetCommand=function(self, params)
			-- diffuse and set each chart's difficulty meter
			self:diffuse( DifficultyColor(params.Difficulty) )
			self:settext(params.Meter)
		end,
		UnsetCommand=cmd(settext, ""; diffuse,color("#182025")),
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	}
	
	
	---------------------------- Player 2 numbers oh god oh no please help me -----------------------------------------
	Grid[#Grid+1] = Def.BitmapText{
		Name="Meter_5"..RowNumber,
		Font="_wendy small",

		InitCommand=function(self)
			local height = self:GetParent():GetChild("Blocks_"..RowNumber):GetHeight()
				if IsUsingWideScreen() then
					self:zoom(0.75)
					self:visible(P2)
					self:horizalign(center)
					self:y(2)
					self:x(WideScale(RowNumber * height/0.35 * BlockZoomY + 678,RowNumber * height/0.35 * BlockZoomY + 588))
				else
					self:visible(false)
					self:zoom(0)
				end
		end,
		SetCommand=function(self, params)
			-- diffuse and set each chart's difficulty meter
			self:diffuse( Color.Black)
			self:settext(params.Meter)
		end,
		UnsetCommand=cmd(settext, ""; diffuse,color("#182025")),
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	}
	
	Grid[#Grid+1] = Def.BitmapText{
		Name="Meter_6"..RowNumber,
		Font="_wendy small",

		InitCommand=function(self)
			local height = self:GetParent():GetChild("Blocks_"..RowNumber):GetHeight()
			
			if IsUsingWideScreen() then
					self:horizalign(center)
					self:y(-2)
					self:x(WideScale(RowNumber * height/0.35 * BlockZoomY + 674,RowNumber * height/0.35 * BlockZoomY + 584))
					self:zoom(0.75)
					self:visible(P2)
				else
					self:visible(false)
					self:zoom(0)
				end
		end,
		SetCommand=function(self, params)
			-- diffuse and set each chart's difficulty meter
			self:diffuse( Color.Black)
			self:settext(params.Meter)
		end,
		UnsetCommand=cmd(settext, ""; diffuse,color("#182025")),
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	}
	
	Grid[#Grid+1] = Def.BitmapText{
		Name="Meter_7"..RowNumber,
		Font="_wendy small",

		InitCommand=function(self)
			local height = self:GetParent():GetChild("Blocks_"..RowNumber):GetHeight()
			if IsUsingWideScreen() then
					self:zoom(0.75)
					self:visible(P2)
					self:horizalign(center)
					self:y(2)
					self:x(WideScale(RowNumber * height/0.35 * BlockZoomY + 674,RowNumber * height/0.35 * BlockZoomY+584))
				else
					self:visible(false)
					self:zoom(0)
				end
		end,
		SetCommand=function(self, params)
			-- diffuse and set each chart's difficulty meter
			self:diffuse( Color.Black)
			self:settext(params.Meter)
		end,
		UnsetCommand=cmd(settext, ""; diffuse,color("#182025")),
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	}
	
	Grid[#Grid+1] = Def.BitmapText{
		Name="Meter_8"..RowNumber,
		Font="_wendy small",

		InitCommand=function(self)
			local height = self:GetParent():GetChild("Blocks_"..RowNumber):GetHeight()
			if IsUsingWideScreen() then
					self:zoom(0.75)
					self:visible(P2)
					self:horizalign(center)
					self:y(-2)
					self:x(WideScale(RowNumber * height/0.35 * BlockZoomY + 678,RowNumber * height/0.35 * BlockZoomY+588))
				else
					self:visible(false)
					self:zoom(0)
				end
		end,
		SetCommand=function(self, params)
			-- diffuse and set each chart's difficulty meter
			self:diffuse( Color.Black)
			self:settext(params.Meter)
		end,
		UnsetCommand=cmd(settext, ""; diffuse,color("#182025")),
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	}
	
	----------------- the actual P2 difficulty numbers -------------------
	Grid[#Grid+1] = Def.BitmapText{
		Name="Meter_9"..RowNumber,
		Font="_wendy small",

		InitCommand=function(self)
			local height = self:GetParent():GetChild("Blocks_"..RowNumber):GetHeight()
				if IsUsingWideScreen() then
					self:zoom(0.75)
					self:visible(P2)
					self:horizalign(center)
					self:x(WideScale(RowNumber * height/0.35 * BlockZoomY + 676,RowNumber * height/0.35 * BlockZoomY + 586))
				else
					self:visible(false)
					self:zoom(0)
				end
		end,
		SetCommand=function(self, params)
			-- diffuse and set each chart's difficulty meter
			self:diffuse( DifficultyColor(params.Difficulty) )
			self:settext(params.Meter)
		end,
		UnsetCommand=cmd(settext, ""; diffuse,color("#182025")),
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	}
	
	
end

t[#t+1] = Grid

return t