Scriptname System:Projects:Settings:ContextActivated extends Terminal
import System
import System:Log

; Events
;---------------------------------------------

Event OnMenuItemRun(int menuItemID, ObjectReference terminalReference)
	WriteLine("System:Projects:Settings:ContextActivated", "OnMenuItemRun :: menuItemID="+menuItemID + ", terminalReference="+terminalReference)
	If (menuItemID == OptionStartup)
		Context.IsActivated = true
	ElseIf (menuItemID == OptionShutdown)
		Context.IsActivated = false
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Projects:Context Property Context Auto Const Mandatory
EndGroup

Group Options
	int Property OptionStartup Auto Const Mandatory
	int Property OptionShutdown Auto Const Mandatory
EndGroup
