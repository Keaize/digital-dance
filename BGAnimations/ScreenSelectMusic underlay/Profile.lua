local P1 = GAMESTATE:IsHumanPlayer(PLAYER_1)
local P2 = GAMESTATE:IsHumanPlayer(PLAYER_2)	
local name1 = PROFILEMAN:GetPlayerName(0)
local name2 = PROFILEMAN:GetPlayerName(1)
local directory1 = PROFILEMAN:GetProfileDir(0)
local directory2 = PROFILEMAN:GetProfileDir(1)
local nsj = GAMESTATE:GetNumSidesJoined()

local file1 = directory1 .. "/Profile Picture.png"
local file2 = directory2 .. "/Profile Picture.png"
local file3 = THEME:GetPathB("ScreenSelectMusic","underlay/default picture.png")

local function getInputHandler(actor, player)
	return (function(event)
		if event.GameButton == "Start" and event.PlayerNumber == player and GAMESTATE:IsHumanPlayer(event.PlayerNumber) then
			actor:visible(true)
		end
	end)
end


local t = Def.ActorFrame{
	Name="DifficultyJawn",
	InitCommand=cmd(vertalign, top; draworder, 105),
------- background panes for the difficulty selection. wait why is this here wtf. oh wait now i remember stepmania sucks.----------
Def.Quad{
		Name="DiffBackground",
		InitCommand=function(self)
				self:x(IsUsingWideScreen() and WideScale(_screen.cx-_screen.w/2.7,_screen.cx-_screen.w/2.9) or 155)
				self:y(IsUsingWideScreen() and _screen.cy + 78 or 193)
				self:draworder(0)
				self:diffuse(0.5,0.5,0.5,0.5)
				if IsUsingWideScreen() then
					self:zoomx(WideScale(160,267))
					self:zoomy(56)
					self:visible(P1)
				else
					self:zoomto(270,40)
					self:visible(true)
				end
				
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
	

Def.Quad{
		Name="DiffBackground2",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:visible(P2)
				self:xy(WideScale(_screen.cx+_screen.w/2.7,_screen.cx+_screen.w/2.9), _screen.cy + 78)
				self:draworder(0)
				self:diffuse(0.5,0.5,0.5,0.5)
				self:zoomx(WideScale(160,267))
				self:zoomy(56)
			else
			end
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},

 --- background panes for player stats ------
Def.Quad{
		Name="ProfileBackground",
		InitCommand=function(self)
			self:visible(P1)
			self:xy(WideScale(_screen.cx-240,_screen.cx-294),WideScale(_screen.cy - 192,_screen.cy - 184))
			self:draworder(0)
			self:diffuse(0.5,0.5,0.5,0.5)
				if IsUsingWideScreen() then
					self:zoomto(WideScale(160,267),WideScale(98,112))
				elseif nsj == 1 then
					self:zoomto(310,82)
					self:y(406)
					self:x(155)
				else
					self:visible(false)
				end
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},

Def.Quad{
		Name="ProfileBackground",
		InitCommand=function(self)
			self:visible(P2)
			self:xy(WideScale(_screen.cx+240,_screen.cx+294),WideScale(_screen.cy - 192,_screen.cy - 184))
			self:draworder(0)
			self:diffuse(0.5,0.5,0.5,0.5)
			if IsUsingWideScreen() then
					self:zoomto(WideScale(160,267),WideScale(98,112))
				elseif nsj == 1 then
					self:zoomto(310,82)
					self:y(406)
					self:x(155)
				else
					self:visible(false)
				end
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},

 ---------------------------- Player 1's profile stats	-----------------------------
Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#FFFFFF"))
				self:visible(P1)
				self:horizalign(center)
				self:maxwidth(WideScale(159,266))
				self:x(WideScale(80,135))
				self:y(10)
				self:zoom(WideScale(0.75,0.9))
				self:settext(name1 .. "'s stats")
			elseif nsj == 1 then
				self:diffuse(color("#FFFFFF"))
				self:visible(P1)
				self:horizalign(center)
				self:maxwidth(300)
				self:x(198)
				self:y(372)
				self:zoom(0.8)
				self:settext(name1 .. "'s stats")
			else
				self:visible(false)
			end
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},

	
	
--- cute lil profile picture for the ladies ---	
Def.Sprite{
	Texture=FILEMAN:DoesFileExist(file1) and file1 or file3,
	Name="ProfilePicture1",
	InitCommand=function(self)
		if IsUsingWideScreen() then
			self:visible(P1)
			self:zoomto(WideScale(72,91.2),WideScale(72,91.2))
			self:x(WideScale(36,46))
			self:y(WideScale(60,66))
		elseif nsj == 1 then
			self:visible(P1)
			self:zoomto(82,82)
			self:x(41)
			self:y(406)
		else
			self:visible(false)
		end
	end,
	OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P1'))
		end
	},
	
---------------------------------- Player 2's profile stats	--------------------------------
Def.BitmapText{
		Font="_miso",
		InitCommand=function(self)
			if IsUsingWideScreen() then
				self:diffuse(color("#FFFFFF"))
				self:visible(P2)
				self:horizalign(center)
				self:maxwidth(WideScale(159,266))
				self:x(WideScale(560,725))
				self:y(10)
				self:zoom(WideScale(0.75,0.9))
				self:settext(name2 .. "'s stats")
			elseif nsj == 1 then
				self:diffuse(color("#FFFFFF"))
				self:visible(P2)
				self:horizalign(center)
				self:maxwidth(300)
				self:x(198)
				self:y(372)
				self:zoom(0.8)
				self:settext(name2 .. "'s stats")
			else
			self:visible(false)
			end
		end,
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(getInputHandler(self, 'PlayerNumber_P2'))
		end
	},
	
	
--- cute lil profile picture for the ladies ---	
Def.Sprite{
	Texture=FILEMAN:DoesFileExist(file2) and file2 or file3,
	Name="ProfilePicture2",
	InitCommand=function(self)
		if IsUsingWideScreen() then
			self:visible(P2)
			self:zoomto(WideScale(72,91.2),WideScale(72,91.2))
			self:x(WideScale(514,634))
			self:y(WideScale(60,66))
		elseif nsj == 1 then
			self:visible(P2)
			self:zoomto(82,82)
			self:x(41)
			self:y(406)
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
