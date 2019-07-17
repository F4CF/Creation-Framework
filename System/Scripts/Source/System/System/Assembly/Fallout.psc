ScriptName System:Assembly:Fallout Extends System:Type
{Provides information about this assembly.}
import System:Log

; Properties
;---------------------------------------------

Group AVIF
	int Property ActionPoints Hidden
		int Function Get()
			return 0x000002D5
		EndFunction
	EndProperty
EndGroup

Group KYWD
	int Property ArmorBodyPartEyes Hidden
		int Function Get()
			return 0x0010C419
		EndFunction
	EndProperty
EndGroup


; Type
;---------------------------------------------

System:Assembly:Fallout Function Type() Global
	return System:Type.Read(File(), FormID()) as System:Assembly:Fallout
EndFunction

string Function File() Global
	{Static Property}
	return System:Assembly:SYS.File()
EndFunction

string Function FileName() Global
	{Static Property}
	return System:Assembly:SYS.FileName()
EndFunction

string Function FileExtension() Global
	{Static Property}
	return System:Assembly:SYS.FileExtension()
EndFunction

int Function FormID() Global
	{Static Property}
	return System:Assembly:SYS.FormID()
EndFunction
