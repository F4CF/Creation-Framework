Scriptname System:XSE:ObjectMod Extends System:ObjectMod Native Const Hidden
import System:Log

; TODO: Avoid dependency on non-system data files.
bool Function IsScope(ObjectMod this)
	If (this)
		; int Invalid = -1 const

		; HasScope [KYWD:0009F425]
		Keyword HasScope = Game.GetFormFromFile(0x0009F425, "Fallout4.esm") as Keyword
		; HasScopeRecon [KYWD:00184C55]
		Keyword HasScopeRecon = Game.GetFormFromFile(0x00184C55, "Fallout4.esm") as Keyword

		ObjectMod:PropertyModifier[] properties = this.GetPropertyModifiers()
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
	string prefix = "[System:XSE:ObjectMod (TracePropertyModifiers)]" const
	If (this)
		ObjectMod:PropertyModifier[] array = this.GetPropertyModifiers()
		If (array)
			int index = 0
			While (index < array.Length)
				WriteLine("System", prefix, this+" has PropertyModifier: "+array[index]+", @"+index)
				index += 1
			EndWhile
			return true
		Else
			WriteLine("System", prefix, this+" has no property modifiers.")
			return false
		EndIf
	Else
		WriteLine("System", prefix, "Cannot trace property modifiers on none ObjectMod.")
		return false
	EndIf
EndFunction
