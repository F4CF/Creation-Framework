Scriptname Papyrus:Collections:Dictionary extends Papyrus:Collections:Collection Default
{Represents a collection of keys and values.}
; https://msdn.microsoft.com/en-us/library/xfhwa508(v=vs.110).aspx
import Papyrus
import Papyrus:Objects:Factory


var[] Keys
var[] Values


; Constructor
;---------------------------------------------

Dictionary Function Init() Global
	Objects:Factory Factory = GetFactory()
	return Factory.Initialize(0x0000083B) as Dictionary
EndFunction


; Events
;---------------------------------------------

Event OnInit()
	Keys = new var[0]
	Values = new var[0]
EndEvent


; Methods
;---------------------------------------------

int Function IndexOf(var[] array, var object)
	{Determines the index of a specific object in the collection.}
	If (object)
		return array.Find(object)
	Else
		return Invalid
	EndIf
EndFunction


bool Function ContainsKey(var tKey)
	{Determines whether the Dictionary<TKey, TValue> contains the specified key.}
	return IndexOf(Keys, tKey) > Invalid
EndFunction


bool Function ContainsValue(var tValue)
	{Determines whether the Dictionary<TKey, TValue> contains a specific value.}
	return IndexOf(Values, tValue) > Invalid
EndFunction


Function Add(var tKey, var tValue)
	{Adds the specified key and value to the dictionary.}
	If !(ContainsKey(tKey))
		Keys.Add(tKey)
		Values.Add(tValue)
	EndIf
EndFunction


bool Function Remove(var tKey)
	{Removes the value with the specified key from the Dictionary<TKey, TValue>.}
	int index = IndexOf(Keys, tKey)
	If (index > Invalid)
		Keys.Remove(index)
		Values.Remove(index)
		return true
	Else
		return false
	EndIf
EndFunction


Function Clear()
	{Removes all keys and values from the Dictionary<TKey, TValue>.}
	Keys.Clear()
	Values.Clear()
EndFunction


var Function TryGetValue(var tKey)
	{Gets the value associated with the specified key.}
	int index = IndexOf(Keys, tKey)
	If (index > Invalid)
		return Values[index]
	Else
		return none
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Collection
	int Property Count Hidden
		int Function Get()
			{Gets the number of elements contained in the collection.}
			return Keys.Length
		EndFunction
	EndProperty
EndGroup
