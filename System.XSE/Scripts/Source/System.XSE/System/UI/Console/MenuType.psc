ScriptName System:UI:Console:MenuType Extends System:UI:Menu Native Const Hidden

; Properties
;---------------------------------------------

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
