ScriptName System:XSE:Actor Extends System:Actor Native Const Hidden
import System:Debug
import System:XSE:Armor


; Scans down the highest slot of an armor.
; Only the highest slot within a slot mask contains a valid form.
; Even though an armor may cover multiple slots, the lower ones dont hold valid form data.
;
; **TODO**
; * This has not been made fully generic yet.
;
; **Example**
; The biped eyes are slot index 17, `GetWorn(self, 17)`.
Actor:WornItem Function GetWorn(Actor this, int slotIndex) Global
	bool ThirdPerson = false const
	int slot = 0
	While (slot <= slotIndex)
		Actor:WornItem worn = this.GetWornItem(slot, ThirdPerson)
		Armor armo = worn.Item as Armor
		If (HasEyeSlot(armo))
			return worn
		EndIf
		slot += 1
	EndWhile
	WriteLine(this, "GetWorn", "No biped slot has a valid armor.")
	return none
EndFunction
