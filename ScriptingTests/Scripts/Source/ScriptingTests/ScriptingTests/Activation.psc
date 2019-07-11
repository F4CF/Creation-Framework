ScriptName ScriptingTests:Activation Extends System:Diagnostics:UnitTest
import System
import System:Log


; Events
;---------------------------------------------

Event OnInit()
	RegisterForCustomEvent(Activation, "OnSelected")
EndEvent


; Tasks
;---------------------------------------------

State Wagering
	Function Try()
		Activation.Show(Games_Blackjack_ActivateMenu, Games_Blackjack_Activate_Wager)
		; waits for result
	EndFunction

	Event Scripting:Activation.OnSelected(Scripting:Activation sender, var[] arguments)
		If (sender.Menu == Games_Blackjack_Activate_Wager)
			; |   [3]   |
			; | [2] [1] |
			; |   [0]   |
			int OptionAccept = 0 const
			int OptionDecrease = 1 const
			int OptionIncrease = 2 const

			int value = 5 const

			If (sender.Selected == OptionIncrease)
				; IncreaseWager(value)
			EndIf

			If (sender.Selected == OptionDecrease)
				; DecreaseWager(value)
			EndIf

			If (sender.Selected == OptionAccept)
				; sender.Accept()
			EndIf
		EndIf
	EndEvent
EndState


State Playing
	Function Try()
		Activation.Show(Games_Blackjack_ActivateMenu, Games_Blackjack_Activate_Turn)
		int result = Activation.Selected
	EndFunction

	Event Scripting:Activation.OnSelected(Scripting:Activation sender, var[] arguments)
		If (sender.Menu == Games_Blackjack_Activate_Turn)
			sender.Accept()
		EndIf
	EndEvent
EndState


State Scoring
	Function Try()
		Activation.Show(Games_Blackjack_ActivateMenu, Games_Blackjack_Activate_Replay)
		int OptionNo = 0 const
		int OptionYes = 1 const

		If (Activation.Selected == OptionNo)
			WriteMessage("Scripting", self, "Selected", "Replay No")
			; TODO: does nothing
		EndIf

		If (Activation.Selected == OptionYes)
			WriteMessage("Scripting", self, "Selected", "Replay Yes")
			; TODO: does nothing
		EndIf
	EndFunction

	Event Scripting:Activation.OnSelected(Scripting:Activation sender, var[] arguments)
		If (sender.Menu == Games_Blackjack_Activate_Replay)
			sender.Accept()
		EndIf
	EndEvent
EndState


Function Try()
	{EMPTY}
EndFunction

Event Scripting:Activation.OnSelected(Scripting:Activation sender, var[] arguments)
	{EMPTY}
EndEvent


; Properties
;---------------------------------------------

Group Activation
	Scripting:Activation Property Activation Auto Const Mandatory

	ObjectReference Property Games_Blackjack_ActivateMenu Auto Const Mandatory
	Perk Property Games_Blackjack_Activate_Replay Auto Const Mandatory
	Perk Property Games_Blackjack_Activate_Turn Auto Const Mandatory
	Perk Property Games_Blackjack_Activate_Wager Auto Const Mandatory
EndGroup
