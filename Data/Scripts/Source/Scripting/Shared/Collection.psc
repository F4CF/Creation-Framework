Scriptname Shared:Collection Hidden Const


var[] Function GetDistinct(var[] aArray) Global
	var[] distinct = new var[0]
	int index = 0
	While (index < aArray.Length)
		var element = aArray[index]
		If (distinct.Find(element) == -1)
			distinct.Add(element)
		EndIf
		index += 1
	EndWhile
	return distinct
EndFunction
