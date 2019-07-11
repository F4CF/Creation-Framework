ScriptName Scripting:Projects:Settings:ContextActivated Extends Terminal
import System:Log

; Events
;---------------------------------------------

Event OnMenuItemRun(int menuItemID, ObjectReference terminalReference)
	WriteLine("Scripting", self, "OnMenuItemRun :: menuItemID="+menuItemID + ", terminalReference="+terminalReference)
	If (menuItemID == OptionStartup)
		Context.IsActivated = true
	ElseIf (menuItemID == OptionShutdown)
		Context.IsActivated = false
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Scripting:Projects:Context Property Context Auto Const Mandatory
EndGroup

Group Options
	int Property OptionStartup Auto Const Mandatory
	int Property OptionShutdown Auto Const Mandatory
EndGroup
