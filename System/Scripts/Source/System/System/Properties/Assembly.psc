ScriptName System:Properties:Assembly Extends System:Type
{Provides information about this assembly.}
;/ System.esl
ACTI
  0000083B System_CollectionsDictionary
  0000083A System_CollectionsList
  0000083E System_CollectionsQueue
  0000083D System_CollectionsStack

CELL
  (Details not provided for this record type.)

QUST
  00000838 System
/;


; Constructor
;---------------------------------------------

; A singleton script constructor provides an object instance.
; https://en.wikipedia.org/wiki/Singleton_pattern
System:Properties:Assembly Function Type() Global
	return System:Type.Read(FileName()+"."+FileExtension(), FormID()) as System:Properties:Assembly
EndFunction

string Function FileName() Global
	{Static Property}
	return "System"
EndFunction

string Function FileExtension() Global
	{Static Property}
	return "esl"
EndFunction

int Function FormID() Global
	{Static Property}
	return 0x00000838
EndFunction


; Properties
;---------------------------------------------

; @overrides
; The data file plugin name.
string Function GetFileName()
	{Property}
	return System:Properties:Assembly.FileName()
EndFunction

; @overrides
; The data file plugin extension.
string Function GetFileExtension()
	{Property}
	return System:Properties:Assembly.FileExtension()
EndFunction


Group QUST
	int Property System Hidden
		int Function Get()
			return System:Properties:Assembly.FormID()
		EndFunction
	EndProperty
EndGroup

Group ACTI
	int Property System_CollectionsDictionary Hidden
		int Function Get()
			return 0x0000083B
		EndFunction
	EndProperty
	int Property System_CollectionsList Hidden
		int Function Get()
			return 0x0000083A
		EndFunction
	EndProperty
	int Property System_CollectionsQueue Hidden
		int Function Get()
			return 0x0000083E
		EndFunction
	EndProperty
	int Property System_CollectionsStack Hidden
		int Function Get()
			return 0x0000083D
		EndFunction
	EndProperty
EndGroup
