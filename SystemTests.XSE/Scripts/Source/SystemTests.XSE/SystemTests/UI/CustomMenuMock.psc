ScriptName SystemTests:UI:CustomMenuMock extends System:UI:CustomType
import System:Log

; Display
;---------------------------------------------

Event OnInit()
	RegisterForKey(Keyboard.J)
	RegisterForKey(Keyboard.K)
	RegisterForKey(Keyboard.L)
EndEvent

; @overrides
string Function GetName()
	{Property}
	return "GamesTestDummy"
EndFunction

; @overrides
string Function GetFile()
	{Property}
	return "GamesTestDummy"
EndFunction

; @overrides
string Function GetInstance()
	{Property}
	return ".Menu"
EndFunction


; Events
;---------------------------------------------

Event OnKeyDown(int keyCode)
	If (keyCode == Keyboard.J)
		Open()
		WriteLine("System", self, "OnKeyDown::"+keyCode)
	EndIf

	If (keyCode == Keyboard.K)
		Close()
		WriteLine("System", self, "OnKeyDown::"+keyCode)
	EndIf

	If (keyCode == Keyboard.L)
		WriteLine("System", self, "OnKeyDown::"+keyCode)
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Test
	System:Input Property Keyboard Auto Const Mandatory
EndGroup
