ScriptName ScriptingTest:SharedUIMenu extends Shared:UI:Menu
import Papyrus:Log

; Display
;---------------------------------------------

DisplayData Function NewDisplay()
	DisplayData display = new DisplayData
	display.Menu = "HUDMenu"
	display.Asset = "TestWidget"
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
	Shared:Input:Keyboard Property Keyboard Auto Const Mandatory
EndGroup
