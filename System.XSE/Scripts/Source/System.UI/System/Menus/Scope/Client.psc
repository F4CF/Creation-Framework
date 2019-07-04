ScriptName System:Menus:Scope:Client Extends System:Type
{The client API for scope overlay interactions.}
import System:Log

; TODO: Separate the client from the vanilla "Menu.psc".
; Clients will be adapted into runtime injected loaders.

Actor Player


; Events
;---------------------------------------------

Event OnQuestInit()
	Player = Game.GetPlayer()
EndEvent


; Methods
;---------------------------------------------

string Function GetMember(string member)
	{Provides the instance member's variable path for the loaded client.}
	If (member)
		return Menu.GetClient()+"."+member
	Else
		WriteUnexpectedValue(self, "GetMember", "member", "The value cannot be none or empty.")
		return ""
	EndIf
EndFunction


var Function Get(string member)
	{Gets a client property member value. The return type must be cast.}
	return UI.Get(Menu.Name, GetMember(member))
EndFunction


bool Function Set(string member, var argument)
	{Sets a client property member with the given argument.}
	return UI.Set(Menu.Name, GetMember(member), argument)
EndFunction


var Function Invoke(string member, var[] arguments = none)
	{Invokes a client function member with the given arguments.}
	return UI.Invoke(Menu.Name, GetMember(member), arguments)
EndFunction


; Properties
;---------------------------------------------

Group Properties
	System:Menus:Scope:Menu Property Menu Auto Const Mandatory
EndGroup
