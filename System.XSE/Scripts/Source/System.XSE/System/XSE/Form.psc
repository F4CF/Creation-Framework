Scriptname System:XSE:Form extends System:Object Native Const Hidden
import System:Log

; Debug
;---------------------------------------------

bool Function TraceKeywords(Form this) Global DebugOnly
	{Traces each Keyword on the given Form type.}
	string prefix = "[FormEx.psc (TraceKeywords)]" const
	If (this)
		Keyword[] array = this.GetKeywords()
		If (array)
			int index = 0
			While (index < array.Length)
				WriteLine("System", prefix, this+" has keyword: "+array[index]+", @"+index)
				index += 1
			EndWhile
			return true
		Else
			WriteLine("System", prefix, this+" has no keywords.")
			return false
		EndIf
	Else
		WriteLine("System", prefix, "Cannot trace keywords on none form.")
		return false
	EndIf
EndFunction
