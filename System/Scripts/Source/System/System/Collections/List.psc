Scriptname System:Collections:List extends System:Collections:Collection Default
{Represents a list of objects that can be accessed by index.
https://msdn.microsoft.com/en-us/library/6sh2ey19(v=vs.110).aspx}
import System
import System:Log
import System:Activator

var[] Items


; Constructor
;---------------------------------------------

List Function Type() Global
	return This().Type(0x0000083A) as List
EndFunction


; Events
;---------------------------------------------

Event OnInit()
	Items = new var[0]
EndEvent


; Methods
;---------------------------------------------

int Function IndexOf(var value)
	{Determines the index of a specific item in the IList.}
	If (value)
		return Items.Find(value)
	Else
		return Invalid
	EndIf
EndFunction


bool Function Contains(var value)
	{Determines whether an element is in the IList.}
	return IndexOf(value) > Invalid
EndFunction


Function Add(var value)
	{Calling this method always throws a NotSupportedException exception.}
	Items.Add(value)
EndFunction


Function Insert(int index, var value)
	{Inserts an item to the IList at the specified index.}
	Items.Insert(value, index)
EndFunction


Function Remove(var value)
	{Removes the first occurrence of a specific value from the IList.}
	int index = IndexOf(value)
	Items.Remove(index)
EndFunction


Function RemoveAt(int index)
	{Removes the IList item at the specified index.}
	Items.Remove(index)
EndFunction


Function Clear()
	{Removes all items from the IList.}
	Items.Clear()
EndFunction


; Constructor
;---------------------------------------------




; Properties
;---------------------------------------------

Group Collection
	int Property Count Hidden
		int Function Get()
			{Gets the number of elements contained in the collection.}
			return Items.Length
		EndFunction
	EndProperty
EndGroup
