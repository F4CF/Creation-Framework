ScriptName System:UI:Scope:Menu Extends System:UI:Scope:MenuType
{The scope menu service provides backend for the scope menu.}
import System:Debug
import System:UI:MenuClient
import System:UI:OpenCloseEvent
import System:UI:Scope:BreathEvent

IClient IClient_

Actor Player
ActorValue ActionPoints

bool BreathPressed = false
bool Interrupted = false


; Properties
;---------------------------------------------

Group Events
	System:UI:OpenCloseEvent Property OpenClose Auto Const Mandatory
	{@IMenu}
EndGroup

Group Breath
	System:UI:Scope:BreathEvent Property BreathEvent Auto Const Mandatory

	Spell Property SystemXSE_UI_ScopeBreathEvent Auto Const Mandatory

	int Property BreathHeld = 0 AutoReadOnly
	int Property BreathReleased = 1 AutoReadOnly
	int Property BreathInterrupted = 2 AutoReadOnly

	int Property BreathKey = 164 AutoReadOnly

	bool Property IsBreathKeyDown Hidden
		bool Function Get()
			return BreathPressed
		EndFunction
	EndProperty

	bool Property HasBreath Hidden
		bool Function Get()
			return Player.GetValue(ActionPoints) > 0
		EndFunction
	EndProperty
EndGroup

Group Identifiers
	int Property Default = 0 AutoReadOnly
	int Property Fine = 1 AutoReadOnly
	int Property Duplex = 2 AutoReadOnly
	int Property German = 3 AutoReadOnly
	int Property Dot = 4 AutoReadOnly
	int Property MilDot = 5 AutoReadOnly
	int Property Circle = 6 AutoReadOnly
	int Property OldRangefind = 7 AutoReadOnly
	int Property ModernRangefind = 8 AutoReadOnly
	int Property SVD = 9 AutoReadOnly
	int Property HandPainted = 10 AutoReadOnly
	int Property Binoculars = 11 AutoReadOnly
	int Property M14NightVision = 12 AutoReadOnly
	int Property Zero = 13 AutoReadOnly
	int Property InternalRangefinder = 14 AutoReadOnly
	int Property Rangefinder00 = 15 AutoReadOnly
	int Property AssaultRifle_REC = 16 AutoReadOnly
	int Property GaussRiflePrototypeA = 17 AutoReadOnly
	int Property GaussRiflePrototypeB = 18 AutoReadOnly
	int Property SolarCannon = 19 AutoReadOnly
	int Property SolarCannonNight = 20 AutoReadOnly
	int Property Empty = 21 AutoReadOnly
EndGroup


; Interfaces
;---------------------------------------------

; @overrides
IMenu Function IMenu()
	IMenu this = new IMenu
	this.Name = "ScopeMenu"
	this.Variable = ".ScopeMenuInstance"
	this.OpenClose = OpenClose
	return this
EndFunction



; @overrides
IClient Function IClient()
	return IClient_
EndFunction

; Events
;---------------------------------------------

; TODO: This only happens once per object life time.
Event OnInit()
	IClient_ = new IClient
	IClient_.File = "SystemScopeClient"
	RegisterForQuestInit(QUST)
	RegisterForQuestShutdown(QUST)
EndEvent


Event OnQuestInit()
	Player = Game.GetPlayer()
	Player.AddSpell(SystemXSE_UI_ScopeBreathEvent)
	RegisterForMenuOpenCloseEvent(Name)
	RegisterForGameReload(self)
	OnGameReload()
EndEvent


Event OnGameReload()
	System:Assembly:Fallout fallout = System:Assembly:Fallout.Type()
	ActionPoints = System:Type.ReadActorValue(fallout.File, fallout.ActionPoints)

	RegisterForMenuOpenCloseEvent(Name)
	WriteLine(self, "OnGameReload", log="System")
EndEvent


Event OnQuestShutdown()
	UnregisterForAllEvents()
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	BreathPressed = false
	If (opening)
		RegisterForKey(BreathKey)
	Else
		UnregisterForKey(BreathKey)
	EndIf

	OpenCloseEventArgs e = new OpenCloseEventArgs
	e.Opening = opening
	IMenu().OpenClose.Send(self, e)
EndEvent

; @F4SE
Event OnLoadComplete(bool success, string menuName, string menuRoot, string assetInstance, string assetFile)
	{The UI loaded callback.}
	WriteLine(self, "OnLoadComplete", "(success:"+success+", menuName:"+menuName+", menuRoot:"+menuRoot+", assetInstance:"+assetInstance+", assetFile:"+assetFile+")", log="System")
	If (!success)
		WriteUnexpectedValue(self, "OnLoadComplete", "success", "The `"+assetFile+"` asset could not be loaded into `"+menuName+"`.", log="System")
	EndIf
	IClient().Variable = assetInstance
	IClient().Loaded = success
EndEvent



Event OnKeyDown(int keyCode)
	BreathPressed = true
	BreathEvent(BreathHeld)
EndEvent


Event OnKeyUp(int keyCode, float time)
	BreathPressed = false
	If (Interrupted)
		Interrupted = false
	Else
		BreathEvent(BreathReleased)
	EndIf
EndEvent


; Methods
;---------------------------------------------

bool Function BreathEvent(int breath)
	If (IsOpen)
		Interrupted = breath == BreathInterrupted
		BreathEventArgs e = new BreathEventArgs
		e.Breath = breath
		return BreathEvent.Send(self, e)
	Else
		return false
	EndIf
EndFunction


bool Function SetOverlay(int identifier)
	If (IsOpen)
		If (identifier >= Default && identifier <= Empty)
			var[] arguments = new var[1]
			arguments[0] = identifier
			UI.Invoke(Name, GetMember("SetOverlay", Variable), arguments)
			WriteLine(self, "SetOverlay", identifier, log="System")
			return true
		Else
			WriteUnexpectedValue(self, "SetOverlay", "identifier", "The value of "+identifier+" is out of range.", log="System")
			return false
		EndIf
	Else
		WriteUnexpected(self, "SetOverlay", ToString()+" is not open.", log="System")
		return false
	EndIf
EndFunction


string Function ToString()
	{The string representation of this type.}
	return parent.ToString()+"[Variable:"+Variable+"]"
EndFunction
