local t = Def.ActorFrame{

	OnCommand=function(self)
		self:xy(_screen.cx - (IsUsingWideScreen() and 0 or 165), _screen.cy - 92)
	end,

	-- ----------------------------------------
	-- Actorframe for Artist, BPM, and Song length
	Def.ActorFrame{
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set"),
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set"),

		-- background for Artist, BPM, and Song Length
		Def.Quad{
			InitCommand=function(self)
				self:diffuse(color("#1e282f"))
					:zoomto( IsUsingWideScreen() and 320 or 311, 48 )
			end
		},

		Def.ActorFrame{

			InitCommand=cmd(x,-122;y,2),

			-- Artist Label
			LoadFont("_miso")..{
				InitCommand=function(self)
					local text = GAMESTATE:IsCourseMode() and "NumSongs" or "Artist"
					self:settext( THEME:GetString("SongDescription", text) )
						:zoom(0.8)
						:horizalign(right):y(-12)
						:maxwidth(44)
						if IsUsingWideScreen() then
						else
						self:x(10)
						end
				end,
				OnCommand=function(self) self:diffuse(0.5,0.5,0.5,1) end
			},

			-- Song Artist
			LoadFont("_miso")..{
				InitCommand=cmd(zoom,0.8;horizalign,left; xy, 5,-12; maxwidth,WideScale(225,260) ),
				SetCommand=function(self)
				if IsUsingWideScreen() then
						else
						self:x(14)
						end
					if GAMESTATE:IsCourseMode() then
						local course = GAMESTATE:GetCurrentCourse()
						if course then
							self:settext( #course:GetCourseEntries() )
						else
							self:settext("")
						end
					else
						local song = GAMESTATE:GetCurrentSong()
						if song and song:GetDisplayArtist() then
							self:settext( song:GetDisplayArtist() )
						else
							self:settext("")
						end
					end
				end
			},



			-- BPM Label
			LoadFont("_miso")..{
				Text=THEME:GetString("SongDescription", "BPM"),
				InitCommand=function(self)
					self:horizalign(right):y(8)
						:zoom(0.8)
						:diffuse(0.5,0.5,0.5,1)
						if IsUsingWideScreen() then
						else
						self:x(10)
						end
				end
			},

			-- BPM value
			LoadFont("_miso")..{
				InitCommand=cmd(horizalign, left; y, 8; x, 5; diffuse, color("1,1,1,1")),
				SetCommand=function(self)
					--defined in ./Scipts/DD-CustomSpeedMods.lua
					if IsUsingWideScreen() then
						else
						self:x(14)
						end
					local text = GetDisplayBPMs()
					self:zoom(0.8)
					self:settext(text or "")
				end
			},

			-- Song Length Label
			LoadFont("_miso")..{
				Text=THEME:GetString("SongDescription", "Length"),
				InitCommand=function(self)
					self:horizalign(right)
						:zoom(0.8)
						:x(_screen.w/4.5-60):y(8)
						:diffuse(0.5,0.5,0.5,1)
						if IsUsingWideScreen() then
						else
						self:x(130)
						end
				end
			},

			-- Song Length Value
			LoadFont("_miso")..{
				InitCommand=cmd(zoom,0.8;horizalign, left; y, 8; x, _screen.w/4.5 - 55),
				SetCommand=function(self)
					local duration
					if IsUsingWideScreen() then
						else
						self:x(134)
					end
					if GAMESTATE:IsCourseMode() then
						local Players = GAMESTATE:GetHumanPlayers()
						local player = Players[1]
						local trail = GAMESTATE:GetCurrentTrail(player)

						if trail then
							duration = TrailUtil.GetTotalSeconds(trail)
						end
					else
						local song = GAMESTATE:GetCurrentSong()
						if song then
							duration = song:MusicLengthSeconds()
						end
					end


					if duration then
						duration = duration / SL.Global.ActiveModifiers.MusicRate
						if duration == 105.0 then
							-- r21 lol
							self:settext( THEME:GetString("SongDescription", "r21") )
						else
							local hours = 0
							if duration > 3600 then
								hours = math.floor(duration / 3600)
								duration = duration % 3600
							end

							local finalText
							if hours > 0 then
								-- where's HMMSS when you need it?
								finalText = hours .. ":" .. SecondsToMMSS(duration)
							else
								finalText = SecondsToMSS(duration)
							end

							self:settext( finalText )
						end
					else
						self:settext("")
					end
				end
			}
		},

	}
}

return t
