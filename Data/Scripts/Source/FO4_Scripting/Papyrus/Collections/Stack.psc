Scriptname Papyrus:Collections:Stack extends Papyrus:Collections:Collection Default
{Represents a last-in-first-out (LIFO) collection of objects.}
; https://msdn.microsoft.com/en-us/library/3278tedw(v=vs.110).aspx


var[] Items


; Events
;---------------------------------------------

Event OnInit()
	Items = new var[0]
EndEvent


; Methods
;---------------------------------------------

Function Push(var object)
	{Inserts an object at the top of the Stack<T>.}
	Items.Add(object)
EndFunction


var Function Pop()
	{Removes and returns the object at the top of the Stack<T>.}
	var item = Items[Last]
	Items.Remove(Last)
	return item
EndFunction


var Function Peek()
	{Returns the object at the top of the Stack<T> without removing it.}
	return Items[Last]
EndFunction


; Properties
;---------------------------------------------
Group Collection
	int Property Count Hidden
		int Function Get()
			{Gets the number of elements contained in the collection.}
			return Items.Length
		EndFunction
	EndProperty

	int Property Last Hidden
		int Function Get()
			return Items.Length - 1
		EndFunction
	EndProperty
EndGroup
