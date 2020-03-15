ScriptName Action:Disk Extends Action:Type

; Events
;---------------------------------------------

Event OnQuestInit()
	OnGameReload()
	RegisterForGameReload(self)
EndEvent


Event OnGameReload()
	UI:MenuData data = new UI:MenuData
	data.MenuFlags = FlagDoNotPreventGameSave
	data.ExtendedFlags = FlagNone
	If (UI.RegisterCustomMenu(Name, Path, Root, data))
		Debug.TraceSelf(self, "OnGameReload", ToString()+" has registered as a custom menu.")
	Else
		Debug.TraceSelf(self, "OnGameReload", ToString()+" failed to register as a custom menu.")
	EndIf
EndEvent


; Functions
;---------------------------------------------

bool Function Open()
	If (IsOpen)
		Debug.TraceSelf(self, "Open", ToString()+" is already open.")
		return true
	Else
		If (IsRegistered)
			return UI.OpenMenu(Name)
		Else
			Debug.TraceSelf(self, "Open", ToString()+" is not registered.")
			return false
		EndIf
	EndIf
EndFunction


bool Function Close()
	If (!IsOpen)
		Debug.TraceSelf(self, "Close", ToString()+" is already closed.")
		return true
	Else
		If (IsRegistered)
			return UI.CloseMenu(Name)
		Else
			Debug.TraceSelf(self, "Close", ToString()+" is not registered.")
			return false
		EndIf
	EndIf
EndFunction



bool Function Exists(string value)
EndFunction

bool Function Load(string value)
	If (IsOpen)
		If (value)
			var[] arguments = new var[1]
			arguments[0] = value
			UI.Invoke(Name, GetMember("Load"), arguments)
			Debug.TraceSelf(self, "Load", "Load:"+value)
			return true
		Else
			Debug.TraceSelf(self, "Load", "The value cannot be none or empty.")
			return false
		EndIf
	Else
		Debug.TraceSelf(self, "Load", ToString()+" is not open.")
		return false
	EndIf
EndFunction



bool Function Write(string file, var[] arguments)
EndFunction

var[] Function Read(string file)
EndFunction




string Function GetMember(string member)
	{Returns the full AS3 instance path for the given member name.}
	If !(member)
		Debug.TraceSelf(self, "GetMember", "The member value cannot be none or empty.")
		return ""
	ElseIf !(Root)
		Debug.TraceSelf(self, "GetMember", "The root value cannot be none or empty.")
		return ""
	Else
		return Root+"."+member
	EndIf
EndFunction


string Function ToString()
	{The string representation of this type.}
	return "[Name:"+Name+", Path:"+Path+", Root:"+Root+"]"
EndFunction


; Properties
;---------------------------------------------

Group Properties
	string Property Name Hidden
		string Function Get()
			{The name of this menu.}
			return "ActionLibrary"
		EndFunction
	EndProperty

	string Property Path Hidden
		string Function Get()
			{The swf file path of this menu without the file extension. The root directory is "Data\Interface".}
			return "ActionLibrary"
		EndFunction
	EndProperty

	string Property Root Hidden
		string Function Get()
			{The root instance path of this menu's display object.}
			return "root1"
		EndFunction
	EndProperty

	bool Property IsOpen Hidden
		bool Function Get()
			{Returns true if this menu is open.}
			return UI.IsMenuOpen(Name)
		EndFunction
	EndProperty

	bool Property IsRegistered Hidden
		bool Function Get()
			{Returns true if this menu is registered.}
			return UI.IsMenuRegistered(Name)
		EndFunction
	EndProperty
EndGroup

Group MenuFlags
	int Property FlagNone = 0x0 AutoReadOnly
	int Property FlagDoNotPreventGameSave = 0x800 AutoReadOnly
EndGroup

Group ExtendedFlags
	; If you set extendedFlags & 2, it will disable your ShowCursor if the Gamepad is enabled
	int Property FlagInheritColors = 1 AutoReadOnly
	int Property FlagCheckForGamepad = 2 AutoReadOnly
EndGroup
