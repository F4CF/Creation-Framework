ScriptName System:XSE:Armor Extends System:Armor Native Const Hidden


bool Function HasEyeSlot(Armor this) Global
	return this && HasSlot(this, this.kSlotMask47)
EndFunction


; Returns true if this Armor contains the slot within the armor's slot mask.
bool Function HasSlot(Armor this, int value) Global
	return this && Math.LogicalAnd(this.GetSlotMask(), value) == value
EndFunction
