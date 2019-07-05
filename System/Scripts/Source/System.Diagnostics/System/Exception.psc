Scriptname System:Exception Hidden Const DebugOnly
import  System:Log

; Methods
;---------------------------------------------

; The exception that is thrown when a requested method or operation is not implemented.
; The exception is thrown when a particular method, get accessors, or set accessors is present as a member of a type but is not implemented.
bool Function NotImplemented(var script, string member, string text = "") Global DebugOnly
	return WriteMessage(script, "Exception: Not Implemented!", member+": The member '"+member+"' was not implemented. "+text)
EndFunction
