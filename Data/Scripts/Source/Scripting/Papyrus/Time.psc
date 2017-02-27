Scriptname Papyrus:Time Const Native Hidden
; http://www.creationkit.com/fallout4/index.php?title=GameTimeToString_-_Utility
; https://msdn.microsoft.com/en-us/library/system.datetime(v=vs.110).aspx
; https://msdn.microsoft.com/en-us/library/system.timespan(v=vs.110).aspx


; DateTime
;---------------------------------------------

Struct DateTime
	int Month = -1
	int Day = -1
	int Year = -1
	int Hour = -1
	int Minute = -1
EndStruct


; DateTime Operators
;---------------------------------------------

; Not Implemented
bool Function DateTimeEquality(DateTime value, DateTime other) Global
	{Determines whether two specified instances of DateTime are equal.}
EndFunction


; Not Implemented
bool Function DateTimeInequality(DateTime value, DateTime other) Global
	{Determines whether two specified instances of DateTime are not equal.}
EndFunction


; Not Implemented
bool Function DateTimeGreaterThan(DateTime value, DateTime other) Global
	{Determines whether one specified DateTime is later than another specified DateTime.}
EndFunction


; Not Implemented
bool Function DateTimeGreaterThanOrEqual(DateTime value, DateTime other) Global
	{Determines whether one specified DateTime represents a date and time that is the same as or later than another specified DateTime.}
EndFunction


; Not Implemented
bool Function DateTimeLessThan(DateTime value, DateTime other) Global
	{Determines whether one specified DateTime is earlier than another specified DateTime.}
EndFunction


; Not Implemented
bool Function DateTimeLessThanOrEqual(DateTime value, DateTime other) Global
	{Determines whether one specified DateTime represents a date and time that is the same as or earlier than another specified DateTime.}
EndFunction


; Not Implemented
bool Function DateTimeAddition(DateTime value, DateTime other) Global
	{Adds a specified time interval to a specified date and time, yielding a new date and time.}
EndFunction


; Not Implemented
bool Function DateTimeSubtraction(DateTime value, DateTime other) Global
	{Subtracts a specified date and time from another specified date and time and returns a time interval.}
EndFunction


; Not Implemented
bool Function DateTimeSubtractionTimeSpan(DateTime value, TimeSpan other) Global
	{Subtracts a specified time interval from a specified date and time and returns a new date and time.}
EndFunction




; TimeSpan
;---------------------------------------------

Struct TimeSpan
	int Months = -1
	int Days = -1
	int Years = -1
	int Hours = -1
	int Minutes = -1
EndStruct


; TimeSpan Operators
;---------------------------------------------

; Not Implemented
bool Function TimeSpanEquality(TimeSpan value, TimeSpan other) Global
	{Indicates whether two TimeSpan instances are equal.}
EndFunction


; Not Implemented
bool Function TimeSpanInequality(TimeSpan value, TimeSpan other) Global
	{Indicates whether two TimeSpan instances are not equal.}
EndFunction


; Not Implemented
bool Function TimeSpanGreaterThan(TimeSpan value, TimeSpan other) Global
	{Indicates whether a specified TimeSpan is greater than another specified TimeSpan.}
EndFunction


; Not Implemented
bool Function TimeSpanGreaterThanOrEqual(TimeSpan value, TimeSpan other) Global
	{Indicates whether a specified TimeSpan is greater than or equal to another specified TimeSpan.}
EndFunction


; Not Implemented
bool Function TimeSpanLessThan(TimeSpan value, TimeSpan other) Global
	{Indicates whether a specified TimeSpan is less than another specified TimeSpan.}
EndFunction


; Not Implemented
bool Function TimeSpanLessThanOrEqual(TimeSpan value, TimeSpan other) Global
	{Indicates whether a specified TimeSpan is less than or equal to another specified TimeSpan.}
EndFunction


; Not Implemented
bool Function TimeSpanAddition(TimeSpan value, TimeSpan other) Global
	{Adds two specified TimeSpan instances.}
EndFunction


; Not Implemented
bool Function TimeSpanSubtraction(TimeSpan value, TimeSpan other) Global
	{Subtracts a specified TimeSpan from another specified TimeSpan.}
EndFunction


; Not Implemented
bool Function TimeSpanUnaryPlus(TimeSpan value) Global
	{Returns the specified instance of TimeSpan.}
EndFunction


; Not Implemented
bool Function TimeSpanUnaryNegation(TimeSpan value) Global
	{Returns a TimeSpan whose value is the negated value of the specified instance.}
EndFunction
