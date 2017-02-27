Scriptname Papyrus:PointType Const Native Hidden
; https://msdn.microsoft.com/en-us/library/system.windows.point(v=vs.110).aspx
; https://msdn.microsoft.com/en-us/library/system.windows.media.media3d.vector3d(v=vs.110).aspx
; https://msdn.microsoft.com/en-us/library/system.windows.media.media3d.point3d(v=vs.110).aspx


; Point
;---------------------------------------------

Struct Point
	float X = 0.0
	float Y = 0.0
	float Z = 0.0
EndStruct


; Functions
;---------------------------------------------

string Function PointoString(Point value) Global
	{Returns a string that represents the Point.}
	return "X:"+value.X+", Y:"+value.Y+", Z:"+value.Z
EndFunction


float Function AngleBetween(Point value, Point other) Global
	{Retrieves the angle required to rotate the first specified Point structure into the second specified Point structure.}
EndFunction


float Function DotProduct(Point value, Point other) Global
	{Calculates the dot product of two Point structures.}
EndFunction


Point Function CrossProduct(Point value, Point other) Global
	{Calculates the cross product of two Point structures.}
EndFunction


Point Function Normalize() Global
	{Normalizes the specified Point structure.}
EndFunction


; Operators
;---------------------------------------------

bool Function Equality(Point value, Point other) Global
	{Compares two Point structures for equality.}
EndFunction


bool Function Inequality(Point value, Point other) Global
	{Compares two Point structures for inequality.}
EndFunction


Point Function Addition(Point value, Point other) Global
	{Adds two Point structures and returns the result as a Point structure.}
EndFunction


Point Function Subtraction(Point value, Point other) Global
	{Subtracts a Point structure from a Point structure.}
EndFunction


Point Function Multiply(Point value, float scalar) Global
	{Multiplies the specified Point structure by the specified scalar and returns the result as a Point.}
EndFunction


Point Function Division(Point value, float scalar) Global
	{Divides the specified Point structure by the specified scalar and returns the result as a Point.}
EndFunction


Point Function UnaryNegation(Point value) Global
	{Negates a Point structure.}
EndFunction


; Properties
;---------------------------------------------

Point Function Up() Global
	{Returns a unit vector designating up (0, 1, 0).}
	Point value = new Point
	value.X = 0
	value.Y = 1
	value.Z = 0
	return value
EndFunction


Point Function Down() Global
	{Returns a unit Point designating down (0, −1, 0).}
	Point value = new Point
	value.X = 0
	value.Y = -1
	value.Z = 0
	return value
EndFunction


Point Function Left() Global
	{Returns a unit Point designating left (−1, 0, 0).}
	Point value = new Point
	value.X = -1
	value.Y = 0
	value.Z = 0
	return value
EndFunction


Point Function Right() Global
	{Returns a unit Point pointing to the right (1, 0, 0).}
	Point value = new Point
	value.X = 1
	value.Y = 0
 	value.Z = 0
	return value
EndFunction


Point Function Forward() Global
	{Returns a unit Point designating forward in a right-handed coordinate system (0, 0, −1).}
	Point value = new Point
	value.X = 0
	value.Y = 0
	value.Z = -1
	return value
EndFunction


Point Function Backward() Global
	{Returns a unit Point designating backward in a right-handed coordinate system (0, 0, 1).}
	Point value = new Point
	value.X = 0
	value.Y = 0
	value.Z = 1
	return value
EndFunction


Point Function UnitX() Global
	{Returns the x unit Point (1, 0, 0).}
	Point value = new Point
	value.X = 1
	value.Y = 0
	value.Z = 0
	return value
EndFunction


Point Function UnitY() Global
	{Returns the y unit Point (0, 1, 0).}
	Point value = new Point
	value.X = 0
	value.Y = 1
	value.Z = 0
	return value
EndFunction


Point Function UnitZ() Global
	{Returns the z unit Point (0, 0, 1).}
	Point value = new Point
	value.X = 0
	value.Y = 0
	value.Z = 1
	return value
EndFunction


Point Function One() Global
	{Returns a Point with ones in all of its components.}
	Point value = new Point
	value.X = 1
	value.Y = 1
	value.Z = 1
	return value
EndFunction


Point Function Zero() Global
	{Returns a Point with all of its components set to zero.}
	Point value = new Point
	value.X = 0
	value.Y = 0
	value.Z = 0
	return value
EndFunction
