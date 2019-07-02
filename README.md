# Fallout 4 Scripting Framework
A general purpose scripting library and framework for Fallout 4 which provides support for Actionscript 3.0 and Papyrus.
These libraries and frameworks are heavily inspired by Microsoft's .NET Framework.

The framework is divided into several assemblies, imports, and namespaces.

# Assembly: `System.esl`
The scripting framework assembly `System.esl` is divided into several imports and namespaces.
```
System.esl
System - Main.ba2
|   Array.pex
|   BoolType.pex
|   Environment.pex
|   External.pex
|   Form.pex
|   FormEx.pex
|   Log.pex
|   ObjectMod.pex
|   ObjectModEx.pex
|   PointType.pex
|   Reference.pex
|   Script.pex
|   StringType.pex
|   Time.pex
|   VersionType.pex
|
+---Collections
|       Collection.pex
|       Dictionary.pex
|       List.pex
|       Queue.pex
|       Stack.pex
|
+---Diagnostics
|       Common.pex
|       Lilac.pex
|       LilacEx.pex
|
+---Objects
|       Factory.pex
|
\---Projects
    |   Context.pex
    |   ContextType.pex
    |   Module.pex
    |
    +---Modules
    |       Optional.pex
    |       Required.pex
    |
    \---Settings
            ContextActivated.pex
            ModuleOptionalEnable.pex
```

#### Import: `System`
The namespace contains fundamental classes and base classes that define commonly-used functions and data types.

#### Import: `System.Diagnostics`
The namespace includes classes that allow you to interact with papyrus logs, performance counters, unit testing, and other diagnostics.

#### Import: `System.Objects`
The namespace includes classes that allow you to programmatically instantiate `new` Papyrus script instances.

#### Import: `System.Projects`
The namespace includes classes that provide common patterns for projects.



# Assembly: `System.UI.esl`
The scripting framework assembly `System.UI.esl` provides classes for interacting with the Scaleform user interface.

#### Import: `System.UI`
The namespace includes classes that allow for interacting with the Scaleform user interface.



# Assembly: `System.HUDFramework.esl`
The namespace includes classes that allow for interacting with the HUD Framework by Reg2K.

# Assembly: `System.MCM.esl`
The namespace includes classes that allow for interacting with the Mod Configuration Menu by Neanka.

# Assembly: `Scripting.esl`
The scripting framework assembly `Scripting.esl` contains highly reusable and common scripts.

# UI
The UI scripting framework is a distributed library which may be included with source code. The user interface library has no assembly.
