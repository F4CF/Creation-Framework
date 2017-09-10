ScriptName Papyrus_Test:Framework:Common extends Quest


string Function GetLogFile() Global
	return Papyrus:Environment.Name() + "_Test"
EndFunction


string Property LogFile Hidden
	string Function Get()
		return GetLogFile()
	EndFunction
EndProperty
