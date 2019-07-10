Scriptname System:VersionType Extends System:Object Native Const Hidden
import System:BoolType
; https://msdn.microsoft.com/en-us/library/system.version(v=vs.110).aspx


; Version
;---------------------------------------------

Struct Version
	int Major = -1
	int Minor = -1
	int Build = -1
	int Revision = -1
	string Label = ""
EndStruct


; Functions
;---------------------------------------------

string Function VersionToString(Version value) Global
	If (value.Label)
		return value.Major+"."+value.Minor+"."+value.Build+"."+value.Revision+" "+value.Label
	Else
		return value.Major+"."+value.Minor+"."+value.Build+"."+value.Revision
	EndIf
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


; Determines whether `value` is greater than the `other`.
bool Function VersionGreaterThan(Version value, Version other) Global
	{The version on the left is greater than the version on the right.}
	If (value.Major > other.Major)
		return true
	ElseIf (value.Minor > other.Minor)
		return true
	ElseIf (value.Build > other.Build)
		return true
	ElseIf (value.Revision > other.Revision)
		return true
	Else
		return false
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
