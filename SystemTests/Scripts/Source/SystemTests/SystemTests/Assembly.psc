ScriptName SystemTests:Assembly Extends Quest
{The documentation string.}

;/ System (Test).esp
	NOTE
	0x02000F9A SystemTests_DummyHolotape

	QUST
	0x020044D1 SystemTests
	0x02000F9B SystemTests_Array
	0x02001735 SystemTests_Boolean
	0x0200266B SystemTests_CollectionsList
	0x02001737 SystemTests_Log
	0x02002E05 SystemTests_ObjectsFactory
	0x02001736 SystemTests_ProjectsContext
	0x02000F99 SystemTests_ProjectsContextMock
/;

; Methods
;---------------------------------------------

Assembly Function GetAssembly() Global
	return System:External.Read("SystemTests.esp", 0x020044D1) as Assembly
EndFunction


; Properties
;---------------------------------------------

Group Assembly
	string Property Name Hidden
		{The plugin name.}
		string Function Get()
			return "SystemTests"
		EndFunction
	EndProperty
	string Property Extension Hidden
		{The plugin name.}
		string Function Get()
			return "esp"
		EndFunction
	EndProperty
	string Property File Hidden
		{The plugin file.}
		string Function Get()
			return Name+"."+Extension
		EndFunction
	EndProperty
EndGroup
