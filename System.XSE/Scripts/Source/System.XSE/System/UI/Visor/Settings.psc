ScriptName System:UI:Visor:Settings Extends System:Object
import System:Debug

; Methods
;---------------------------------------------

Function Alpha(float value)
	Alpha = value
EndFunction


Function AlphaSpeed(float value)
	AlphaSpeed = value
EndFunction


Function ScopeAlpha(float value)
	ScopeAlpha = value
EndFunction


; Properties
;---------------------------------------------

Group Properties
	System:UI:Visor:Menu Property Menu Auto Const Mandatory
	GlobalVariable Property SystemXSE_UI_Visor_Alpha Auto Const Mandatory
	GlobalVariable Property SystemXSE_UI_Visor_AlphaSpeed Auto Const Mandatory
	GlobalVariable Property SystemXSE_UI_Visor_Scope_Alpha Auto Const Mandatory
EndGroup

Group Settings
	float Property Alpha Hidden
		float Function Get()
			return SystemXSE_UI_Visor_Alpha.GetValue()
		EndFunction
		Function Set(float value)
			WriteChangedValue(self, "Alpha", Alpha, value, log="System")
			SystemXSE_UI_Visor_Alpha.SetValue(value)
			Menu.SetAlpha(value)
		EndFunction
	EndProperty

	float Property AlphaSpeed Hidden
		float Function Get()
			return SystemXSE_UI_Visor_AlphaSpeed.GetValue()
		EndFunction
		Function Set(float value)
			WriteChangedValue(self, "AlphaSpeed", AlphaSpeed, value, log="System")
			SystemXSE_UI_Visor_AlphaSpeed.SetValue(value)
		EndFunction
	EndProperty

	float Property ScopeAlpha Hidden
		float Function Get()
			return SystemXSE_UI_Visor_Scope_Alpha.GetValue()
		EndFunction
		Function Set(float value)
			WriteChangedValue(self, "ScopeAlpha", ScopeAlpha, value, log="System")
			SystemXSE_UI_Visor_Scope_Alpha.SetValue(value)
		EndFunction
	EndProperty
EndGroup
