ScriptName System:Actor Extends System:Object Native Const Hidden

; Instance
;---------------------------------------------

Actor Property NPC Hidden
	Actor Function Get()
		return NPC()
	EndFunction
EndProperty

; @virtual
Actor Function NPC()
	Actor this = System:Type.AsActor(self)
	System:Debug.Assert(this, "Exception: Invalid Object! This must be of the `Actor` type.")
	return this
EndFunction
