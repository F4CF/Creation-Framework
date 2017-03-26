# [Documentation](../Documentation.md) #
Scripting Papyrus

# Class
An optional module provides operations the modification is able to function without.

## Inheritance
* [ScriptObject](http://www.creationkit.com/fallout4/index.php?title=ScriptObject_Script)
* [Form](http://www.creationkit.com/fallout4/index.php?title=Form_Script)
* [Papyrus:Project:Modules:Module](Papyrus_Project_Modules_Module.md)
* `Papyrus:Project:Modules:Optional`

## Editor
Does not attach to any editor objects.

# Members
These are the members of this class.

## Functions
>`bool ActiveState(bool abActive = true)`
>> Attempts to put the script into an active or empty state.
>* `Return`: True if `aModule` was able to initialize with `aContext`.

## Properties
>`bool IsReady`
>> Prevents the module from
>* `Get`: Returns true if the module is ready to operate.

</br>

>`bool Enabled`
>> Prevents the module from
>> Invokes `OnStartup` and `OnShutdown` events.
>* `Get`: True if this context is activated.
>* `Set`: If true this context will startup, else this context will shutdown.

</br>

>`string ActiveState`
>> **Constant**
>> The active state is when functions and events are operational.
>* `Get`: The state name for ActiveState.

</br>

>`Actor Player`
>> A built in reference to the player for extending scripts to use.
>* `Get`: An instance of the `Player` actor.

</br>

>`Project:Context Context`
>> **Auto**
>> A built in reference to the context for extending scripts to use.
>* `Get`: An instance to the context.
