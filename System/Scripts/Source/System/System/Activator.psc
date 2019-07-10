Scriptname System:Activator extends System:Object Const
{An activator is an object that can be used (or activated) by an `Actor` or another activator.
Contains methods to create types of objects locally or remotely, or obtain references to existing remote objects.

**See Also**
* https://docs.microsoft.com/en-us/dotnet/api/system.activator
* https://www.creationkit.com/index.php?title=Activator
* https://www.creationkit.com/fallout4/index.php?title=Activator

**TODO**
* Do not allow creation of certain types like `Quest` via "instantiation".
}
import System

;/ USAGE
MyType Function Type() Global
	return This().Type(0x0000083E) as MyType
EndFunction
/;


; Instance
;---------------------------------------------

Activator Property ACTI Hidden
	Activator Function Get()
		return ACTI()
	EndFunction
EndProperty

; @virtual
Activator Function ACTI()
	Activator this = System:Type.AsActivator(self)
	System:Debug.Assert(this, "Exception: Invalid Object! This must be of the `Activator` type.")
	return this
EndFunction


; Instantiation
;---------------------------------------------

System:Activator Function This() Global
	Properties:Assembly assembly = System:Properties:Assembly.Type()
	return System:Type.Read(assembly.File, assembly.System) as System:Activator
EndFunction


Activator Function GetType(int formID) Global
	Properties:Assembly assembly = System:Properties:Assembly.Type()
	return System:Type.Read(assembly.File, formID) as Activator
EndFunction


var Function Type(int aFormID)
	Activator Type = System:Activator.GetType(aFormID)
	return Initialize(Type)
EndFunction


ObjectReference Function Initialize(Activator aActivator)
	return Factory.PlaceAtMe(aActivator)
EndFunction


; Properties
;---------------------------------------------

Group Objects
	ObjectReference Property Factory Auto Const Mandatory
	{A "COC Marker Heading" placed within the `SystemCell`.}
EndGroup
