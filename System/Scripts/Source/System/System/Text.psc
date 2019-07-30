Scriptname System:Text Extends System:Object Native Const Hidden
{A string is a sequential collection of characters that is used to represent text.

**See Also**
* https://docs.microsoft.com/en-us/dotnet/api/system.text
* https://docs.microsoft.com/en-us/dotnet/api/system.string
}


; Concatenates up to five specified instances of *string*.
;
; Parameters
; * `this:` The first string to concatenate.
; * `other:` The second string to concatenate.
; * `a:` The third string to concatenate.
; * `b:` The fourth string to concatenate.
; * `c:` The fith string to concatenate.
;
; **Returns**
; The concatenation of `this`, `other`, `a`, `b`, and `c`.
;
; **Remarks**
; * You can also use the Papyrus string concatenation operator, such as `string text = "A"+"B"`, to concatenate strings.
;
; **See Also**
; https://docs.microsoft.com/en-us/dotnet/api/system.string.concat
string Function Concat(string this, string other, string a="", string b="", string c="") Global
	string[] values = new string[5]
	values[0] = this
	values[1] = other
	values[2] = a
	values[3] = b
	values[4] = c
	return ConcatAll(values)
EndFunction


; Concatenates the elements of a specified *string* array.
;
; **Parameters**
; * `values:` An array of string instances.
;
; **Returns**
; The concatenated elements of values.
;
; **Remarks**
; * You can also use the Papyrus string concatenation operator, such as `string text = "A"+"B"`, to concatenate strings.
;
; **See Also**
; https://docs.microsoft.com/en-us/dotnet/api/system.string.concat
string Function ConcatAll(string[] this) Global
	If (this)
		string result = ""
		int index = 0
		While (index < this.Length)
			If (this[index])
				result += this[index]
			EndIf
			index += 1
		EndWhile
		return result
	Else
		return ""
	EndIf
EndFunction


; Concatenates up to five specified instances of *string*, using the specified separator between each.
;
; **Parameters**
; * `separator:` The string to use as a separator. separator is included in the returned string only if value has more than one element.
; * `this:` The first string to concatenate.
; * `other:` The second string to concatenate.
; * `a:` The third string to concatenate.
; * `b:` The fourth string to concatenate.
; * `c:` The fith string to concatenate.
;
; **Returns**
; A string that consists of the elements in value delimited by the separator string.
; If value is an empty array, the method returns an empty string.
;
; **See Also**
; https://docs.microsoft.com/en-us/dotnet/api/system.string.join
string Function Join(string seperator, string this, string other, string a= "", string b= "", string c= "") Global
	string[] values = new string[5]
	values[0] = this
	values[1] = other
	values[2] = a
	values[3] = b
	values[4] = c
	return Joins(seperator, values)
EndFunction


string Function Joins(string seperator, string[] this) Global
	return JoinsAny(seperator, this as var[])
EndFunction


; Concatenates the elements of a specified array, using the specified separator between each element.
;
; **Parameters**
; * `separator:` The string to use as a separator. separator is included in the returned string only if value has more than one element.
; * `value:` An array that contains the elements to concatenate.
;
; **Returns**
; A string that consists of the elements in value delimited by the separator string.
; If `separator` is an empty string, the method returns an empty string.
; If `value` is an empty array, the method returns an empty string.
;
; **See Also**
; https://docs.microsoft.com/en-us/dotnet/api/system.string.join
string Function JoinsAny(string seperator, var[] this) Global
	If (this)
		If (seperator)
			string result = ""
			int index = 0
			While (index < this.Length)
				If (this[index])
					If (index < this.Length - 1)
						this[index] += seperator
					EndIf
					result += this[index]
				EndIf
				index += 1
			EndWhile
			return result
		Else
			return ""
		EndIf
	Else
		return ""
	EndIf
EndFunction


; Returns a new string that aligns the characters in this instance by
; padding them with spaces on the left or right, for a specified total length.
;
; **Remarks**
; * A negative `width` will left-align the padding of `this` string.
; * A positive `width` will right-align the padding of `this` string.
; * TODO: To create a proper string pad function I need to allow users to get a string's length.
; The `width` should be the strings total width, not just the padding width.
;
; **See Also**
; https://docs.microsoft.com/en-us/dotnet/api/system.string.padleft
; https://docs.microsoft.com/en-us/dotnet/api/system.string.padright
string Function Pad(string this, int width, string character= " ") Global
	If (this)
		If (width)
			string padding
			int index = 0
			While (index < width)
				padding += character
				index += 1
			EndWhile
			If (width < 0)
				return padding+this
			Else
				return this+padding
			EndIf
		Else
			; The padding width cannot be zero.
			return this ; no change
		EndIf
	Else
		; This string cannot be none or empty.
		return "" ; In case of none, return empty.
	EndIf
EndFunction
