ScriptName System:HUDFramework:HUD Extends Scripting:Projects:Module Native Const Hidden
import System:Log

; Virtual
;---------------------------------------------

Event OnWidgetLoaded()
	{VIRTUAL}
	Write(none, "The widget has not implemented the virtual 'OnWidgetLoaded' event.")
EndEvent
