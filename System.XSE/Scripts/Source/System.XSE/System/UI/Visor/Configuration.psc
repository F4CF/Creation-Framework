ScriptName System:UI:Visor:Configuration Extends System:Object
import System:Log

; Methods
;---------------------------------------------

Function SetAlpha(float value)
	SystemXSE_UI_Visor_Alpha.SetValue(value)
	If (Menu.IsOpen)
		Menu.SetAlpha(value)
	EndIf
	WriteLine("System", self, "SetAlpha", value)
EndFunction


Function SetAlphaSpeed(float value)
	SystemXSE_UI_Visor_AlphaSpeed.SetValue(value)
	WriteLine("System", self, "SetAlphaSpeed", value)
EndFunction


Function SetScopeAlpha(float value)
	SystemXSE_UI_Visor_Scope_Alpha.SetValue(value)
	WriteLine("System", self, "SetScopeAlpha", value)
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
			SystemXSE_UI_Visor_Alpha.SetValue(value)
		EndFunction
	EndProperty

	float Property AlphaSpeed Hidden
		float Function Get()
			return SystemXSE_UI_Visor_AlphaSpeed.GetValue()
		EndFunction
		Function Set(float value)
			SystemXSE_UI_Visor_AlphaSpeed.SetValue(value)
		EndFunction
	EndProperty

	float Property ScopeAlpha Hidden
		float Function Get()
			return SystemXSE_UI_Visor_Scope_Alpha.GetValue()
		EndFunction
		Function Set(float value)
			SystemXSE_UI_Visor_Scope_Alpha.SetValue(value)
		EndFunction
	EndProperty
EndGroup
