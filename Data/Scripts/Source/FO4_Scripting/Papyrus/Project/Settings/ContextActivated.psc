Scriptname Papyrus:Project:Settings:ContextActivated extends Terminal
import Papyrus
import Papyrus:Diagnostics:Log

UserLog Log


; Events
;---------------------------------------------

Event OnInit()
	Log = LogNew(Context.Title, self)
EndEvent


Event OnMenuItemRun(int auiMenuItemID, ObjectReference akTerminalRef)
	WriteLine(Log, "OnMenuItemRun :: auiMenuItemID="+auiMenuItemID + ", akTerminalRef="+akTerminalRef)

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
