# Fallout 4 Creation Framework
A general purpose scripting library and framework for Fallout 4 which provides support for Actionscript 3.0 and Papyrus.
These libraries and frameworks are heavily inspired by Microsoft's .NET Framework.

The framework is divided into several assemblies, imports, and namespaces.

# Dependencies
The following projects are used as dependencies.

## [F4SE](https://f4se.silverlock.org/)
The Fallout 4 Script Extender, or F4SE for short, is a modder's resource that expands the scripting capabilities of Fallout 4.
It does so without modifying the executable files on disk, so there are no permanent side effects.

## [Fallout 4 Interface Development Kit](https://github.com/Scrivener07/FO4_Interface)
The unofficial Fallout 4 user interface development kit.
The user interface library has no assembly.
The UI scripting framework is a distributed library which may be included with source code.


# Assembly: `System.esl`
The scripting framework assembly `System.esl` is divided into several imports and namespaces.
```
System.esl
System - Main.ba2
```
#### Import: `System`
The namespace contains fundamental classes and base classes that define commonly-used functions and data types.

#### Import: `System.Diagnostics`
The namespace includes classes that allow you to interact with papyrus logs, performance counters, unit testing, and other diagnostics.

#### Import: `System.Objects`
The namespace includes classes that allow you to programmatically instantiate `new` Papyrus script instances.


# Assembly: `System.XSE.esl`
The scripting framework assembly `System.XSE.esl` provides classes for interacting with XSE.
```
System.XSE.esl
System.XSE - Main.ba2
```
#### Import: `System.XSE`
The namespace includes classes that provide extension methods for XSE functions and data types.

#### Import: `System.UI`
The namespace includes classes that allow for interacting with the Scaleform user interface.


# Assembly: `System.HUDFramework.esl`
The namespace includes classes that allow for interacting with the HUD Framework by Reg2K.
```
System.HUDFramework.esl
System.HUDFramework - Main.ba2
```


# Assembly: `System.MCM.esl`
The namespace includes classes that allow for interacting with the Mod Configuration Menu by Neanka.
```
System.MCM.esl
System.MCM - Main.ba2
```


# Assembly: `Scripting.esl`
The scripting framework assembly `Scripting.esl` contains highly reusable and common scripts.
```
Scripting.esl
Scripting - Main.ba2
```
#### Import: `Scripting`
The namespace includes classes that provide common patterns for projects.
