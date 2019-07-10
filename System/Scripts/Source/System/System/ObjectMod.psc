Scriptname System:ObjectMod Extends System:Object Native Const Hidden

; Instance
;---------------------------------------------

ObjectMod Property OMOD Hidden
	ObjectMod Function Get()
		return OMOD()
	EndFunction
EndProperty

; @virtual
ObjectMod Function OMOD()
	ObjectMod this = System:Type.AsObjectMod(self)
	System:Debug.Assert(this, "Exception: Invalid Object! This must be of the `ObjectMod` type.")
	return this
EndFunction
