ScriptName System:Diagnostics:Common extends Quest


string Function GetLogFile() Global
	return System:Environment.Name() + "_Test"
EndFunction


string Property LogFile Hidden
	string Function Get()
		return GetLogFile()
	EndFunction
EndProperty
