Scriptname Papyrus:VersionType Const Native Hidden
import Papyrus:BoolType
; https://msdn.microsoft.com/en-us/library/system.version(v=vs.110).aspx


; Version
;---------------------------------------------

Struct Version
	int Major = -1
	int Minor = -1
	int Build = -1
	int Revision = -1
	bool Distribution = false
EndStruct


; Functions
;---------------------------------------------

string Function VersionToString(Version value) Global
	string sDevOnly = ""
	If (value.Distribution)
		sDevOnly = "[REL]"
	Else
		sDevOnly = "[WIP]"
	EndIf
	return value.Major+"."+value.Minor+"."+value.Build+"."+value.Revision+" "+sDevOnly
EndFunction


; Operators
;---------------------------------------------

; Not Implemented
bool Function VersionEquality(Version value, Version other) Global
	{Determines whether two specified Version objects are equal.}
EndFunction


; Not Implemented
bool Function VersionInequality(Version value, Version other) Global
	{ Determines whether two specified Version objects are not equal. }
EndFunction


bool Function VersionGreaterThan(Version value, Version other) Global
	{The version on the left is greater than the version on the right.}
	; Determines whether the first specified Version object is greater than the second specified Version object.
	If (value.Major > other.Major)
		return true
	ElseIf (value.Minor > other.Minor)
		return true
	ElseIf (value.Build > other.Build)
		return true
	ElseIf (value.Revision > other.Revision)
		return true
	Else
		; A distribution is greater than a work in progress.
		int valueA = BoolToInt(value.Distribution)
		int valueB = BoolToInt(other.Distribution)

		If (valueA > valueB)
			return true
		Else
			return false
		EndIf
	EndIf
EndFunction


; Not Implemented
bool Function VersionGreaterThanOrEqual(Version value, Version other) Global
	{Determines whether the first specified Version object is greater than or equal to the second specified Version object.}
EndFunction


; Not Implemented
bool Function VersionLessThan(Version value, Version other) Global
	{Determines whether the first specified Version object is less than the second specified Version object.}
EndFunction


; Not Implemented
bool Function VersionLessThanOrEqual(Version value, Version other) Global
	{Determines whether the first specified Version object is less than or equal to the second Version object.}
EndFunction
