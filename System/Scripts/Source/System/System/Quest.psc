Scriptname System:Quest Extends System:Object Native Const Hidden
{
**See Also**
* https://www.creationkit.com/fallout4/index.php?title=Quest
* https://www.creationkit.com/fallout4/index.php?title=Quest_Script
}

; https://www.creationkit.com/index.php?title=OnInit
; https://www.creationkit.com/index.php?title=OnPlayerLoadGame_-_Actor

; OnInit is called at the following times:
; For Quests and Aliases: On game startup, and again whenever the quest starts, due to the quest being reset.

; OnInit is called again when an object is reset. All your variables and properties will be reset before OnInit is called.
; For Quests and Aliases this will happen when your quest starts.
; This means that a quest and alias will see OnInit twice before it starts the first time (game startup, and on reset).
; This should not cause any problems unless you are manipulating something outside the quest that doesn't reset in your OnInit.

; If a Quest is set to run on game startup and doesn't have the "Run Once" flag ticked, its OnInit event will fire twice when it starts.
; Ticking the "Run Once" flag, however, prevents the Quest from being reset when it starts, so in this case its OnInit event will only fire once.

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
