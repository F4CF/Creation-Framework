Scriptname Papyrus:Collections:Collection extends Form Const Native Hidden
; https://msdn.microsoft.com/en-us/library/system.collections.specialized.inotifycollectionchanged(v=vs.110).aspx
; https://msdn.microsoft.com/en-us/library/system.collections.specialized.inotifycollectionchanged.collectionchanged(v=vs.110).aspx
; https://msdn.microsoft.com/en-us/library/system.collections.specialized.notifycollectionchangedeventargs(v=vs.110).aspx
; https://msdn.microsoft.com/en-us/library/system.collections.specialized.notifycollectionchangedaction(v=vs.110).aspx


; Events
;---------------------------------------------

Event OnCollectionChanged(NotifyCollectionChangedEventArgs e)
	{Occurs when an item is added, removed, changed, moved, or the entire list is refreshed.}
EndEvent


Event OnPropertyChanged(PropertyChangedEventArgs e)
	{Occurs when a property value changes.}
EndEvent


; Properties
;---------------------------------------------

Struct NotifyCollectionChangedEventArgs
	int ActionType = -1
	{Gets the action that caused the event.}
	int NewStartingIndex = -1
	{The zero-based index at which the change occurred.}
	int OldStartingIndex = -1
	{The zero-based index at which a Move, Remove, or Replace action occurred.}
	Collection NewItems
	{The list of new items involved in the change.}
	Collection OldItems
	{The list of items affected by a Replace, Remove, or Move action.}
EndStruct


Struct PropertyChangedEventArgs
	string PropertyName
	{Gets the name of the property that changed.}
EndStruct


Group NotifyCollectionChangedAction
	int Property Add = 0 AutoReadOnly
	{An item was added to the collection.}
	int Property Move = 1 AutoReadOnly
	{An item was moved within the collection.}
	int Property Remove = 2 AutoReadOnly
	{An item was removed from the collection.}
	int Property Replace = 3 AutoReadOnly
	{An item was replaced in the collection.}
	int Property Reset = 4 AutoReadOnly
	{The content of the collection was cleared.}
EndGroup




; Explicit Interface Implementations
;---------------------------------------------

; IList.Add(Object)
; Calling this method always throws a NotSupportedException exception.


; IList.Clear()
; Removes all items from the IList.


; IList.Contains(Object)
; Determines whether an element is in the IList.


; IList.IndexOf(Object)
; Determines the index of a specific item in the IList.


; IList.Insert(Int32, Object)
; Inserts an item to the IList at the specified index.


; IList.Remove(Object)
; Removes the first occurrence of a specific object from the IList.


; IList.RemoveAt(Int32)
; Removes the IList item at the specified index.


; ICollection.Count
; Gets the number of elements contained in the Array.


; IList.Item[Int32]
; Gets or sets the element at the specified index.
