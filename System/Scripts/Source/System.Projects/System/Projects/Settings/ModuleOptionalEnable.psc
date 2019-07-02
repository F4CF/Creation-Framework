Scriptname System:Projects:Settings:ModuleOptionalEnable extends Terminal
import System
import System:Log

; Events
;---------------------------------------------

Event OnMenuItemRun(int menuItemID, ObjectReference terminalReference)
	WriteLine("System:Projects:Settings:ModuleOptionalEnable", "OnMenuItemRun :: menuItemID="+menuItemID + ", terminalReference="+terminalReference)
	If (menuItemID == OptionStartup)
		Optional.Enabled = true
	ElseIf (menuItemID == OptionShutdown)
		Optional.Enabled = false
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Projects:Modules:Optional Property Optional Auto Const Mandatory
EndGroup

Group Options
	int Property OptionStartup Auto Const Mandatory
	int Property OptionShutdown Auto Const Mandatory
EndGroup
