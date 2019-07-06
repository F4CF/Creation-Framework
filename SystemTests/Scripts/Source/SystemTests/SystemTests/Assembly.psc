ScriptName SystemTests:Assembly Extends Quest
{The documentation string.}

;/ SystemTests.esp
	NOTE
	02000F9A SystemTests_DummyHolotape

	QUST
	020044D1 SystemTests
	02000F9B SystemTests_Array
	02001735 SystemTests_Boolean
	0200266B SystemTests_CollectionsList
	02004C6B SystemTests_DiagnosticsTestRunner
	02001737 SystemTests_Log
	02002E05 SystemTests_ObjectsFactory
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

Group QUST
	int Property SystemTests_DiagnosticsTestRunner Hidden
		{QUST}
		int Function Get()
			return 0x00004C6B
		EndFunction
	EndProperty
EndGroup

Group Fallout
	string Property Fallout Hidden
		{Fallout4.esm}
		string Function Get()
			return "Fallout4.esm"
		EndFunction
	EndProperty
	int Property Armor_Vault111_Underwear Hidden
		{ARMO}
		int Function Get()
			return 0x0001EED7
		EndFunction
	EndProperty
EndGroup
