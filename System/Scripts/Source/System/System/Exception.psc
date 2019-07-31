ScriptName System:Exception Extends System:Object Const Native Hidden DebugOnly
{Serves as the base class for system exceptions namespace.

**Remarks**
This class is provided as a means to differentiate between system exceptions and application exceptions.

**See Also**
* https://docs.microsoft.com/en-us/dotnet/api/system.systemexception
* https://docs.microsoft.com/en-us/dotnet/api/system.reflection.methodbase
}
import System:Diagnostics:Log
import System:Text


; Represents errors that occur during application execution.
; **See Also**
; * https://docs.microsoft.com/en-us/dotnet/api/system.exception
; * https://docs.microsoft.com/en-us/dotnet/api/system.exception.innerexception
Struct Information
	string Name = ""
	{The name of this exception.}
	string Description = ""
	{A message that describes the current exception.}
	string Help = ""
	{A solution associated with this exception.}
	string Source = ""
	{The name of the object that causes the error.}
	string Site = ""
	{The method that throws the current exception.}
	string Data = ""
	{Provides additional user-defined information about the exception.}
	int Severity = 2
	{Severity is one of the following:
	0 - Info
	1 - Warning
	2 - Error}
	bool StackTrace = true
	{Indicates that the immediate frames on the call stack will be traced to `Papyrus.0.log`.}
	string Log = ""
	{The log file this exception will be written to. An empty string specifies `Papyrus.0.log`.}
EndStruct


Line Function ToLine(Information this) Global DebugOnly
	; Formatted structure string.
	return Line(System:Debug.Script(this.Source, this.Site, this.Description), this.Log)
EndFunction


; Methods
;---------------------------------------------

bool Function Throw(Information this) Global DebugOnly
	Line throw = ToLine(this)
	If (this.StackTrace)
		Debug.TraceStack(throw.Text, throw.Severity)
	EndIf
	If (Writer(throw))
		var[] lines = new var[0]
		lines.Add("Exception: "+this.Name)
		lines.Add(this.Description)
		lines.Add(this.Help)
		lines.Add(this.Source)
		lines.Add(this.Site)
		Debug.MessageBox(JoinsAny("\n", lines))
		return true
	Else
		return false
	EndIf
EndFunction


; Exceptions
;---------------------------------------------

; Members marked as abstract must be implemented by extending classes.
;
; **Remarks**
; The abstract modifier indicates that the member being modified has a missing or incomplete implementation.
; The abstract modifier can be used within functions, events, and full properties.
;
; **See Also**
; * https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/abstract
bool Function Abstract(ScriptObject script, string member, string description = "", string log = "") Global DebugOnly
	Information exception = new Information
	exception.Name = "Abstraction Required"
	exception.Description = "The member '"+member+"' must be implemented. "+description
	exception.Help = "Override the '"+member+"' member on an extending child script."
	exception.Source = script
	exception.Site = member
	exception.Log = log
	return Throw(exception)
EndFunction


; The exception that is thrown when a requested method or operation is not implemented.
;
; **Remarks**
; The exception is thrown when a particular method is present as a member of a type but is not implemented.
;
; You might choose to throw a *NotImplemented* exception in properties or methods in your own types
; when the that member is still in development and will only later be implemented in production code.
; In other words, a *NotImplemented* exception should be synonymous with "still in development."
;
; **See Also**
; * https://docs.microsoft.com/en-us/dotnet/api/system.notimplementedexception
bool Function ThrowNotImplemented(string script, string member, string description = "", string log = "") Global DebugOnly
	return Throw(NotImplemented(script, member, description, log))
EndFunction

Information Function NotImplemented(string script, string member, string description = "", string log = "") Global DebugOnly
	Information exception = new Information
	exception.Name = "Not Implemented"
	exception.Description = "The member '"+member+"' is not implemented yet. "+description
	exception.Help = "This exception should be synonymous with 'still in development'."
	exception.Source = script
	exception.Site = member
	exception.Log = log
	return exception
EndFunction


; The exception that is thrown when a method call is invalid for the object's current state.
;
; **Remarks**
; Throwing *InvalidOperation* is used in cases when the failure to invoke a method is caused by reasons other than invalid arguments.
; Typically, it is thrown when the state of an object cannot support the method call.
;
; **See Also**
; * https://docs.microsoft.com/en-us/dotnet/api/system.invalidoperationexception
bool Function ThrowInvalidOperation(string script, string member, string description = "", string log = "") Global DebugOnly
	return Throw(InvalidOperation(script, member, description, log))
EndFunction

Information Function InvalidOperation(string script, string member, string description = "", string log = "") Global DebugOnly
	Information exception = new Information
	exception.Name = "Invalid Operation"
	exception.Description = "The operation within member '"+member+"' is invalid. "+description
	exception.Help = ""
	exception.Source = script
	exception.Site = member
	exception.Log = log
	return exception
EndFunction


; The exception that is thrown when an invoked method is not supported.
; This may happen when a method does not support the invoked functionality.
;
; **Remarks**
; Throwing *NotSupported* indicates that no implementation exists for an invoked method.
;
; **See Also**
; * https://docs.microsoft.com/en-us/dotnet/api/system.notsupportedexception
bool Function ThrowNotSupported(string script, string member, string description = "", string log = "") Global DebugOnly
	return Throw(NotSupported(script, member, description, log))
EndFunction

Information Function NotSupported(string script, string member, string description = "", string log = "") Global DebugOnly
	Information exception = new Information
	exception.Name = "Not Supported"
	exception.Description = "The operation is not supported. "+description
	exception.Help = ""
	exception.Source = script
	exception.Site = member
	exception.Log = log
	return exception
EndFunction


; Arguments and Parameters
;---------------------------------------------

; The exception that is thrown when one of the arguments provided to a method is not valid.
;
; **Remarks**
;
; **See Also**
; https://docs.microsoft.com/en-us/dotnet/api/system.argumentexception
bool Function ThrowArgumentInvalid(string script, string member, string argument, string description = "", string log = "") Global DebugOnly
	return Throw(ArgumentInvalid(script, member, argument, description, log))
EndFunction

Information Function ArgumentInvalid(string script, string member, string argument, string description = "", string log = "") Global DebugOnly
	Information exception = new Information
	exception.Name = "Argument Invalid"
	exception.Description = "The argument within member '"+member+"' is invalid. "+description
	exception.Help = ""
	exception.Source = script
	exception.Site = member+"<"+argument+">"
	exception.Log = log
	return exception
EndFunction


; The exception that is thrown when a none reference is passed to a method that does not accept it as a valid argument.
;
; **See Also**
; https://docs.microsoft.com/en-us/dotnet/api/system.argumentnullexception
bool Function ThrowArgumentNoneEmpty(string script, string member, string argument, string description = "", string log = "") Global DebugOnly
	return Throw(ArgumentNoneEmpty(script, member, argument, description, log))
EndFunction

Information Function ArgumentNoneEmpty(string script, string member, string argument, string description = "", string log = "") Global DebugOnly
	Information exception = new Information
	exception.Name = "Argument None or Empty"
	exception.Description = "The '"+argument+"' argument on member '"+member+"' cannot be none or empty. "+description
	exception.Help = "Compare the argument with a boolean or none before passing parameters."
	exception.Source = script
	exception.Site = member+"<"+argument+">"
	exception.Log = log
	return exception
EndFunction


; The exception that is thrown when the value of an argument is outside the allowable range of values as defined by the invoked method.
;
; **See Also**
; https://docs.microsoft.com/en-us/dotnet/api/system.argumentoutofrangeexception
bool Function ThrowArgumentOutOfRange(string script, string member, string argument, string description = "", string log = "") Global DebugOnly
	return Throw(ArgumentOutOfRange(script, member, argument, description, log))
EndFunction

Information Function ArgumentOutOfRange(string script, string member, string argument, string description = "", string log = "") Global DebugOnly
	Information exception = new Information
	exception.Name = "Argument Out Of Range"
	exception.Description = "The '"+argument+"' argument on member '"+member+"' cannot be none or empty. "+description
	exception.Help = "Compare the argument with a valid range before passing parameters."
	exception.Source = script
	exception.Site = member+"<"+argument+">"
	exception.Log = log
	return exception
EndFunction


; IO
;---------------------------------------------

; The exception that is thrown when an attempt to access a file that does not exist on disk fails.
;
; **See Also**
; https://docs.microsoft.com/en-us/dotnet/api/system.io.filenotfoundexception
bool Function ThrowFileNotFound(string script, string member, string file, string description = "", string log = "") Global DebugOnly
	return Throw(FileNotFound(script, member, file, description, log))
EndFunction

Information Function FileNotFound(string script, string member, string file, string description = "", string log = "") Global DebugOnly
	Information exception = new Information
	exception.Name = "File Not Found"
	exception.Description = "The '"+file+"' file could not be found. "+description
	exception.Help = ""
	exception.Source = script
	exception.Site = member
	exception.Log = log
	return exception
EndFunction


; TODO: This may better added to `System:Type` as its not a generic system exception.
bool Function ThrowTypeNotFound(string script, string member, string file, int formID, string type, string description = "", string log = "") Global DebugOnly
	return Throw(TypeNotFound(script, member, file, formID, type, description, log))
EndFunction

Information Function TypeNotFound(string script, string member, string file, int formID, string type, string description = "", string log = "") Global DebugOnly
	Information exception = new Information
	exception.Name = "Type Not Found"
	exception.Description = "The data file dependency '"+file+"' cannot resolve '"+formID+"' as '"+type+"'. "+description
	exception.Help = ""
	exception.Source = script
	exception.Site = member
	exception.Log = log
	return exception
EndFunction
