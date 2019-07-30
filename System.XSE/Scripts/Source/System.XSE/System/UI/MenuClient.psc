ScriptName System:UI:MenuClient Extends System:UI:Menu Native Const Hidden
; TODO: Check is loader exists on target menu before loading.
import System:Debug
import System:Exception


; IClient
;---------------------------------------------

; The `IClient` language interface must be implemented.
IClient Function IClient()
	Abstract(self, "IClient", "The language interface must be implemented on a child class.")
EndFunction

Struct IClient
	string File = ""
	{The asset file to use.}
	string Variable = ""
	{The menu loader's instance variable.}
	bool Loaded = false
	{Returns true if this asset has been loaded. Indicates if the `IClient` has been loaded into the `IMenu`.}
EndStruct


; Properties
;---------------------------------------------

Group Properties
	string Property File Hidden
		{The asset file to use.}
		string Function Get()
			return IClient().File
		EndFunction
	EndProperty

	string Property Client Hidden
		{The instance path of the client's display object.}
		string Function Get()
			return IClient().Variable
		EndFunction
	EndProperty

	bool Property IsLoaded Hidden
		{Returns true if this asset has been loaded.}
		bool Function Get()
			return IClient().Loaded
		EndFunction
	EndProperty

	string Property ClientLoadedCallback Hidden
		{The client loaded external event ID.}
		string Function Get()
			return "SystemUI_ClientLoadedCallback"
		EndFunction
	EndProperty
EndGroup


; Events
;---------------------------------------------

; @F4SE
Event OnLoadComplete(bool success, string menuName, string menuRoot, string assetInstance, string assetFile)
	WriteUnexpected(self, "OnLoadComplete", "The event was unhandled.", log="System")
EndEvent


Event OnClientLoaded(bool success, string instance)
	{The client loaded event.}
	WriteUnexpected(self, "OnClientLoaded", "The event was unhandled.", log="System")
EndEvent


; Methods
;---------------------------------------------

bool Function Load(string menuName)
	return UI.Load(Name, Root, File+".swf", self, "OnLoadComplete")
EndFunction


; @overrides
string Function ToString()
	{The string representation of this type.}
	return parent.ToString()+IClient()
EndFunction
