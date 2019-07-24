ScriptName System:UI:Examine:Client Extends System:UI:Examine:ClientType
{Injects AS3 code into the vanilla Examine menu.}
import System:Debug
import System:Log
import System:UI:Menu
import System:UI:MenuClient


; Interfaces
;---------------------------------------------

; @overrides
IMenu Function IMenu()
	IMenu this = new IMenu
	this.Name = "ExamineMenu"
	this.Variable = ".BaseInstance"
	return this
EndFunction


; @overrides
IClient Function IClient()
	IClient this = new IClient
	this.File = "System_ExamineMenu"
	return this
EndFunction

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
	WriteLine("System", self, "OnQuestInit")
EndEvent


Event OnGameReload()
	RegisterForMenuOpenCloseEvent(Name)
	WriteLine("System", self, "OnGameReload")
EndEvent


Event OnQuestShutdown()
	UnregisterForAllEvents()
	WriteLine("System", self, "OnQuestShutdown")
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	WriteLine("System", self, "OnMenuOpenCloseEvent(menuName:"+menuName+", opening:"+opening+")")
	If (opening)
		UI.Load(Name, Root, File, self, "OnLoadComplete")
		RegisterForExternalEvent(ModChangedEvent, "OnModChanged")
		RegisterForExternalEvent(EditorOpenedEvent, "OnEditorOpened")
	Else
		UnregisterForExternalEvent(ModChangedEvent)
		UnregisterForExternalEvent(EditorOpenedEvent)
		IClient().Loaded = false
	EndIf

	OpenCloseEventArgs e = new OpenCloseEventArgs
	e.Opening = opening
	self.SendOpenCloseEvent(e)
EndEvent


; @XSE
Event OnLoadComplete(bool success, string menuName, string menuRoot, string assetInstance, string assetFile)
	{The UI loaded callback.}
	WriteLine("System", self, "OnLoadComplete", "(success:"+success+", menuName:"+menuName+", menuRoot:"+menuRoot+", assetInstance:"+assetInstance+", assetFile:"+assetFile+")")
	If (!success)
		WriteUnexpectedValue("System", self, "OnLoadComplete", "success", "The `"+assetFile+"` asset could not be loaded into `"+menuName+"`.")
	EndIf
	IClient().Variable = assetInstance
	IClient().Loaded = success
EndEvent


; @Scaleform
Event OnModChanged(int selected)
	WriteLine("System", self, "OnModChanged", "argument:"+selected)
	If (selected > Invalid)
		; Emblems:Preset preset = Editor.GetPreset(selected)
		; Update(Editor, preset)
	EndIf
EndEvent


; @Scaleform
Event OnEditorOpened()
	WriteLine("System", self, "OnEditorOpened")
EndEvent


; Methods
;---------------------------------------------

bool Function GetVisible()
	If (IsOpen)
		return UI.Get(Name, Variable+".Visible") as bool
	Else
		WriteUnexpected("System", self, "GetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetVisible(bool value)
	If (IsOpen)
		return UI.Set(Name, Variable+".Visible", value)
	Else
		WriteUnexpected("System", self, "SetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetPrimary(string filepath, int color)
	If (IsOpen)
		If (IsLoaded)
			If (filepath)
				var[] arguments = new var[2]
				arguments[0] = filepath
				arguments[1] = color
				UI.Invoke(Name, IClient().Variable+".Viewer.SetPrimary", arguments)
				WriteLine("System", self, "SetPrimary", arguments)
				return true
			Else
				WriteUnexpectedValue("System", self, "SetPrimary", "filepath", "The filepath cannot be none or empty.")
				return false
			EndIf
		Else
			WriteUnexpectedValue("System", self, "SetPrimary", "IsLoaded", "The menu asset must be loaded.")
			return false
		EndIf
	Else
		WriteUnexpectedValue("System", self, "SetPrimary", "IsOpen", "The menu must be open.")
		return false
	EndIf
EndFunction


bool Function SetSecondary(string filepath, int color)
	If (IsOpen)
		If (filepath)
			var[] arguments = new var[2]
			arguments[0] = filepath
			arguments[1] = color
			UI.Invoke(Name, IClient().Variable+".Viewer.SetSecondary", arguments)
			WriteLine("System", self, "SetSecondary", arguments)
			return true
		Else
			WriteUnexpectedValue("System", self, "SetSecondary", "filepath", "The filepath cannot be none or empty.")
			return false
		EndIf
	Else
		WriteUnexpected("System", self, "SetSecondary", ToString()+" is not open.")
		return false
	EndIf
EndFunction


bool Function SetBackground(string filepath, int color)
	If (IsOpen)
		If (filepath)
			var[] arguments = new var[2]
			arguments[0] = filepath
			arguments[1] = color
			UI.Invoke(Name, IClient().Variable+".Viewer.SetBackground", arguments)
			WriteLine("System", self, "SetBackground", arguments)
			return true
		Else
			WriteUnexpectedValue("System", self, "SetBackground", "filepath", "The filepath cannot be none or empty.")
			return false
		EndIf
	Else
		WriteUnexpected("System", self, "SetBackground", ToString()+" is not open.")
		return false
	EndIf
EndFunction
