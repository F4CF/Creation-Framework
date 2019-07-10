ScriptName System:XSE:Armor Extends System:Armor Native Const Hidden


bool Function HasEyeSlot(Armor this) Global
	return this && HasSlotMask(this, this.kSlotMask47)
EndFunction


; Returns true if this has the given slot mask.
bool Function HasSlotMask(Armor this, int value) Global
	return this && Math.LogicalAnd(this.GetSlotMask(), value) == value
EndFunction
