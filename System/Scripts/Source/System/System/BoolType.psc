Scriptname System:BoolType Extends System:Object Native Const Hidden

; Boolean
;---------------------------------------------

int Function BoolToInt(bool value) Global
	If (value)
		return 1
	Else
		return 0
	EndIf
EndFunction
