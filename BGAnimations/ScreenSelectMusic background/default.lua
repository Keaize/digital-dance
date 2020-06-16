local af = Def.ActorFrame{

 LoadActor("./background.mp4")..{
	InitCommand=function(self) self:diffusealpha(0.18):FullScreen():valign(0):y(0):loop(true) end,
}
}
return af