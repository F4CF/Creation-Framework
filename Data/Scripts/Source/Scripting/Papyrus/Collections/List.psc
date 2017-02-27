Scriptname Papyrus:Collections:List extends Papyrus:Collections:Collection Default
import Papyrus:Array
import Papyrus:Collections
import Papyrus:Diagnostics:Log

UserLog Log

var[] Collection
CustomEvent CollectionChanged
CustomEvent PropertyChanged


; Events
;---------------------------------------------

Event OnInit()
	Log = new UserLog
	Log.Caller = self
	Log.FileName = "Papyrus_Collections"
	Collection = new var[0]
	RegisterForCustomEvent(self, "CollectionChanged")
	RegisterForCustomEvent(self, "PropertyChanged")
	WriteLine(Log, "The context has initialized.")
EndEvent


Event OnCollectionChanged(NotifyCollectionChangedEventArgs e)
	{Occurs when an item is added, removed, changed, moved, or the entire list is refreshed.}
EndEvent


Event OnPropertyChanged(PropertyChangedEventArgs e)
	{Occurs when a property value changes.}
EndEvent



; Functions
;---------------------------------------------



; Properties
;---------------------------------------------
