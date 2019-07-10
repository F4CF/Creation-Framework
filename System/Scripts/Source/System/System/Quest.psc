Scriptname System:Quest Extends System:Object Native Const Hidden
{
**See Also**
* https://www.creationkit.com/fallout4/index.php?title=Quest
* https://www.creationkit.com/fallout4/index.php?title=Quest_Script
}

; Instance
;---------------------------------------------

Quest Property QUST Hidden
	Quest Function Get()
		return QUST()
	EndFunction
EndProperty

; @virtual
Quest Function QUST()
	Quest this = System:Type.AsQuest(self)
	System:Debug.Assert(this, "Exception: Invalid Object! This must be of the `Quest` type.")
	return this
EndFunction


; OnQuestInit
;---------------------------------------------

Event OnQuestInit() Native

Event Quest.OnQuestInit(Quest this)
	OnQuestInit()
EndEvent

bool Function RegisterForQuestInit(Quest this)
	return self.RegisterForRemoteEvent(this, "OnQuestInit")
EndFunction

Function UnregisterForQuestInit(Quest this)
	self.UnregisterForRemoteEvent(this, "OnQuestInit")
EndFunction


; OnQuestShutdown
;---------------------------------------------

Event OnQuestShutdown() Native

Event Quest.OnQuestShutdown(Quest this)
	OnQuestShutdown()
EndEvent

bool Function RegisterForQuestShutdown(Quest this)
	return self.RegisterForRemoteEvent(this, "OnQuestShutdown")
EndFunction

Function UnregisterForQuestShutdown(Quest this)
	self.UnregisterForRemoteEvent(this, "OnQuestShutdown")
EndFunction
