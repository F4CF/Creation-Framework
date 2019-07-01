Scriptname System:External Const Native Hidden

Struct ExternalForm
	string FileName
	int FormID
	Form Object
EndStruct

; Methods
;---------------------------------------------

ExternalForm Function NewExternal(string fileName, int formID) Global
	ExternalForm value = new ExternalForm
	value.FileName = fileName
	value.FormID = formID
	return value
EndFunction


bool Function ReadExternal(ExternalForm value) Global
	If (Exists(value.FileName))
		value.Object = Read(value.FileName, value.FormID)
		return value.Object
	Else
		return false
	EndIf
EndFunction


Form Function Read(string fileName, int formID) Global
	return Game.GetFormFromFile(formID, fileName)
EndFunction


bool Function Exists(string fileName) Global
	return Game.IsPluginInstalled(fileName)
EndFunction
