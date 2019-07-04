ScriptName System:Menus:Scope:Type Extends System:Type Const Native Hidden
{The base type for scripts.}


; Functions
;---------------------------------------------

string Function ToString()
	{The string representation of this type.}
	return "[System:Menus:Scope:Type]"
EndFunction


; Properties
;---------------------------------------------

Group Breath
	int Property BreathHeld = 0 AutoReadOnly
	int Property BreathReleased = 1 AutoReadOnly
	int Property BreathInterrupted = 2 AutoReadOnly
EndGroup
