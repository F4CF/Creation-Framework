ScriptName Scripting:Activation Extends System:Quest Default
import System:Log


;/ TODO:
- The argument auiEntryID, is this an index or ID?
/;

;/ Perk Choices (4)
|--------------------------------------------------------|
|  Entry  | Control | Priority | Position | Entry Point  |
|--------------------------------------------------------|
|    1    |    A    |   100    | Bottom   |   Set Text   |
|    2    |    B    |   90     | Right    | Add Activate |
|    3    |    X    |   80     | Left     | Add Activate |
|    4    |    Y    |   70     | Top      | Add Activate |
|--------------------------------------------------------|
|   [4]   |   [Y]   |                                    |
| [3] [2] | [X] [B] |                                    |
|   [1]   |   [A]   |                                    |
|---------------------------------------------------------
/;

;/ Perk Choices (2)
|--------------------------------------------------------|
|  Entry  | Control | Priority | Position | Entry Point  |
|--------------------------------------------------------|
|    1    |    A    |   100    | Left     |   Set Text   |
|    2    |    B    |   90     | Right    | Add Activate |
|--------------------------------------------------------|
| [1] [2] | [A] [B] |                                    |
|---------------------------------------------------------
/;

;/ Menus
|--------- Wagering ---------|
|----------------------------|
|           [???]            |
|   [Increase] [Decrease]    |
|          [Accept]          |
|----------------------------|


|--------- Playing ----------|
|----------------------------|
|           [More]           |
|        [Hit] [Stay]        |
|         [Continue]         |
|----------------------------|
|----------------------------|
|           [More]           |
|      [Split]  [Double]     |
|         [Continue]         |
|----------------------------|

-All selections in playing will trigger an "accept".
/;


Actor Player

CustomEvent OnSelected
ActivationData Data

Struct ActivationData
	ObjectReference Reference
	Perk Menu
	int Selected = -1
EndStruct


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
	Data = new ActivationData
EndEvent


; Methods
;---------------------------------------------

bool Function Show(ObjectReference object, Perk perkMenu)
	{Shows the activation menu for the given reference.}
	If (System:Object.StateRunning(self))
		WriteLine("System", self, "Activation menu is already shown.")
		return Incomplete
	Else
		If (object)
			If (perkMenu)
				Data = new ActivationData
				Data.Menu = perkMenu
				Data.Reference = object
				return System:Object.AwaitState(self)
			Else
				WriteLine("System", self, "Cannot show a none activate menu perk.")
				return Incomplete
			EndIf
		Else
			WriteLine("System", self, "Cannot show activate menu on a none reference.")
			return Incomplete
		EndIf
	EndIf
EndFunction


Function Accept()
	{Clears the activation menu on the given reference.}
	System:Object.ClearState(self)
EndFunction


; Task
;---------------------------------------------

State Busy
	Event OnBeginState(string oldState)
		RegisterForRemoteEvent(Reference, "OnActivate")
		RegisterForRemoteEvent(Menu, "OnEntryRun")
		Player.AddPerk(Menu)
	EndEvent


	Event ObjectReference.OnActivate(ObjectReference sender, ObjectReference actionRef)
		Data.Selected = 0
		SendCustomEvent("OnSelected")
	EndEvent


	Event Perk.OnEntryRun(Perk sender, int entryID, ObjectReference target, Actor owner)
		Data.Selected = entryID
		SendCustomEvent("OnSelected")
	EndEvent


	Event Scripting:Activation.OnSelected(Scripting:Activation sender, var[] arguments)
		WriteLine("System", self, "Selected "+sender.Selected)
	EndEvent


	Event OnEndState(string newState)
		UnregisterForRemoteEvent(Reference, "OnActivate")
		UnregisterForRemoteEvent(Menu, "OnEntryRun")
		Player.RemovePerk(Menu)
	EndEvent
EndState


Event ObjectReference.OnActivate(ObjectReference sender, ObjectReference actionRef)
	{EMPTY}
EndEvent

Event Perk.OnEntryRun(Perk sender, int entryID, ObjectReference target, Actor owner)
	{EMPTY}
EndEvent

Event Scripting:Activation.OnSelected(Scripting:Activation sender, var[] arguments)
	{EMPTY}
EndEvent


; Properties
;---------------------------------------------

Group Properties
	bool Property Completed = true AutoReadOnly
	bool Property Incomplete = false AutoReadOnly
EndGroup

Group Activation
	ObjectReference Property Reference Hidden
		ObjectReference Function Get()
			return Data.Reference
		EndFunction
	EndProperty

	Perk Property Menu Hidden
		Perk Function Get()
			return Data.Menu
		EndFunction
	EndProperty

	int Property Selected Hidden
		int Function Get()
			return Data.Selected
		EndFunction
	EndProperty
EndGroup
