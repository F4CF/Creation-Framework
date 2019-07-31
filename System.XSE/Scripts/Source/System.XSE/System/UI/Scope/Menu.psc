ScriptName System:UI:Scope:Menu Extends System:UI:Scope:MenuType
{The scope menu service provides backend for the scope menu.}
import System:Debug
import System:UI:MenuClient
import System:UI:OpenCloseEvent
import System:UI:Scope:BreathEvent

IClient IClient_

Actor Player

string ScopeAsset
bool BreathPressed = false
bool Interrupted = false

string SystemScopeMenu_ClientLoadedCallback = "SystemScopeMenu_ClientLoadedCallback" const
int BipedWeapon = 41 const

; Properties
;---------------------------------------------

Group Properties
	System:UI:OpenCloseEvent Property OpenClose Auto Const Mandatory
	{@IMenu}

	ActorValue Property ActionPoints Auto Const Mandatory

	Keyword Property HasScope Auto Const Mandatory
	{The keyword an OMOD must add via its property modifiers.}

	Keyword Property HasScopeRecon  Auto Const Mandatory
	{The keyword an OMOD must add via its property modifiers.}
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
	RegisterForRemoteEvent(Player, "OnItemEquipped")
	RegisterForRemoteEvent(Player, "OnPlayerModArmorWeapon")
	RegisterForMenuOpenCloseEvent(Name)
	RegisterForGameReload(self)
	OnGameReload()
EndEvent


Event OnQuestShutdown()
	Player.RemoveSpell(SystemXSE_UI_ScopeBreathEvent)
	UnregisterForAllEvents()
EndEvent


Event OnGameReload()
	; RegisterForExternalEvent(ClientLoadedCallback, "OnClientLoaded")

	RegisterForMenuOpenCloseEvent(Name)
	WriteLine(self, "OnGameReload", log="System")
EndEvent

;---------------------------------------------

Event Actor.OnItemEquipped(Actor sender, Form akBaseObject, ObjectReference akReference)
	If (akBaseObject is Weapon)
		ScopeAsset = GetModelPath()
	EndIf
EndEvent


Event Actor.OnPlayerModArmorWeapon(Actor sender, Form akBaseObject, ObjectMod akModBaseObject)
	If (akBaseObject is Weapon)
		ScopeAsset = GetModelPath()
	EndIf
EndEvent


string Function GetModelPath()
	ObjectMod[] array = Player.GetWornItemMods(BipedWeapon)
	If (array)
		int index = 0
		While (index < array.Length)
			ObjectMod omod = array[index]
			If (omod.HasWorldModel() && IsScope(omod))
				return omod.GetWorldModelPath()
			EndIf
			index += 1
		EndWhile
		return none
	EndIf
EndFunction


bool Function IsScope(ObjectMod omod)
	If (omod)
		ObjectMod:PropertyModifier[] properties = omod.GetPropertyModifiers()
		bool bHasScope = properties.FindStruct("object", HasScope) > Invalid
		return bHasScope || properties.FindStruct("object", HasScopeRecon) > Invalid
	Else
		return false
	EndIf
EndFunction

;---------------------------------------------

Event OnMenuOpenCloseEvent(string menuName, bool opening)
	BreathPressed = false
	If (opening)
		Load(menuName)
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
	If (!success)
		WriteUnexpectedValue(self, "OnLoadComplete", "success", "The `"+assetFile+"` asset could not be loaded into `"+menuName+"`.", log="System")
	EndIf
	IClient().Variable = assetInstance
	IClient().Loaded = success
	WriteLine(self, "OnLoadComplete", "(success:"+success+", menuName:"+menuName+", menuRoot:"+menuRoot+", assetInstance:"+assetInstance+", assetFile:"+assetFile+")", log="System")
EndEvent


Event OnClientLoaded(bool success, string instance)
	IClient().Loaded = success
	If (success)
		IClient().Variable = instance
	Else
		IClient().Variable = ""
	EndIf
	WriteLine(self, "OnClientLoaded", "(success:"+success+", instance:"+instance+") "+ToString(), log="System")
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


bool Function LoadAsset(string filePath)
	If (IsOpen)
		If (filePath)
			var[] arguments = new var[1]
			arguments[0] = filePath
			UI.Invoke(Name, GetMember("Load"), arguments)
			WriteLine(self, "Load", filePath)
			return true
		Else
			WriteUnexpectedValue(self, "Load", "filepath", "The argument cannot be none or empty.")
			return false
		EndIf
	Else
		WriteUnexpected(self, "Load", ToString()+" is not open.")
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
