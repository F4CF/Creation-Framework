# [Documentation](../Documentation.md) #
Scripting Papyrus

# Class
The native module provides a common implementation for context events.

## Inheritance
* [ScriptObject](http://www.creationkit.com/fallout4/index.php?title=ScriptObject_Script)
* [Form](http://www.creationkit.com/fallout4/index.php?title=Form_Script)
* `Project:Modules:Module`

## Editor
Does not attach to any editor objects.

# Members
These are the members of this class.

## Globals
>`bool ModuleInitialize(Project:Context aContext, ScriptObject aModule) Global`
>> Initializes any script with the passed in context.
>* `Return`: True if `aModule` was able to initialize with `aContext`.

## Virtual
>`OnInitialize()`
>> Implemented when the extending script needs to initialize.

</br>

>`OnEnable()`
>> Implemented when the extending script needs to enable.

</br>

>`OnDisable()`
>> Implemented when the extending script needs to disable.

</br>

>`OnUpgrade(Version aNew, Version aPrevious)`
>> Implemented when the extending script needs to upgrade.
>* `aNew`: The new version of the context.
>* `aPrevious`: The previous version of the context.

## Properties
>`string StateName`
>> Obtains the current state of the script, as a string.
>* `Get`: The scripts current state.

</br>

>`string EmptyState`
>> **Constant**
>> Papyrus's implicit default script state is the empty state.
>* `Get`: An empty string representing the empty state.
