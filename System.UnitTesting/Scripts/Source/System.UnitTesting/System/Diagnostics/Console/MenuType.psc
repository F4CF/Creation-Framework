ScriptName System:Diagnostics:Console:MenuType Extends System:Diagnostics:Type Native Const Hidden
{The base type for the Console menu.}

; Structures
;---------------------------------------------

Struct UnitTestData
	string Name = ""
	string Description = ""
EndStruct

; Events
;---------------------------------------------

Event OnLoadComplete(bool success, string menuName, string sourceVar, string destVar, string assetPath) Native


; Scaleform
;---------------------------------------------

Event OnTestingLoaded() Native
Event OnTestingUnloaded() Native


; Functions
;---------------------------------------------

string Function ToString()
	{The string representation of this type.}
	return "[System:Diagnostics:Console:MenuType]"
EndFunction
