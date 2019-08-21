ScriptName System:UI:MenuDynamic Extends System:UI:Menu Native Const Hidden
; TODO: Check is loader exists on target menu before loading.
import System:Debug
import System:Exception
import System:UI:DynamicLoadEvent


; IMenuDynamic
;---------------------------------------------

; The `IMenuDynamic` language interface must be implemented.
IMenuDynamic Function IMenuDynamic()
	Abstract(self, "IMenuDynamic", "The language interface must be implemented on a child class.")
EndFunction

Struct IMenuDynamic
	string File = ""
	{The asset file to use.}

	string Instance = ""
	{The menu loader's instance variable.}

	System:UI:DynamicLoadEvent DynamicLoad
	{A custom event delegate for the DynamicLoad event.}

	bool HasLoaded = false
	{Returns true if this asset has been loaded. Indicates if the `IMenuDynamic` has been loaded into the `IMenu`.}
EndStruct


; Properties
;---------------------------------------------

Group Properties
	string Property File Hidden
		{The asset file to use.}
		string Function Get()
			return IMenuDynamic().File
		EndFunction
	EndProperty

	string Property Instance Hidden
		{The instance path of the dynamic display object.}
		string Function Get()
			return IMenuDynamic().Instance
		EndFunction
	EndProperty

	bool Property HasLoaded Hidden
		{Returns true if this asset has been loaded.}
		bool Function Get()
			return IMenuDynamic().HasLoaded
		EndFunction
	EndProperty
EndGroup


; Events
;---------------------------------------------

; @F4SE
Event OnDynamicLoad(bool success, string menuName, string menuRoot, string assetInstance, string assetFile)
	{The UI loaded callback.}

	DynamicLoadEventArgs e = new DynamicLoadEventArgs
	e.Success = success
	e.MenuName = menuName
	e.MenuRoot = menuRoot
	e.Instance = assetInstance
	e.File = assetFile

	If (success == false) ; TODO: temp error for development
		Information error = new Information
		error.Name = "Menu Dynamic Load Failure"
		error.Description = "The `"+e.File+"` asset could not be loaded into the `"+e.MenuName+"` menu."
		error.Help = "Ensure that both files exist."
		error.Source = self
		error.Site = "OnDynamicLoad<string::success>"
		error.Log = "System"
		Throw(error)
	Else
		WriteLine(self, "OnDynamicLoad", e, log="System")
	EndIf

	IMenuDynamic().HasLoaded = e.Success
	IMenuDynamic().Instance = e.Instance
	IMenuDynamic().DynamicLoad.Send(self, e)
EndEvent


; Methods
;---------------------------------------------

bool Function Load()
	return UI.Load(Name, Root, File+".swf", self, "OnDynamicLoad")
EndFunction


; @overrides
string Function ToString()
	{The string representation of this type.}
	return parent.ToString()+IMenuDynamic()
EndFunction
