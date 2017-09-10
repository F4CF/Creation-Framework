Scriptname Papyrus:Project:Settings:ModuleOptionalEnable extends Terminal
import Papyrus
import Papyrus:Diagnostics:Log

UserLog Log


; Events
;---------------------------------------------

Event OnInit()
	Log = LogNew(Optional.Context.Title, self)
EndEvent


Event OnMenuItemRun(int auiMenuItemID, ObjectReference akTerminalRef)
	WriteLine(Log, "OnMenuItemRun :: auiMenuItemID="+auiMenuItemID + ", akTerminalRef="+akTerminalRef)

	If (auiMenuItemID == OptionStartup)
		Optional.Enabled = true
	ElseIf (auiMenuItemID == OptionShutdown)
		Optional.Enabled = false
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Project:Modules:Optional Property Optional Auto Const Mandatory
EndGroup

Group Options
	int Property OptionStartup Auto Const Mandatory
	int Property OptionShutdown Auto Const Mandatory
EndGroup
