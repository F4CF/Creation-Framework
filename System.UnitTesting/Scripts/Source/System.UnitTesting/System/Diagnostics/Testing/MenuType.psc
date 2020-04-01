ScriptName System:Diagnostics:Testing:MenuType Extends System:UI:MenuCustom Native Const Hidden

; Structures
;---------------------------------------------

Struct UnitTestData
	string Name = ""
	string Description = ""
EndStruct


; Scaleform
;---------------------------------------------

Event OnAssetReady() Native
Event OnAssetUnloaded() Native
