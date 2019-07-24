ScriptName System:UI:Visor:Service Extends System:Quest
{The framework is used to track equipment changes on the player.}
import System:Debug
import System:Log
import System:UI:Events
import System:UI:MenuClient

Actor Player
Keyword ArmorBodyPartEyes
;---------------------------------------------
string File
string EquippedState = "Equipped" const
;---------------------------------------------
int BipedEyes = 17 const
bool ThirdPerson = false const
;---------------------------------------------
string ExamineMenu = "ExamineMenu" const
string ScopeMenu = "ScopeMenu" const


; Properties
;---------------------------------------------

Group Overlay
	System:UI:Visor:Menu Property Menu Auto Const Mandatory
	System:UI:Visor:Client Property Client Auto Const Mandatory
	System:UI:Visor:Configuration Property Configuration Auto Const Mandatory
EndGroup

Group Camera
	bool Property IsFirstPerson Hidden
		bool Function Get()
			return Game.GetCameraState() == 0
		EndFunction
	EndProperty
EndGroup


; Events
;---------------------------------------------

; TODO: This only happens once per object life time.
Event OnInit()
	RegisterForQuestInit(QUST)
	RegisterForQuestShutdown(QUST)
EndEvent


Event OnQuestInit()
	Player = Game.GetPlayer()
	RegisterForRemoteEvent(Player, "OnItemEquipped")
	RegisterForRemoteEvent(Player, "OnItemUnequipped")
	RegisterForGameReload(self)
	OnGameReload()
EndEvent


Event OnGameReload()
	Reload()
EndEvent


Event OnQuestShutdown()
	UnregisterForRemoteEvent(Player, "OnItemEquipped")
	UnregisterForRemoteEvent(Player, "OnItemUnequipped")
	UnregisterForGameReload(self)
	System:Object.ClearState(self)
EndEvent


Event Actor.OnItemEquipped(Actor sender, Form object, ObjectReference reference)
	{Evaluates the equipped object.}
	If (ItemFilter(object))
		WriteLine("System", self, "Actor.OnItemEquipped", "object="+object)
		Equipment()
	EndIf
EndEvent


; Any unequipped item events are ignored in the empty state.
Event Actor.OnItemUnequipped(Actor sender, Form object, ObjectReference reference)
	{EMPTY}
EndEvent


; Methods
;---------------------------------------------

Function Reload()
	System:Assembly:Fallout fallout = System:Assembly:Fallout.Type()
	ArmorBodyPartEyes = System:Type.ReadKeyword(fallout.File, fallout.ArmorBodyPartEyes)
EndFunction


bool Function ItemFilter(Form item)
	{Returns true if the given Form is of type Armor and occupies the Eye slot.}
	Armor armo = item as Armor
	return armo && System:XSE:Armor.HasSlot(armo, kSlotMask47)
EndFunction


bool Function Equipment()
	{Checks the players equipment for changes. This will NOT allow a change to a none or empty value.}
	string value = GetFile()
	If (value)
		If (TryChange(value))
			return System:Object.ChangeState(self, EquippedState)
		Else
			return false
		EndIf
	Else
		return false
	EndIf
EndFunction


string Function GetFile()
	{Gets the file path for any eye slot armor.}
	; #1 Check the Armor's ObjectMods for any associated loose mod with an icon path.
	; #2 Check the Armor's world model path.
	; #3 Check the Armor's model path.
	int slot = 0
	While (slot <= BipedEyes)
		Actor:WornItem worn = Player.GetWornItem(slot, ThirdPerson)
		If (ItemFilter(worn.Item))
			string value
			ObjectMod[] mods = Player.GetWornItemMods(slot)
			If (mods)
				int index = 0
				While (index < mods.Length)
					value = GetLooseMod(mods[index])
					If (value)
						WriteLine("System", self, "GetFile", "LooseMod:'"+value+"'")
						return value
					EndIf
					index += 1
				EndWhile
			EndIf
			;---------------------------------------------
			value = GetWorldModel(worn)
			If (value)
				WriteLine("System", self, "GetFile", "WorldModel:'"+value+"'")
				return value
			Else
				value = GetModel(worn)
				WriteLine("System", self, "GetFile", "Model:'"+value+"'")
				return value
			EndIf
		EndIf
		slot += 1
	EndWhile
	return ""
EndFunction


string Function GetLooseMod(ObjectMod omod)
	{Defined by the loose mod icon path.}
	MiscObject misc = omod.GetLooseMod()
	If (misc && misc.HasKeyword(ArmorBodyPartEyes))
		return misc.GetIconPath()
	Else
		return ""
	EndIf
EndFunction


string Function GetWorldModel(Actor:WornItem worn)
	{Derived from the armor world model path.}
	Armor armo = worn.Item as Armor
	If (armo && armo.HasWorldModel())
		return armo.GetWorldModelPath()
	Else
		return ""
	EndIf
EndFunction


string Function GetModel(Actor:WornItem worn)
	{Derived from the armor model name.}
	return worn.ModelName
EndFunction


bool Function TryChange(string value)
	{A none value is valid for TryChange.}
	If (value != File)
		WriteChangedValue("System", self, "File", File, value)
		File = value
		return true
	Else
		WriteUnexpectedValue(self, "TryChange", "value", "The File already equals '"+value+"'")
		return false
	EndIf
EndFunction


; States
;---------------------------------------------

State Equipped
	Event OnBeginState(string oldState)
		WriteLine("System", self, "Equipped.OnBeginState")
		RegisterForCameraState()
		RegisterForMenuOpenCloseEvent(Menu.Name)
		RegisterForMenuOpenCloseEvent(ExamineMenu)
		RegisterForMenuOpenCloseEvent(ScopeMenu)
		Menu.Open()
	EndEvent

	;---------------------------------------------

	Event OnGameReload()
		WriteLine("System", self, "Equipped.OnGameReload")
		Reload()
		Menu.Open()
	EndEvent

	Event OnMenuOpenCloseEvent(string menuName, bool opening)
		WriteLine("System", self, "Equipped.OnMenuOpenCloseEvent(menuName="+menuName+", opening="+opening+")")
		If (menuName == Menu.Name)
			If (opening)
				Menu.Load(File)
				Menu.SetAlpha(Configuration.Alpha)
				Menu.SetVisible(IsFirstPerson)
			Else
				Menu.Open()
			EndIf
			OpenCloseEventArgs e = new OpenCloseEventArgs
			e.Opening = opening
			SendOpenCloseEvent(e)
		EndIf

		If (menuName == ScopeMenu)
			If (opening)
				Menu.AlphaTo(Configuration.ScopeAlpha, Configuration.AlphaSpeed)
			Else
				Menu.AlphaTo(Configuration.Alpha, Configuration.AlphaSpeed)
			EndIf
		EndIf

		If (menuName == ExamineMenu && !opening)
			Menu.Load(File)
		EndIf
	EndEvent

	Event OnPlayerCameraState(int oldState, int newState)
		WriteLine("System", self, "Equipped.OnPlayerCameraState(oldState="+oldState+", newState="+newState+") -- IsFirstPerson:"+IsFirstPerson)
		Menu.SetVisible(IsFirstPerson)
	EndEvent

	;---------------------------------------------

	Event Actor.OnItemEquipped(Actor sender, Form object, ObjectReference reference)
		{Evaluates the equipped object.}
		If (ItemFilter(object))
			WriteLine("System", self, "Equipped.Actor.OnItemEquipped", "object="+object)
			Equipment()
		EndIf
	EndEvent

	Event Actor.OnItemUnequipped(Actor sender, Form object, ObjectReference reference)
		{Evaluates the unequipped object.}
		If (ItemFilter(object))
			WriteLine("System", self, "Equipped.Actor.OnItemUnequipped", "object="+object)
			Equipment()
		EndIf
	EndEvent

	bool Function Equipment()
		{Checks the players equipment for changes. This will ALLOW a change to none or empty.}
		string value = GetFile()
		If (TryChange(value))
			If (!value)
				return System:Object.ClearState(self)
			Else
				return Menu.Load(File)
			EndIf
		Else
			return false
		EndIf
	EndFunction

	;---------------------------------------------

	Event OnEndState(string newState)
		WriteLine("System", self, "Equipped.OnEndState")
		UnregisterForCameraState()
		UnregisterForMenuOpenCloseEvent(Menu.Name)
		UnregisterForMenuOpenCloseEvent(ExamineMenu)
		UnregisterForMenuOpenCloseEvent(ScopeMenu)
		Menu.Close()
	EndEvent
EndState


; Client
;---------------------------------------------

Function SendOpenCloseEvent(OpenCloseEventArgs e)
	If (e)
		var[] arguments = new var[1]
		arguments[0] = e
		; Client.SendCustomEvent("OpenCloseEvent", arguments)
	Else
		WriteUnexpectedValue(self, "SendOpenCloseEvent", "e", "The argument cannot be none.")
	EndIf
EndFunction


Function SendLoadedEvent(LoadedEventArgs e)
	If (e)
		var[] arguments = new var[1]
		arguments[0] = e
		; Client.SendCustomEvent("LoadedEvent", arguments)
	Else
		WriteUnexpectedValue(self, "SendLoadedEvent", "e", "The argument cannot be none.")
	EndIf
EndFunction


Actor:WornItem Function GetWorn()
	{Scans down the highest slot of an eye slot armor.}
	int slot = 0
	While (slot <= BipedEyes)
		Actor:WornItem worn = Player.GetWornItem(slot, ThirdPerson)
		If (ItemFilter(worn.Item))
			return worn
		EndIf
		slot += 1
	EndWhile
	WriteUnexpectedValue(self, "GetWorn", "value", "No biped slot has a valid eyes item.")
	return none
EndFunction


; ; Armor
; ;---------------------------------------------

; bool Function HasSlot(Armor armo, int value) Global
; 	{Returns true if the given Armor contains the Eye slot within it's slot mask.}
; 	return Math.LogicalAnd(armo.GetSlotMask(), value) == value
; EndFunction
