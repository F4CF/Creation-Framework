Scriptname Papyrus:Collections:List extends Papyrus:Collections:Collection Default
{Represents a list of objects that can be accessed by index.}
; https://msdn.microsoft.com/en-us/library/6sh2ey19(v=vs.110).aspx
import Papyrus
import Papyrus:Objects:Factory
import Papyrus:Diagnostics:Log


var[] Items


; Constructor
;---------------------------------------------

List Function Init() Global
	Objects:Factory Factory = GetFactory()
	return Factory.Initialize(0x0000083A) as List
EndFunction


; Events
;---------------------------------------------

Event OnInit()
	Items = new var[0]
EndEvent


; Methods
;---------------------------------------------

int Function IndexOf(var object)
	{Determines the index of a specific item in the IList.}
	If (object)
		return Items.Find(object)
	Else
		return Invalid
	EndIf
EndFunction


bool Function Contains(var object)
	{Determines whether an element is in the IList.}
	return IndexOf(object) > Invalid
EndFunction


Function Add(var object)
	{Calling this method always throws a NotSupportedException exception.}
	Items.Add(object)
EndFunction


Function Insert(int index, var object)
	{Inserts an item to the IList at the specified index.}
	Items.Insert(object, index)
EndFunction


Function Remove(var object)
	{Removes the first occurrence of a specific object from the IList.}
	int index = IndexOf(object)
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
