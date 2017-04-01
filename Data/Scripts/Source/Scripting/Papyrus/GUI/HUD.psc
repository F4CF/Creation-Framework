Scriptname Papyrus:GUI:HUD extends Papyrus:Project:Module Native Const Hidden
import Papyrus:Diagnostics:Log


; Virtual
;---------------------------------------------

Event OnWidgetLoaded()
	{VIRTUAL}
	Write(none, "The widget has not implemented the virtual 'OnWidgetLoaded' event.")
EndEvent
