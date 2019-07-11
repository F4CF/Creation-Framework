Scriptname System:Armor Extends System:Object Native Const Hidden
{An Armor form is an item that characters can equip and wear.

**See Also**
* https://www.creationkit.com/fallout4/index.php?title=Armor
* https://www.creationkit.com/fallout4/index.php?title=Armor_Script
}

; Instance
;---------------------------------------------

Armor Property ARMO Hidden
	Armor Function Get()
		return ARMO()
	EndFunction
EndProperty

; @virtual
Armor Function ARMO()
	Armor this = System:Type.AsArmor(self)
	System:Debug.Assert(this, "Exception: Invalid Object! This must be of the `Armor` type.")
	return this
EndFunction
