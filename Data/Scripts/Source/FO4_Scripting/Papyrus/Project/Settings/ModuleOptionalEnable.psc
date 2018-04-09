Scriptname Papyrus:Project:Settings:ModuleOptionalEnable extends Terminal
import Papyrus
import Papyrus:Log

; Events
;---------------------------------------------

Event OnMenuItemRun(int auiMenuItemID, ObjectReference akTerminalRef)
	WriteLine(self, "OnMenuItemRun :: auiMenuItemID="+auiMenuItemID + ", akTerminalRef="+akTerminalRef)

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
