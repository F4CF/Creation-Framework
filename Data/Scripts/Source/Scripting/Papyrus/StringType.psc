Scriptname Papyrus:StringType Const Native Hidden
; https://msdn.microsoft.com/en-us/library/system.string(v=vs.110).aspx


; String
;---------------------------------------------

; Copy(String)
; Creates a new instance of String with the same value as a specified String.


bool Function StringIsNoneOrEmpty(string value) Global
	{Indicates whether the specified string is none or an empty string.}
	return !(value) || value == ""
EndFunction


; IsNullOrWhiteSpace(String)
; Indicates whether a specified string is none, empty, or consists only of white-space characters.



string Function StringConcat(string value, string other) Global
	{Concatenates two specified instances of string.}
	return value + other
EndFunction


; Concat(String[])
; Concatenates the elements of a specified String array.


; Concat(Object)
; Creates the string representation of a specified object.


; Concat(Object[])
; Concatenates the string representations of the elements in a specified Object array.


; Join(String, String[])
; Concatenates all the elements of a string array, using the specified separator between each element.


; Join(String, Object[])
; Concatenates the elements of an object array, using the specified separator between each element.


; PadLeft(Int32)
; Returns a new string that right-aligns the characters in this instance by padding them with spaces on the left, for a specified total length.


; PadRight(Int32)
; Returns a new string that left-aligns the characters in this string by padding them with spaces on the right, for a specified total length.
