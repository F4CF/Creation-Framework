Scriptname System:XSE:ObjectMod extends System:ObjectMod Native Const Hidden
import System:Log

; Debug
;---------------------------------------------

bool Function TracePropertyModifiers(ObjectMod this) Global DebugOnly
	{Traces each property modifier on the given ObjectMod type.}
	string prefix = "[ObjectModEx.psc (TracePropertyModifiers)]" const
	If (this)
		ObjectMod:PropertyModifier[] array = this.GetPropertyModifiers()
		If (array)
			int index = 0
			While (index < array.Length)
				WriteLine(prefix, this+" has PropertyModifier: "+array[index]+", @"+index)
				index += 1
			EndWhile
			return true
		Else
			WriteLine(prefix, this+" has no property modifiers.")
			return false
		EndIf
	Else
		WriteLine(prefix, "Cannot trace property modifiers on none ObjectMod.")
		return false
	EndIf
EndFunction
