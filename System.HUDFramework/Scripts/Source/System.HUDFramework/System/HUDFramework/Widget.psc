ScriptName System:HUDFramework:Widget Extends System:HUDFramework:WidgetType Hidden
import System:Log
import System:PointType
import System:HUDFramework:Framework

HUDFramework HUD
WidgetData Data

; Methods
;---------------------------------------------

Function Setup()
	HUDFramework framework = HUDFramework.GetInstance()
	If (framework)
		HUD = framework
		Data = new WidgetData

		self.OnSetup(Data)

		If (Data)
			WriteLine("System", self, "The '"+WidgetToString(Data)+"' widget was created.")
		Else
			WriteLine("System", self, "The created widget is none.")
		EndIf
	Else
		WriteLine("System", self, "Could not get an instance to the HUD Framework.")
	EndIf
EndFunction


Function Register()
	If (WidgetRegister(HUD, Data, self))
		self.OnRegistered()
		WriteLine("System", self, "The widget has been registered.")
	EndIf
EndFunction


Function Unregister()
	If (WidgetUnregister(HUD, Data))
		self.OnUnregistered()
		WriteLine("System", self, "The widget has been unregistered.")
	EndIf
EndFunction


bool Function Load()
	return WidgetLoad(HUD, Data)
EndFunction


bool Function Unload()
	If (WidgetUnload(HUD, Data))
		self.OnUnloaded()
		return true
	Else
		return false
	EndIf
EndFunction


Function Update()
	self.OnUpdated()
EndFunction


; Callbacks
;---------------------------------------------

; @HUDFramework
Function HUD_WidgetLoaded(string widgetID)
	If (widgetID == Data.ID)
		self.OnLoaded()
		WriteLine("System", self, "HUD Framework has loaded the '"+widgetID+"' widget.")
	Else
		WriteLine("System", self, "Loaded unhandled '"+widgetID+"' widget.")
	EndIf
EndFunction


; Functions
;---------------------------------------------

Function ScaleModify(Point value)
	If (IsLoaded)
		HUD.ModWidgetScale(Data.ID, value.X, value.Y)
	EndIf
EndFunction


Function PositionModify(Point value)
	If (IsLoaded)
		HUD.ModWidgetPosition(Data.ID, value.X, value.Y)
	EndIf
EndFunction


Function PositionUp(int value)
	Position = PointAddition(Position, PointMultiply(Down(), value))
EndFunction


Function PositionDown(int value)
	Position = PointAddition(Position, PointMultiply(Up(), value))
EndFunction


Function PositionLeft(int value)
	Position = PointAddition(Position, PointMultiply(Left(), value))
EndFunction


Function PositionRight(int value)
	Position = PointAddition(Position, PointMultiply(Right(), value))
EndFunction


Function SendNumber(int aiCommand, float afArgument)
	If (IsLoaded)
		If (aiCommand != -1)
			HUD.SendMessage(Data.ID, aiCommand, afArgument)
		;	WriteLine("System", self, "Sent the '"+aiCommand+"' number command with the '"+afArgument+"' argument.")
		Else
			WriteLine("System", self, "Cannot send an invalid '-1' number command.")
		EndIf
	EndIf
EndFunction


Function SendText(string asCommand, string asArgument)
	If (IsLoaded)
		If (asCommand)
			HUD.SendMessageString(Data.ID, asCommand, asArgument)
		;	WriteLine("System", self, "Sent the '"+asCommand+"' text command with the '"+asArgument+"' argument.")
		Else
			WriteLine("System", self, "Cannot send a none string command.")
		EndIf
	EndIf
EndFunction


Function SendCustom(Message akMessage)
	If (IsLoaded)
		If (akMessage)
			HUD.SendCustomMessage(akMessage)
		;	WriteLine("System", self, "Sent the '"+akMessage+"' custom message form.")
		Else
			WriteLine("System", self, "Cannot send a none Message form.")
		EndIf
	EndIf
EndFunction


; Virtual
;---------------------------------------------

Event OnSetup(WidgetData widget)
	{VIRTUAL}
	WriteLine("System", self, "The widget has not implemented the virtual 'OnSetup' event.")
EndEvent


Event OnRegistered()
	{VIRTUAL}
	WriteLine("System", self, "The widget has not implemented the virtual 'OnRegistered' event.")
EndEvent


Event OnUnregistered()
	{VIRTUAL}
	WriteLine("System", self, "The widget has not implemented the virtual 'OnUnregistered' event.")
EndEvent


Event OnLoaded()
	{VIRTUAL}
	WriteLine("System", self, "The widget has not implemented the virtual 'OnLoaded' event.")
EndEvent


Event OnUnloaded()
	{VIRTUAL}
	WriteLine("System", self, "The widget has not implemented the virtual 'OnUnloaded' event.")
EndEvent


Event OnUpdated()
	{VIRTUAL}
	WriteLine("System", self, "The widget has not implemented the virtual 'OnUpdated' event.")
EndEvent


; Properties
;---------------------------------------------

Group Widget
	bool Property IsRegistered Hidden
		bool Function Get()
			If (HUD)
				If (HUD.IsWidgetRegistered(Data.ID))
					return true
				Else
					WriteLine("System", self, "The '"+Data.ID+"' widget is not ready, must register with HUD Framework.")
					return false
				EndIf
			Else
				WriteLine("System", self, "The '"+Data.ID+"' widget is not ready, HUD Framework is none.")
				return false
			EndIf
		EndFunction
	EndProperty


	bool Property IsLoaded Hidden
		bool Function Get()
			If (IsRegistered)
				If (HUD.IsWidgetLoaded(Data.ID))
					return true
				Else
					WriteLine("System", self, "The widget '"+Data.ID+"' is not loaded right now.")
					return false
				EndIf
			Else
				WriteLine("System", self, "The '"+Data.ID+"' widget is not loaded, HUD Framework is none.")
				return false
			EndIf
		EndFunction
	EndProperty


	Point Property Position Hidden
		Point Function Get()
			float[] array = HUD.GetWidgetPosition(Data.ID)
			Point value = new Point
			value.X = array[0]
			value.Y = array[1]
			return value
		EndFunction
		Function Set(Point value)
			HUD.SetWidgetPosition(Data.ID, value.X, value.Y)
		EndFunction
	EndProperty


	Point Property Scale Hidden
		Point Function Get()
			float[] array = HUD.GetWidgetScale(Data.ID)
			Point value = new Point
			value.X = array[0]
			value.Y = array[1]
			return value
		EndFunction
		Function Set(Point value)
			HUD.SetWidgetScale(Data.ID, value.X, value.Y)
		EndFunction
	EndProperty


	float Property Opacity Hidden
		float Function Get()
			return HUD.GetWidgetOpacity(Data.ID)
		EndFunction
		Function Set(float value)
			HUD.SetWidgetOpacity(Data.ID, value)
		EndFunction
	EndProperty
EndGroup
