ScriptName Papyrus:Environment Const Hidden


string Function Name() Global
	return "Scripting"
EndFunction

string Function Plugin() Global
	return Name()+"."+PluginExtension()
EndFunction

string Function PluginExtension() Global
	return "esp"
EndFunction
