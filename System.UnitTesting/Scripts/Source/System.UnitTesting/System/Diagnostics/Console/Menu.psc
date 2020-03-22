ScriptName System:Diagnostics:Console:Menu Extends System:Diagnostics:Console:MenuType
{Injects AS3 code into the vanilla Console menu.}
; See Also: `System:UI:Menu` & `System:UI:Console:MenuType`

Actor Player

bool Loaded = false
string AssetValue = "" ; the loader's instance variable

string ReadyEvent = "System_Diagnostics_TestingReadyEvent" const
string UnloadEvent = "System_Diagnostics_TestingUnloadEvent" const

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
	RegisterForExternalEvent(ReadyEvent, "OnAssetReady")
	RegisterForExternalEvent(UnloadEvent, "OnAssetUnloaded")
	Debug.TraceSelf(self, "OnGameReload", ToString())
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	Debug.TraceSelf(self, "OnMenuOpenCloseEvent(menuName:"+menuName+", opening:"+opening+")", ToString())
	; The load logic here is occuring every time the menu opens causing duplicates.
	; Maybe register for external events elsewhere?
	If (opening)
		Load()
	Else
		; UnregisterForExternalEvent(ReadyEvent)
		; Loaded = false
	EndIf
EndEvent


; @F4SE
Event OnAssetLoaded(bool success, string menuName, string menuRoot, string assetInstance, string assetFile)
	{The UI loaded callback.}
	Debug.TraceSelf(self, "OnAssetLoaded(success:"+success+", menuName:"+menuName+", menuRoot:"+menuRoot+", assetInstance:"+assetInstance+", assetFile:"+assetFile+")", ToString())
	If (!success)
		Debug.TraceSelf(self, "OnAssetLoaded", ToString()+" The `"+assetFile+"` asset could not be loaded into `"+menuName+"`.")
	EndIf
	AssetValue = assetInstance
	Loaded = success

	ApplyData()
EndEvent


; @Scaleform
Event OnAssetReady()
	; this happens BEFORE `OnAssetLoaded`
	Debug.TraceSelf(self, "OnAssetReady", ToString())
EndEvent


; @Scaleform
Event OnAssetUnloaded()
	Debug.TraceSelf(self, "OnAssetUnloaded", ToString())
	AssetValue = ""
	Loaded = false
EndEvent


; Methods
;---------------------------------------------

bool Function Load()
	If (!IsLoaded)
		return UI.Load(Name, Root, File, self, "OnAssetLoaded")
	Else
		Debug.TraceSelf(self, "OnMenuOpenCloseEvent", ToString()+": Is already loaded.")
		return false
	EndIf
EndFunction


Function Unload()
	string member = Asset+"."+"Unload"
	UI.Invoke(Name, member)
	Debug.TraceSelf(self, "Unload", Name+"::"+member)
EndFunction


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

Function ApplyData()
	UnitTestData[] data = GetData()
	var[] arguments = new var[0]
	int index = 0
	While (index < data.Length)
		arguments.Add(data[index])
		Debug.TraceSelf(self, "Allocating: ", data[index])
		index += 1
	EndWhile
	SetData(arguments)
EndFunction


UnitTestData[] Function GetData()
	UnitTestData[] data = new UnitTestData[0]

	UnitTestData unitTest1 = new UnitTestData
	unitTest1.Name = "Hello World! Test 1"
	unitTest1.Description = "The dummy unit test #1."
	data.Add(unitTest1)

	UnitTestData unitTest2 = new UnitTestData
	unitTest2.Name = "Hello World! Test 2"
	unitTest2.Description = "The dummy unit test #2."
	data.Add(unitTest2)

	UnitTestData unitTest3 = new UnitTestData
	unitTest3.Name = "Hello World! Test 3"
	unitTest3.Description = "The dummy unit test #3."
	data.Add(unitTest3)

	UnitTestData unitTest4 = new UnitTestData
	unitTest4.Name = "Test 4"
	unitTest4.Description = "The dummy unit test #4."
	data.Add(unitTest4)

	UnitTestData unitTest5 = new UnitTestData
	unitTest5.Name = "Test 5"
	unitTest5.Description = "The dummy unit test #5."
	data.Add(unitTest5)

	UnitTestData unitTest6 = new UnitTestData
	unitTest6.Name = "Test 6"
	unitTest6.Description = "The dummy unit test #6."
	data.Add(unitTest6)

	UnitTestData unitTest7 = new UnitTestData
	unitTest7.Name = "Test 7"
	unitTest7.Description = "The dummy unit test #7."
	data.Add(unitTest7)

	UnitTestData unitTest8 = new UnitTestData
	unitTest8.Name = "Test 8"
	unitTest8.Description = "The dummy unit test #8."
	data.Add(unitTest8)

	UnitTestData unitTest9 = new UnitTestData
	unitTest9.Name = "Test 9"
	unitTest9.Description = "The dummy unit test #9."
	data.Add(unitTest9)

	UnitTestData unitTest10 = new UnitTestData
	unitTest10.Name = "Test 10"
	unitTest10.Description = "The dummy unit test #10."
	data.Add(unitTest10)

	UnitTestData unitTest11 = new UnitTestData
	unitTest11.Name = "Test 11"
	unitTest11.Description = "The dummy unit test #11."
	data.Add(unitTest11)

	UnitTestData unitTest12 = new UnitTestData
	unitTest12.Name = "Test 12"
	unitTest12.Description = "The dummy unit test #12."
	data.Add(unitTest12)

	UnitTestData unitTest13 = new UnitTestData
	unitTest13.Name = "Test 13"
	unitTest13.Description = "The dummy unit test #13."
	data.Add(unitTest13)

	UnitTestData unitTest14 = new UnitTestData
	unitTest14.Name = "Test 14"
	unitTest14.Description = "The dummy unit test #14."
	data.Add(unitTest14)

	UnitTestData unitTest15 = new UnitTestData
	unitTest15.Name = "Test 15"
	unitTest15.Description = "The dummy unit test #15."
	data.Add(unitTest15)

	UnitTestData unitTest16 = new UnitTestData
	unitTest16.Name = "Test 16"
	unitTest16.Description = "The dummy unit test #16."
	data.Add(unitTest16)

	return data
EndFunction


Function SetData(var[] data)
	string setDataMember = Asset+".Panel.SetData"
	UI.Invoke(Name, setDataMember, data)
	Debug.TraceSelf(self, "SetData", Name+"::"+setDataMember)
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
	return parent.ToString()+"[Name:"+Name+", File:"+File+", Root:"+Root+", Asset:"+Asset+", IsLoaded:"+IsLoaded+"]"
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
