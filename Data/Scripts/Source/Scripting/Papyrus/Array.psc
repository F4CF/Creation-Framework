Scriptname Papyrus:Array Const Native Hidden
; http://www.creationkit.com/fallout4/index.php?title=Array_Reference
; https://msdn.microsoft.com/en-us/library/system.array(v=vs.110).aspx
; https://msdn.microsoft.com/en-us/library/6sh2ey19.aspx  ; List<T> Class
; https://msdn.microsoft.com/en-us/library/bfcke1bz(v=vs.110).aspx ; Predicate<T> Delegate



; Functions
;---------------------------------------------

; ArrayToString()
; Returns a string that represents the current Array.


var[] Function GetDistinct(var[] array) Global ; linq
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


; GetLength(Int32)
; Gets a 32-bit integer that represents the number of elements in the specified dimension of the Array.


; GetLowerBound(Int32)
; Gets the index of the first element of the specified dimension in the array.


; GetUpperBound(Int32)
; Gets the index of the last element of the specified dimension in the array.


; Copy(Array, Array, Int32)
; Copies a range of elements from an Array starting at the first element and pastes them into another Array starting at the first element.


; Copy(Array, Int32, Array, Int32, Int32)
; Copies a range of elements from an Array starting at the specified source index and pastes them to another Array starting at the specified destination index.


; CopyTo(Array, Int32)
; Copies all the elements of the current one-dimensional array to the specified one-dimensional array starting at the specified destination array index.


; Empty<T>()
; Returns an empty array.


; Exists<T>(T[], Predicate<T>)
; Determines whether the specified array contains elements that match the conditions defined by the specified predicate.


; ForEach<T>(T[], Action<T>)
; Performs the specified action on each element of the specified array.


; Find<T>(T[], Predicate<T>)
; Searches for an element that matches the conditions defined by the specified predicate, and returns the first occurrence within the entire Array.


; FindAll<T>(T[], Predicate<T>)
; Retrieves all the elements that match the conditions defined by the specified predicate.


; FindIndex<T>(T[], Int32, Int32, Predicate<T>)
; Searches for an element that matches the conditions defined by the specified predicate.
; Returns the zero-based index of the first occurrence within the range of elements in the Array that starts at the specified index and contains the specified number of elements.


; FindIndex<T>(T[], Int32, Predicate<T>)
; Searches for an element that matches the conditions defined by the specified predicate, and returns the zero-based index of the first occurrence within the range of elements in the Array that extends from the specified index to the last element.


; FindIndex<T>(T[], Predicate<T>)
; Searches for an element that matches the conditions defined by the specified predicate, and returns the zero-based index of the first occurrence within the entire Array.


; FindLast<T>(T[], Predicate<T>)
; Searches for an element that matches the conditions defined by the specified predicate, and returns the last occurrence within the entire Array.


; FindLastIndex<T>(T[], Int32, Int32, Predicate<T>)
; Searches for an element that matches the conditions defined by the specified predicate,
; and returns the zero-based index of the last occurrence within the range of elements in the Array that contains the specified number of elements and ends at the specified index.


; FindLastIndex<T>(T[], Int32, Predicate<T>)
; Searches for an element that matches the conditions defined by the specified predicate,
; and returns the zero-based index of the last occurrence within the range of elements in the Array that extends from the first element to the specified index.


; FindLastIndex<T>(T[], Predicate<T>)
; Searches for an element that matches the conditions defined by the specified predicate, and returns the zero-based index of the last occurrence within the entire Array.


; GetValue(Int32)
; Gets the value at the specified position in the one-dimensional Array. The index is specified as a 32-bit integer.


; GetValue(Int32, Int32)
; Gets the value at the specified position in the two-dimensional Array. The indexes are specified as 32-bit integers.


; GetValue(Int32, Int32, Int32)
; Gets the value at the specified position in the three-dimensional Array. The indexes are specified as 32-bit integers.


; GetValue(Int32[])
; Gets the value at the specified position in the multidimensional Array. The indexes are specified as an array of 32-bit integers.


; IndexOf(Array, Object)
; Searches for the specified object and returns the index of its first occurrence in a one-dimensional array.


; IndexOf(Array, Object, Int32)
; Searches for the specified object in a range of elements of a one-dimensional array, and returns the index of its first occurrence. The range extends from a specified index to the end of the array.


; IndexOf(Array, Object, Int32, Int32)
; Searches for the specified object in a range of elements of a one-dimensional array, and returns the index of ifs first occurrence. The range extends from a specified index for a specified number of elements.


; LastIndexOf(Array, Object)
; Searches for the specified object and returns the index of the last occurrence within the entire one-dimensional Array.


; LastIndexOf(Array, Object, Int32)
; Searches for the specified object and returns the index of the last occurrence within the range of elements in the one-dimensional Array that extends from the first element to the specified index.


; LastIndexOf(Array, Object, Int32, Int32)
; Searches for the specified object and returns the index of the last occurrence within the range of elements in the one-dimensional Array that contains the specified number of elements and ends at the specified index.


; Resize<T>(T[], Int32)
; Changes the number of elements of a one-dimensional array to the specified new size.


; Reverse(Array)
; Reverses the sequence of the elements in the entire one-dimensional Array.


; Reverse(Array, Int32, Int32)
; Reverses the sequence of the elements in a range of elements in the one-dimensional Array.


; TrueForAll<T>(T[], Predicate<T>)
; Determines whether every element in the array matches the conditions defined by the specified predicate.


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
