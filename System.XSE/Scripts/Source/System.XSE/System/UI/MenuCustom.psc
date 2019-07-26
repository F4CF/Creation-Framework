ScriptName System:UI:MenuCustom Extends System:UI:Menu Hidden Native Const
{A base script for custom menu types.}
import System:Debug
import System:Exception


; ICustom
;---------------------------------------------

; The `ICustom` language interface must be implemented.
ICustom Function ICustom()
	Abstract(self, "ICustom", "The language interface must be implemented on a child class.")
EndFunction

Struct ICustom
	string File = ""
	{The swf file path of this menu without the file extension.
	The root directory is relative to `Data\Interface`.}
	int MenuFlags = 0x801849D
	{The menu flags to use.}
	int MovieFlags = 3
	{The movie flags to use.}
	int ExtendedFlags = 3
	{The extended flags to use.}
	int Depth = 6
	{The menu depth to use.}
EndStruct


; Properties
;---------------------------------------------

Group Properties
	; TODO: The `File` is used by custom menus only.
	string Property File Hidden
		{The swf file path of this menu without the file extension.
		The root directory is relative to `Data\Interface`.}
		string Function Get()
			return ICustom().File
		EndFunction
	EndProperty
EndGroup

Group MenuFlags
	int Property FlagNone = 0x0 AutoReadOnly
	int Property FlagPauseGame = 0x01 AutoReadOnly
	int Property FlagShowCursor = 0x04 AutoReadOnly
	int Property FlagEnableMenuControl = 0x08 AutoReadOnly
	int Property FlagDoNotPreventGameSave = 0x800 AutoReadOnly
EndGroup

Group ExtendedFlags
	; If you set extendedFlags & 2, it will disable your ShowCursor if the Gamepad is enabled
	int Property FlagInheritColors = 1 AutoReadOnly
	int Property FlagCheckForGamepad = 2 AutoReadOnly
EndGroup


; Methods
;---------------------------------------------

bool Function Register()
	UI:MenuData flags = new UI:MenuData
	flags.MenuFlags = ICustom().MenuFlags
	flags.MovieFlags = ICustom().MovieFlags
	flags.ExtendedFlags = ICustom().ExtendedFlags
	flags.Depth = ICustom().Depth
	If (UI.RegisterCustomMenu(Name, File, Root, flags))
		WriteLine(self, "Register", ToString()+":Registered as a custom menu.")
		return true
	Else
		WriteUnexpected(self, "Register", ToString()+":Failed to register as a custom menu.")
		return false
	EndIf
EndFunction


bool Function GetVisible()
	If (IsOpen)
		return UI.Get(Name, GetMember("Visible")) as bool
	Else
		WriteUnexpected(self, "GetVisible", ToString()+":The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetVisible(bool value)
	If (IsOpen)
		WriteLine(self, ToString()+" setting visible to "+value)
		return UI.Set(Name, GetMember("Visible"), value)
	Else
		WriteUnexpected(self, "SetVisible", ToString()+":The menu is not open.")
		return false
	EndIf
EndFunction


; @overrides
string Function ToString()
	{The string representation of this type.}
	return parent.ToString()+ICustom()
EndFunction
