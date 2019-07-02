ScriptName System:Assembly Extends Quest
{Provides assembly property values.}

;/ System.esl
	ACTI
	0x0000083B SystemCollectionsDictionary
	0x0000083A SystemCollectionsList
	0x0000083E SystemCollectionsQueue
	0x0000083D SystemCollectionsStack

	CELL
	(Details not provided for this record type.)

	QUST
	0x00000838 System
/;

; Methods
;---------------------------------------------

Assembly Function GetAssembly() Global
	return System:External.Read("System.esl", 0x00000838) as Assembly
EndFunction


; Properties
;---------------------------------------------

Group Assembly
	string Property Name Hidden
		{The plugin name.}
		string Function Get()
			return "System"
		EndFunction
	EndProperty
	string Property Extension Hidden
		{The plugin name.}
		string Function Get()
			return "esl"
		EndFunction
	EndProperty
	string Property File Hidden
		{The plugin file.}
		string Function Get()
			return Name+"."+Extension
		EndFunction
	EndProperty
EndGroup

Group QUST
	int Property System Hidden
		int Function Get()
			return 0x00000838
		EndFunction
	EndProperty
EndGroup

Group ACTI
	int Property SystemCollectionsDictionary Hidden
		int Function Get()
			return 0x0000083B
		EndFunction
	EndProperty
	int Property SystemCollectionsList Hidden
		int Function Get()
			return 0x0000083A
		EndFunction
	EndProperty
	int Property SystemCollectionsQueue Hidden
		int Function Get()
			return 0x0000083E
		EndFunction
	EndProperty
	int Property SystemCollectionsStack Hidden
		int Function Get()
			return 0x0000083D
		EndFunction
	EndProperty
EndGroup
