Scriptname System:XSE:ObjectMod extends System:ObjectMod Native Const Hidden
import System:Log


Group IsScope
	Keyword Property HasScope Auto Const Mandatory
	Keyword Property HasScopeRecon  Auto Const Mandatory
EndGroup

bool Function IsScope(ObjectMod omod)
	int Invalid = -1 const
	If (omod)
		ObjectMod:PropertyModifier[] properties = omod.GetPropertyModifiers()
		bool bHasScope = properties.FindStruct("object", HasScope) > Invalid
		return bHasScope || properties.FindStruct("object", HasScopeRecon) > Invalid
	Else
		return false
	EndIf
EndFunction


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
