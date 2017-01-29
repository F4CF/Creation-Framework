Scriptname Shared:Compatibility Hidden Const
import Shared:Papyrus


; Version
;---------------------------------------------

Struct Version
	int Major = 0
	int Minor = 0
	int Build = 0
	int Revision = 0
	bool Distribution = false
EndStruct


string Function VersionToString(Version aVersion) Global
	string sDevOnly
	If (aVersion.Distribution)
		sDevOnly = "[REL]"
	Else
		sDevOnly = "[WIP]"
	EndIf
	return aVersion.Major+"."+aVersion.Minor+"."+aVersion.Build+"."+aVersion.Revision+" "+sDevOnly
EndFunction


bool Function VersionGreaterThan(Version versionA, Version versionB) Global
	If (versionA.Major > versionB.Major)
		return true
	ElseIf (versionA.Minor > versionB.Minor)
		return true
	ElseIf (versionA.Build > versionB.Build)
		return true
	ElseIf (versionA.Revision > versionB.Revision)
		return true
	Else
		; A distribution is greater than a work in progress.
		int valueA = BoolToInt(versionA.Distribution)
		int valueB = BoolToInt(versionB.Distribution)

		If (valueA > valueB)
			return true
		Else
			return false
		EndIf
	EndIf
EndFunction


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
