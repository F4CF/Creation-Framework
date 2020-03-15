ScriptName System:Diagnostics:Console:Menu Extends System:Diagnostics:Console:MenuType
{Injects AS3 code into the vanilla Console menu.}

Actor Player

bool Loaded = false
string AssetValue = "" ; the loader's instance variable

string TestingEvent = "System_Diagnostics_TestingEvent" const


; Events
;---------------------------------------------

Event OnQuestInit()
	Player = Game.GetPlayer()
	OnGameReload()
	RegisterForGameReload(self)
	Debug.TraceSelf(self, "OnQuestInit", ToString())
EndEvent


Event OnQuestShutdown()
	UnregisterForAllEvents()
	Debug.TraceSelf(self, "OnQuestShutdown", ToString())
EndEvent


Event OnGameReload()
	RegisterForMenuOpenCloseEvent(Name)
	Debug.TraceSelf(self, "OnGameReload", ToString())
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	Debug.TraceSelf(self, "OnMenuOpenCloseEvent(menuName:"+menuName+", opening:"+opening+")", ToString())
	If (opening)
		UI.Load(Name, Root, File, self, "OnLoadComplete")
		RegisterForExternalEvent(TestingEvent, "OnTesting")
	Else
		UnregisterForExternalEvent(TestingEvent)
		Loaded = false
	EndIf
EndEvent


; @F4SE
Event OnLoadComplete(bool success, string menuName, string menuRoot, string assetInstance, string assetFile)
	{The UI loaded callback.}
	Debug.TraceSelf(self, "OnLoadComplete(success:"+success+", menuName:"+menuName+", menuRoot:"+menuRoot+", assetInstance:"+assetInstance+", assetFile:"+assetFile+")", ToString())
	If (!success)
		Debug.TraceSelf(self, "OnLoadComplete", ToString()+" The `"+assetFile+"` asset could not be loaded into `"+menuName+"`.")
	EndIf
	AssetValue = assetInstance
	Loaded = success
EndEvent


; @Scaleform
Event OnTesting()
	Debug.TraceSelf(self, "OnTesting", ToString())
EndEvent


; Methods
;---------------------------------------------

bool Function Open()
	If (IsRegistered)
		return UI.OpenMenu(Name)
	Else
		Debug.TraceSelf(self, "Open", "The menu is not registered.")
		return false
	EndIf
EndFunction


bool Function Close()
	If (IsRegistered)
		return UI.CloseMenu(Name)
	Else
		Debug.TraceSelf(self, "Close", "The menu is not registered.")
		return false
	EndIf
EndFunction

;---------------------------------------------

bool Function GetVisible()
	If (IsOpen)
		return UI.Get(Name, Asset+".Visible") as bool
	Else
		Debug.TraceSelf(self, "GetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetVisible(bool value)
	If (IsOpen)
		return UI.Set(Name, Asset+".Visible", value)
	Else
		Debug.TraceSelf(self, "SetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


; Functions
;---------------------------------------------

string Function GetMember(string member)
	If (member)
		return Instance+"."+member
	Else
		Debug.TraceSelf(self, "GetMember(member)", "The value cannot be none or empty.")
		return none
	EndIf
EndFunction


string Function ToString()
	{The string representation of this type.}
	return parent.ToString()+"[Name:"+Name+", File:"+File+", Root:"+Root+", Asset:"+Asset+"]"
EndFunction


; Properties
;---------------------------------------------

Group Display
	string Property Name Hidden
		{The name of the menu to load within.}
		string Function Get()
			return "Console"
		EndFunction
	EndProperty

	string Property Root Hidden
		{The root display object.}
		string Function Get()
			return "root1"
		EndFunction
	EndProperty

	string Property Instance Hidden
		{The menu's base instance variable.}
		string Function Get()
			return Root+".AnimHolder_mc.Menu_mc"
		EndFunction
	EndProperty

	bool Property IsRegistered Hidden
		bool Function Get()
			{Returns true if this menu is registered.}
			return UI.IsMenuRegistered(Name)
		EndFunction
	EndProperty

	bool Property IsOpen Hidden
		bool Function Get()
			{Returns true if this menu is open.}
			return UI.IsMenuOpen(Name)
		EndFunction
	EndProperty
EndGroup

Group Asset
	string Property File Hidden
		{The asset file to load within the given menu. The root directory is "Data\Interface".}
		string Function Get()
			return "TestingMenu.swf"
		EndFunction
	EndProperty

	string Property Asset Hidden
		{The menu asset's instance variable.}
		string Function Get()
			return AssetValue
		EndFunction
	EndProperty

	bool Property IsLoaded Hidden
		{Returns true if this asset has been loaded.}
		bool Function Get()
			return Loaded
		EndFunction
	EndProperty
EndGroup
