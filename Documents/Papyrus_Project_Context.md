# [Documentation](../Documentation.md) #
Scripting Papyrus

# Class
This class is central to the modification. It stores meta and notifies scripts about the modification.

## Inheritance
* [ScriptObject](http://www.creationkit.com/fallout4/index.php?title=ScriptObject_Script)
* [Form](http://www.creationkit.com/fallout4/index.php?title=Form_Script)
* [Quest](http://www.creationkit.com/fallout4/index.php?title=Quest_Script)
* `Project:Context`

## Editor
Attaches to a single Quest object.

# Members
These are the members of this class.

## Events
>`OnStartup`
>> Notifies other scripts when this context is starting.

</br>

>`OnUpgrade`
>> Notifies other scripts when this context is upgrading its version.
>* `[0], Version`: The new version for this context.
>* `[1], Version`: The previous version for this context.

</br>

>`OnShutdown`
>> Notifies other scripts when this context is shutting down.

## Globals
>`Project:Context GetInstance() Global`
>> Attempts to get this script instance using the plugin filename and EditorID.
>* `Return`: The context script instance.

</br>

>`UserLog GetLog() Global DebugOnly`
>> **Constant:**
>> Configures a user log using `GetTitle` as the log filename.
>* `Return`: The context user log

</br>

>`string GetTitle() Global`
>> **Constant:**
>> The friendly text name for this context. This does not need to match the plugin filename.
>* `Return`: The title of this context.

</br>

>`string GetPlugin() Global`
>> **Constant**
>> The plugins filename and extension.
>* `Return`: The filename of the plugin that this context belongs to.

</br>

>`int GetEditorID() Global`
>> **Constant**
>> The EditorID of the quest this script is attached to.
>* `Return`: The EditorID of the quest this script is attached to.

## Properties
>`bool IsReady`
>> Allows the context to be activated. The context is ready if the first stage of `MQ102` is done.
>* `Get`: The context ready condition.

</br>

>`bool IsActivated`
>> If `IsReady` equals true, sets the context activated.
>> Invokes `OnStartup` and `OnShutdown` events.
>* `Get`: True if this context is activated.
>* `Set`: If true this context will startup, else this context will shutdown.

</br>

>`string Title`
>> Provides an instance member for the `GetTitle` global function.
>* `Get`: The title of this context.

</br>

>`string Plugin`
>> Provides an instance member for the `GetPlugin` global function.
>* `Get`: The filename of the plugin that this context belongs to.

</br>

>`int EditorID`
>> Provides an instance member for the `GetEditorID` global function.
>* `Get`: The EditorID of the object that this context is attached to.

</br>

>`string[] Authors`
>> **Constant**
>> This is a collection of author names that contributed to this modification.
>* `Get`: An array of author names.

</br>

>`Version Release`
>> **Constant**
>> This is the current version of the modification.
>* `Get`: The current release version of the context.








