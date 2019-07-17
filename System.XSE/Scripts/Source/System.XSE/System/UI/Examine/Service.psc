ScriptName System:UI:Examine:Service Extends System:UI:Examine:ServiceType
{Injects AS3 code into the vanilla Examine menu.}
import System:Log
import System:UI:Examine:Menu
import System:Debug

bool Loaded = false
string AssetValue = "" ; the loader's instance variable

string ModChangedEvent = "System_ExamineMenu_OnModChanged" const
string EditorOpenedEvent = "System_ExamineMenu_OnEditorOpened" const

; Events
;---------------------------------------------

Event OnInit() ; TODO: This only happens once per object life time.
	RegisterForQuestInit(QUST)
	RegisterForQuestShutdown(QUST)
EndEvent


Event OnQuestInit()
	RegisterForGameReload(self)
	OnGameReload()
	WriteLine("System", ToString(), "OnQuestInit")
EndEvent


Event OnGameReload()
	RegisterForMenuOpenCloseEvent(Menu.Name)
	WriteLine("System", ToString(), "OnGameReload")
EndEvent


Event OnQuestShutdown()
	UnregisterForAllEvents()
	WriteLine("System", ToString(), "OnQuestShutdown")
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	WriteLine("System", ToString(), "OnMenuOpenCloseEvent(menuName:"+menuName+", opening:"+opening+")")
	If (opening)
		UI.Load(Menu.Name, Menu.Root, File, self, "OnLoadComplete")
		RegisterForExternalEvent(ModChangedEvent, "OnModChanged")
		RegisterForExternalEvent(EditorOpenedEvent, "OnEditorOpened")
	Else
		UnregisterForExternalEvent(ModChangedEvent)
		UnregisterForExternalEvent(EditorOpenedEvent)
		Loaded = false
	EndIf

	OpenCloseEventArgs e = new OpenCloseEventArgs
	e.Opening = opening
	self.SendOpenCloseEvent(e)
EndEvent


; @XSE
Event OnLoadComplete(bool success, string menuName, string menuRoot, string assetInstance, string assetFile)
	{The UI loaded callback.}
	WriteLine("System", ToString(), "OnLoadComplete", "(success:"+success+", menuName:"+menuName+", menuRoot:"+menuRoot+", assetInstance:"+assetInstance+", assetFile:"+assetFile+")")
	If (!success)
		WriteUnexpectedValue("System", ToString(), "OnLoadComplete", "success", "The `"+assetFile+"` asset could not be loaded into `"+menuName+"`.")
	EndIf
	AssetValue = assetInstance
	Loaded = success
EndEvent


; @Scaleform
Event OnModChanged(int selected)
	WriteLine("System", ToString(), "OnModChanged", "argument:"+selected)
	If (selected > Invalid)
		; Emblems:Preset preset = Editor.GetPreset(selected)
		; Update(Editor, preset)
	EndIf
EndEvent


; @Scaleform
Event OnEditorOpened()
	WriteLine("System", ToString(), "OnEditorOpened")
EndEvent


; Methods
;---------------------------------------------

Function SendOpenCloseEvent(OpenCloseEventArgs e)
	If (e)
		var[] arguments = new var[1]
		arguments[0] = e
		Menu.SendCustomEvent("OpenCloseEvent", arguments)
	Else
		WriteUnexpectedValue("System", self, "SendOpenCloseEvent", "e", "The argument cannot be none.")
	EndIf
EndFunction


bool Function GetVisible()
	If (Menu.IsOpen)
		return UI.Get(Menu.Name, Asset+".Visible") as bool
	Else
		WriteUnexpected("System", ToString(), "GetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetVisible(bool value)
	If (Menu.IsOpen)
		return UI.Set(Menu.Name, Asset+".Visible", value)
	Else
		WriteUnexpected("System", ToString(), "SetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetPrimary(string filepath, int color)
	If (Menu.IsOpen)
		If (IsLoaded)
			If (filepath)
				var[] arguments = new var[2]
				arguments[0] = filepath
				arguments[1] = color
				UI.Invoke(Menu.Name, Asset+".Viewer.SetPrimary", arguments)
				WriteLine("System", ToString(), "SetPrimary", arguments)
				return true
			Else
				WriteUnexpectedValue("System", ToString(), "SetPrimary", "filepath", "The filepath cannot be none or empty.")
				return false
			EndIf
		Else
			WriteUnexpectedValue("System", ToString(), "SetPrimary", "IsLoaded", "The menu asset must be loaded.")
			return false
		EndIf
	Else
		WriteUnexpectedValue("System", ToString(), "SetPrimary", "IsOpen", "The menu must be open.")
		return false
	EndIf
EndFunction


bool Function SetSecondary(string filepath, int color)
	If (Menu.IsOpen)
		If (filepath)
			var[] arguments = new var[2]
			arguments[0] = filepath
			arguments[1] = color
			UI.Invoke(Menu.Name, Asset+".Viewer.SetSecondary", arguments)
			WriteLine("System", ToString(), "SetSecondary", arguments)
			return true
		Else
			WriteUnexpectedValue("System", ToString(), "SetSecondary", "filepath", "The filepath cannot be none or empty.")
			return false
		EndIf
	Else
		WriteUnexpected("System", ToString(), "SetSecondary", ToString()+" is not open.")
		return false
	EndIf
EndFunction


bool Function SetBackground(string filepath, int color)
	If (Menu.IsOpen)
		If (filepath)
			var[] arguments = new var[2]
			arguments[0] = filepath
			arguments[1] = color
			UI.Invoke(Menu.Name, Asset+".Viewer.SetBackground", arguments)
			WriteLine("System", ToString(), "SetBackground", arguments)
			return true
		Else
			WriteUnexpectedValue("System", ToString(), "SetBackground", "filepath", "The filepath cannot be none or empty.")
			return false
		EndIf
	Else
		WriteUnexpected("System", ToString(), "SetBackground", ToString()+" is not open.")
		return false
	EndIf
EndFunction


string Function ToString()
	{The string representation of this type.}
	return Menu.ToString()+"[File:"+File+", Asset:"+Asset+"]"
EndFunction


; Properties
;---------------------------------------------

Group Properties
	string Property File Hidden
		{The asset file to load within the given menu. The root directory is "Data\Interface".}
		string Function Get()
			return "System_ExamineMenu.swf"
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

Group Menu
	System:UI:Examine:Menu Property Menu Auto Const Mandatory
EndGroup
