ScriptName ActionTest:DiskTest Extends Quest

string MyFile = "MyFile.xml" const


; Events
;---------------------------------------------

Event OnQuestInit()
	RegisterForKey(PageUp)
	RegisterForKey(PageDown)
	RegisterForKey(NumPadPlus)
	RegisterForKey(NumPadAsterisk)
	RegisterForKey(NumPad8)
	RegisterForKey(NumPad2)
EndEvent


Event OnKeyDown(int keyCode)
	If (keyCode == PageUp)
		Disk.Open()

	ElseIf (keyCode == PageDown)
		Disk.Close()

	ElseIf (keyCode == NumPadPlus)
		bool success = Disk.Load(MyFile)

	ElseIf (keyCode == NumPadAsterisk)
		bool exists = Disk.Exists(MyFile)

	ElseIf (keyCode == NumPad8)
		var[] values = new var[0]
		values.Add("My String")
		values.Add(99)
		values.Add(true)
		values.Add(false)
		values.Add(self)
		bool success = Disk.Write(MyFile, values)

	ElseIf (keyCode == NumPad2)
		var[] values = Disk.Read(MyFile)

		int index = 0
		While (index < values.Length)
			Debug.TraceSelf(self, "Disk.Read: ", values[index])
			index += 1
		EndWhile

	Else
		; unhandled key code
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Actuals
	Action:Disk Property Disk Auto Const Mandatory
EndGroup

Group Keyboard
	; https://www.creationkit.com/fallout4/index.php?title=DirectX_Scan_Codes

	int Property PageUp = 33 AutoReadOnly
	int Property PageDown = 34 AutoReadOnly
	int Property End = 35 AutoReadOnly
	int Property Home = 36 AutoReadOnly
	int Property NumPad0 = 96 AutoReadOnly
	int Property NumPad1 = 97 AutoReadOnly
	int Property NumPad2 = 98 AutoReadOnly
	int Property NumPad3 = 99 AutoReadOnly
	int Property NumPad4 = 100 AutoReadOnly
	int Property NumPad5 = 101 AutoReadOnly
	int Property NumPad6 = 102 AutoReadOnly
	int Property NumPad7 = 103 AutoReadOnly
	int Property NumPad8 = 104 AutoReadOnly
	int Property NumPad9 = 105 AutoReadOnly
	int Property NumPadAsterisk = 106 AutoReadOnly
	int Property NumPadPlus = 107 AutoReadOnly
	int Property NumPadMinus = 109 AutoReadOnly
	int Property NumPadPeriod = 110 AutoReadOnly
	int Property NumPadFowardSlash = 111 AutoReadOnly
EndGroup
