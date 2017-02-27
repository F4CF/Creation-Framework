Scriptname Papyrus:Compatibility:External Const Native Hidden


; Inter-mod Communication
;---------------------------------------------

Struct ExternalForm
	int FormID
	string PluginFile
EndStruct


Form Function GetExternalForm(ExternalForm aExternalForm) Global
	If (Game.IsPluginInstalled(aExternalForm.PluginFile))
		return Game.GetFormFromFile(aExternalForm.FormID, aExternalForm.PluginFile)
	Else
		return none
	EndIf
EndFunction
