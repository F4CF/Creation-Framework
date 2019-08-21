ScriptName System:UI:Code:MenuType Extends System:UI:MenuDynamic Native Const Hidden
import System:Debug

; @external
Event OnClientLoaded(bool success, string instance)
	{The client loaded event.}
	WriteUnexpected(self, "OnClientLoaded", "The event was unhandled.", log="System")
EndEvent
