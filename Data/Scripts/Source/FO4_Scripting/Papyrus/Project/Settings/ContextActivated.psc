Scriptname Papyrus:Project:Settings:ContextActivated extends Terminal
import Papyrus
import Papyrus:Log

; Events
;---------------------------------------------

Event OnMenuItemRun(int auiMenuItemID, ObjectReference akTerminalRef)
	WriteLine(self, "OnMenuItemRun :: auiMenuItemID="+auiMenuItemID + ", akTerminalRef="+akTerminalRef)

	If (auiMenuItemID == OptionStartup)
		Context.IsActivated = true
	ElseIf (auiMenuItemID == OptionShutdown)
		Context.IsActivated = false
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Project:Context Property Context Auto Const Mandatory
EndGroup

Group Options
	int Property OptionStartup Auto Const Mandatory
	int Property OptionShutdown Auto Const Mandatory
EndGroup
