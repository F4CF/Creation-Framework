ScriptName System:UI:Examine:Menu Extends System:UI:MenuType
{Injects AS3 code into the vanilla Examine menu.}
import System:Log


; Methods
;---------------------------------------------

string Function ToString()
	{The string representation of this type.}
	return parent.ToString()+"[Instance:"+Instance+"]"
EndFunction


; Properties
;---------------------------------------------

; @overrides
string Function GetName()
	return "ExamineMenu"
EndFunction

; @override
string Function GetInstance()
	return ".BaseInstance"
EndFunction
