ScriptName System:UI:Console:MenuType Extends System:UI:Menu Native Const Hidden

; Properties
;---------------------------------------------

; string Property Instance Hidden
; 	{The menu's base instance variable.}
; 	string Function Get()
; 		return Root+".AnimHolder_mc.Menu_mc"
; 	EndFunction
; EndProperty

Group Root
	string Property BGSCodeObj Hidden
		string Function Get()
			return Root+".BGSCodeObj"
		EndFunction
	EndProperty

	string Property ExecuteCommand Hidden
		string Function Get()
			return BGSCodeObj+".executeCommand"
		EndFunction
	EndProperty
EndGroup
