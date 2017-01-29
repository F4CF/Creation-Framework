Scriptname Shared:Papyrus Hidden Const


; Boolean
;---------------------------------------------

int Function BoolToInt(bool value) Global
	If (value)
		return 1
	Else
		return 0
	EndIf
EndFunction


; String
;---------------------------------------------

bool Function StringIsNoneOrEmpty(string value) Global
	return !(value) || value == ""
EndFunction


; Spacial
;---------------------------------------------

Struct Point
	float X = 0.0
	float Y = 0.0
	float Z = 0.0
EndStruct


string Function PointToString(Point value) Global
	return "X:"+value.X+", Y:"+value.Y+", Z:"+value.Z
EndFunction


; Script
;---------------------------------------------

bool Function ChangeState(ScriptObject aScriptObject, string asNewState) Global
	string stateName = aScriptObject.GetState()

	If(stateName != asNewState)
		aScriptObject.GoToState(asNewState)
		return true
	Else
		return false
	EndIf
EndFunction


bool Function HasState(ScriptObject aScriptObject) Global
	return aScriptObject.GetState() != ""
EndFunction
