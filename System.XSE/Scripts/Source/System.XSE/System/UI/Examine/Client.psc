ScriptName System:UI:Examine:Client Extends System:UI:Examine:ClientType
{Injects AS3 code into the vanilla Examine menu.}
import System:Debug
import System:UI:Menu
import System:UI:MenuClient
import System:UI:OpenCloseEvent

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
	WriteLine(self, "OnQuestInit")
EndEvent


Event OnGameReload()
	RegisterForMenuOpenCloseEvent(Name)
	WriteLine(self, "OnGameReload")
EndEvent


Event OnQuestShutdown()
	UnregisterForAllEvents()
	WriteLine(self, "OnQuestShutdown")
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	WriteLine(self, "OnMenuOpenCloseEvent(menuName:"+menuName+", opening:"+opening+")")
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
	IMenu().OpenClose.Send(self, e)
EndEvent


; @XSE
Event OnLoadComplete(bool success, string menuName, string menuRoot, string assetInstance, string assetFile)
	{The UI loaded callback.}
	WriteLine(self, "OnLoadComplete", "(success:"+success+", menuName:"+menuName+", menuRoot:"+menuRoot+", assetInstance:"+assetInstance+", assetFile:"+assetFile+")")
	If (!success)
		WriteUnexpectedValue(self, "OnLoadComplete", "success", "The `"+assetFile+"` asset could not be loaded into `"+menuName+"`.")
	EndIf
	IClient().Variable = assetInstance
	IClient().Loaded = success
EndEvent


; @Scaleform
Event OnModChanged(int selected)
	WriteLine(self, "OnModChanged", "argument:"+selected)
	If (selected > Invalid)
		; Emblems:Preset preset = Editor.GetPreset(selected)
		; Update(Editor, preset)
	EndIf
EndEvent


; @Scaleform
Event OnEditorOpened()
	WriteLine(self, "OnEditorOpened")
EndEvent


; Methods
;---------------------------------------------

bool Function GetVisible()
	If (IsOpen)
		return UI.Get(Name, Variable+".Visible") as bool
	Else
		WriteUnexpected(self, "GetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetVisible(bool value)
	If (IsOpen)
		return UI.Set(Name, Variable+".Visible", value)
	Else
		WriteUnexpected(self, "SetVisible", "The menu is not open.")
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
				WriteLine(self, "SetPrimary", arguments)
				return true
			Else
				WriteUnexpectedValue(self, "SetPrimary", "filepath", "The filepath cannot be none or empty.")
				return false
			EndIf
		Else
			WriteUnexpectedValue(self, "SetPrimary", "IsLoaded", "The menu asset must be loaded.")
			return false
		EndIf
	Else
		WriteUnexpectedValue(self, "SetPrimary", "IsOpen", "The menu must be open.")
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
			WriteLine(self, "SetSecondary", arguments)
			return true
		Else
			WriteUnexpectedValue(self, "SetSecondary", "filepath", "The filepath cannot be none or empty.")
			return false
		EndIf
	Else
		WriteUnexpected(self, "SetSecondary", ToString()+" is not open.")
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
			WriteLine(self, "SetBackground", arguments)
			return true
		Else
			WriteUnexpectedValue(self, "SetBackground", "filepath", "The filepath cannot be none or empty.")
			return false
		EndIf
	Else
		WriteUnexpected(self, "SetBackground", ToString()+" is not open.")
		return false
	EndIf
EndFunction
