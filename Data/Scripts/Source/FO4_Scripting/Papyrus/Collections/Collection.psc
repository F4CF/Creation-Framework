Scriptname Papyrus:Collections:Collection extends ObjectReference Const Native Hidden


; Observable
;---------------------------------------------

Event OnCollectionChanged(NotifyCollectionChangedEventArgs e, var[] items)
	{Occurs when an item is added, removed, changed, moved, or the entire list is refreshed.}
EndEvent


Struct NotifyCollectionChangedEventArgs
	int ActionType = -1
	{Gets the action that caused the event.}

	int StartingIndex = -1
	{The zero-based index at which the change occurred.}
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


; Properties
;---------------------------------------------

Group Collection
	int Property Invalid = -1 AutoReadOnly
	int Property Maximum = 128 AutoReadOnly
EndGroup
