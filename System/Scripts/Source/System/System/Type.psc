ScriptName System:Type Extends System:Object Native Const Hidden
{Represents type declarations.

**See Also**
* https://docs.microsoft.com/en-us/dotnet/api/system.type
* https://docs.microsoft.com/en-us/dotnet/api/system.reflection.memberinfo
* https://docs.microsoft.com/en-us/dotnet/api/system.reflection.propertyinfo
* https://docs.microsoft.com/en-us/dotnet/api/system.reflection.typeinfo
}


; Properties
;---------------------------------------------

Group Assembly
	string Property FileName Hidden
		{The data file plugin name.}
		string Function Get()
			return GetFileName()
		EndFunction
	EndProperty
	string Property FileExtension Hidden
		{The data file plugin name.}
		string Function Get()
			return GetFileExtension()
		EndFunction
	EndProperty
	string Property File Hidden
		{The data file plugin.}
		string Function Get()
			return GetFile()
		EndFunction
	EndProperty
EndGroup

; @virtual
; The data file plugin name.
string Function GetFileName()
	{Property}
	return "Fallout4"
EndFunction

; @virtual
; The data file plugin extension.
string Function GetFileExtension()
	{Property}
	return "esm"
EndFunction

; @virtual
; The data file plugin.
string Function GetFile()
	{Property}
	return FileName+"."+FileExtension
EndFunction


; Methods
;---------------------------------------------

bool Function Exists(string filename) Global
	return Game.IsPluginInstalled(filename)
EndFunction


Form Function Read(string filename, int formID) Global
	return Game.GetFormFromFile(formID, filename)
EndFunction

;---------------------------------------------

ScriptObject Function Cast(System:Type this, ScriptObject object, string script) Global
	return this.CastAs(script)
EndFunction


var Function GetProperty(System:Type this, ScriptObject object, string member) Global
	return this.GetPropertyValue(member)
EndFunction


bool Function SetProperty(System:Type this, ScriptObject object, string member, var value) Global
	this.SetPropertyValue(member, value)
	return true
EndFunction


bool Function SetPropertyNoWait(System:Type this, ScriptObject object, string member, var value) Global
	this.SetPropertyValueNoWait(member, value)
	return true
EndFunction


var Function Call(System:Type this, ScriptObject object, string member, var[] parameters) Global
	return this.CallFunction(member, parameters)
EndFunction


bool Function CallNoWait(System:Type this, ScriptObject object, string member, var[] parameters) Global
	this.CallFunctionNoWait(member, parameters)
	return true
EndFunction


var Function CallGlobal(string script, string member, var[] parameters) Global
	return Utility.CallGlobalFunction(script, member, parameters)
EndFunction


bool Function CallGlobalNoWait(string script, string member, var[] parameters) Global
	Utility.CallGlobalFunctionNoWait(script, member, parameters)
	return true
EndFunction


;---------------------------------------------

Struct FormType
	string File
	int FormID
	Form Object
EndStruct

; Struct ArmorType
; 	string File
; 	int FormID
; 	Armor Object
; EndStruct

; Struct WeaponType
; 	string File
; 	int FormID
; 	Armor Object
; EndStruct


FormType Function NewForm(string file, int formID) Global
	FormType value = new FormType
	value.File = file
	value.FormID = formID
	return value
EndFunction

bool Function ReadForm(FormType value) Global
	If (Exists(value.File))
		value.Object = Read(value.File, value.FormID)
		return value.Object
	Else
		return false
	EndIf
EndFunction


; Objects
;---------------------------------------------

; Casts a variable into it's concrete object type.
ObjectReference Function AsReference(var this) Global
	return this as ObjectReference
EndFunction

; Casts a variable into it's concrete object type.
Actor Function AsActor(var this) Global
	return this as Actor
EndFunction

; Casts a variable into it's concrete object type.
ActiveMagicEffect Function AsActiveMagicEffect(var this) Global
	return this as ActiveMagicEffect
EndFunction

; Casts a variable into it's concrete object type.
Quest Function AsQuest(var this) Global
	return this as Quest
EndFunction

; Casts a variable into it's concrete object type.
ObjectMod Function AsObjectMod(var this) Global
	return this as ObjectMod
EndFunction

; Casts a variable into it's concrete object type.
GlobalVariable Function AsGlobalVariable(var this) Global
	return this as GlobalVariable
EndFunction

; Casts a variable into it's concrete object type.
Activator Function AsActivator(var this) Global
	return this as Activator
EndFunction

; Casts a variable into it's concrete object type.
Armor Function AsArmor(var this) Global
	return this as Armor
EndFunction
