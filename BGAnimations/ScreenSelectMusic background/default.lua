local af = Def.ActorFrame{

 LoadActor("./background.mp4")..{
	InitCommand=function(self) self:FullScreen():Center():diffusealpha(1.0):valign(0):y(0):loop(true) end,
}
}
return af