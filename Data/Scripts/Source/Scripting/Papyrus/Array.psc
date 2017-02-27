Scriptname Papyrus:Array Const Native Hidden


; Array
;---------------------------------------------

var[] Function GetDistinct(var[] array) Global
	var[] distinct = new var[0]
	int index = 0
	While (index < array.Length)
		var element = array[index]
		If (distinct.Find(element) == -1)
			distinct.Add(element)
		EndIf
		index += 1
	EndWhile
	return distinct
EndFunction
