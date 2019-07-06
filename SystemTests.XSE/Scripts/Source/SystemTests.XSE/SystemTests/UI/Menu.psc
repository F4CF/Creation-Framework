ScriptName SystemTests:UI:Menu extends System:UI:CustomType
import System
import System:Log

; Display
;---------------------------------------------

DisplayData Function NewDisplay()
	DisplayData display = new DisplayData
	display.Menu = "GamesTestDummy"
	display.Asset = "GamesTestDummy"
	display.Root = "root1.Menu"
	RegisterForKey(Keyboard.J)
	RegisterForKey(Keyboard.K)
	RegisterForKey(Keyboard.L)
	return display
EndFunction


; Events
;---------------------------------------------

Event OnKeyDown(int keyCode)
	If (keyCode == Keyboard.J)
		Open()
		WriteLine(self, "Open")
	EndIf

	If (keyCode == Keyboard.K)
		Close()
		WriteLine(self, "Close")
	EndIf

	If (keyCode == Keyboard.L)
		WriteLine(self, "Pressed the L key.")
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Test
	System:Keyboard Property Keyboard Auto Const Mandatory
EndGroup
