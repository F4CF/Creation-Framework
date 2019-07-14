ScriptName System:UI:Client Extends System:Quest
import System:Log


; Properties
;---------------------------------------------

; Group Private
; 	System:UI:Menu Property Menu Auto Const Mandatory
; 	{Private- Provides an abstraction for interacting with the visor menu.}
; EndGroup


; Methods
;---------------------------------------------

; string Function GetMember(string member)
; 	{Provides the instance variable path for client members.}
; 	If (member)
; 		return Menu.GetMember(Menu.Client+"."+member)
; 	Else
; 		WriteUnexpectedValue("System", self, "GetMember", "member", "The value cannot be none or empty.")
; 		return ""
; 	EndIf
; EndFunction


; var Function Get(string member)
; 	return UI.Get(Menu.Name, member)
; EndFunction


; bool Function Set(string member, var argument)
; 	return UI.Set(Menu.Name, member, argument)
; EndFunction


; var Function Invoke(string member, var[] arguments = none)
; 	return UI.Invoke(Menu.Name, member, arguments)
; EndFunction


; Open/Close Event
;---------------------------------------------

CustomEvent OpenCloseEvent

Struct OpenCloseEventArgs
	bool Opening = false
EndStruct


bool Function RegisterForOpenCloseEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "OpenCloseEvent")
		return true
	Else
		WriteUnexpectedValue("System", self, "RegisterForOpenCloseEvent", "script", "Cannot register a none script for events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForOpenCloseEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "OpenCloseEvent")
		return true
	Else
		WriteUnexpectedValue("System", self, "UnregisterForOpenCloseEvent", "script", "Cannot unregister a none script for events.")
		return false
	EndIf
EndFunction


OpenCloseEventArgs Function GetOpenCloseEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as OpenCloseEventArgs
	Else
		return none
	EndIf
EndFunction


; Loaded Event
;---------------------------------------------

CustomEvent LoadedEvent

Struct LoadedEventArgs
	bool Success = false
	string Instance = ""
EndStruct


bool Function RegisterForLoadedEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "LoadedEvent")
		return true
	Else
		WriteUnexpectedValue("System", self, "RegisterForLoadedEvent", "script", "Cannot register a none script for events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForLoadedEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "LoadedEvent")
		return true
	Else
		WriteUnexpectedValue("System", self, "UnregisterForLoadedEvent", "script", "Cannot unregister a none script for events.")
		return false
	EndIf
EndFunction


LoadedEventArgs Function GetLoadedEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as LoadedEventArgs
	Else
		return none
	EndIf
EndFunction
