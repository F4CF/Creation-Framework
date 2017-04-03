Scriptname Papyrus:Compatibility:External Const Native Hidden


; Inter-mod Communication
;---------------------------------------------

Struct ExternalForm
	int FormID
	string FileName
EndStruct


Form Function GetExternalForm(ExternalForm aExternalForm) Global
	If (Game.IsPluginInstalled(aExternalForm.FileName))
		return Game.GetFormFromFile(aExternalForm.FormID, aExternalForm.FileName)
	Else
		return none
	EndIf
EndFunction
