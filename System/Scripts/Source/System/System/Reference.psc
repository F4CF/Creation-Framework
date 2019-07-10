ScriptName System:Reference Extends System:Object Native Const Hidden
import System:PointType

; Instance
;---------------------------------------------

ObjectReference Property REF Hidden
	ObjectReference Function Get()
		return REF()
	EndFunction
EndProperty

; @virtual
ObjectReference Function REF()
	ObjectReference this = System:Type.AsReference(self)
	System:Debug.Assert(this, "Exception: Invalid Object! This must be of the `ObjectReference` type.")
	return this
EndFunction


; References
;---------------------------------------------

Point Function ToPosition(ObjectReference this) Global
	Point result = new Point
	If (this)
		result.X = this.X
		result.Y = this.Y
		result.Z = this.Z
	EndIf
	return result
EndFunction


Point Function ToAngle(ObjectReference this) Global
	Point result = new Point
	If (this)
		result.X = this.GetAngleX()
		result.Y = this.GetAngleY()
		result.Z = this.GetAngleZ()
	EndIf
	return result
EndFunction


Function SetPoint(ObjectReference this, Point position, Point angle) Global
	If (this)
		this.SetPosition(position.X, position.Y, position.Z)
		this.SetAngle(angle.X, angle.Y, angle.Z)
	EndIf
EndFunction
