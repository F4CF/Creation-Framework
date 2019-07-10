Scriptname System:GlobalVariable Extends System:Object Native Const Hidden
{A numeric variable that can be referenced from all over the game.

**See Also**
* https://www.creationkit.com/fallout4/index.php?title=Global
}

; Instance
;---------------------------------------------

GlobalVariable Property GLOB Hidden
	GlobalVariable Function Get()
		return GLOB()
	EndFunction
EndProperty

; @virtual
GlobalVariable Function GLOB()
	GlobalVariable this = System:Type.AsGlobalVariable(self)
	System:Debug.Assert(this, "Exception: Invalid Object! This must be of the `GlobalVariable` type.")
	return this
EndFunction


; Methods
;---------------------------------------------

; @return: True if the GlobalVariable value is non-zero.
bool Function ToBoolean(GlobalVariable this) Global
	If (this)
		return this.GetValue()
	Else
		return false
	EndIf
EndFunction
