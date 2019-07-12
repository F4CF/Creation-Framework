ScriptName System:Input Extends System:Object Native
{
Provides properties for DirectX keyboard scan code values.
https://www.creationkit.com/fallout4/index.php?title=DirectX_Scan_Codes
* Editor: `QUST`
}

Group Devices
	int Property DeviceAuto = 0xFF AutoReadOnly    ; 255 (Default)
	int Property DeviceKeyboard = 0x0 AutoReadOnly ; 0
	int Property DeviceMouse = 0x1 AutoReadOnly    ; 1
	int Property DeviceGamepad = 0x2 AutoReadOnly  ; 2
EndGroup

Group Controls
	; See also `Data\F4SE\CustomControlMap.txt`

	string Property Forward = "Forward" AutoReadOnly
	string Property Back = "Back" AutoReadOnly
	string Property StrafeLeft = "Strafe Left" AutoReadOnly
	string Property StrafeRight = "Strafe Right" AutoReadOnly
	string Property Move = "Move" AutoReadOnly
	string Property Look = "Look" AutoReadOnly
	string Property LeftAttackBlock = "Left Attack/Block" AutoReadOnly
	string Property RightAttackBlock = "Right Attack/Block" AutoReadOnly
	string Property Activate = "Activate" AutoReadOnly
	string Property ReadyWeapon = "Ready Weapon" AutoReadOnly
	string Property TweenMenu = "Tween Menu" AutoReadOnly
	string Property TogglePOV = "Toggle POV" AutoReadOnly
	string Property ZoomOut = "Zoom Out" AutoReadOnly
	string Property ZoomIn = "Zoom In" AutoReadOnly
	string Property Jump = "Jump" AutoReadOnly
	string Property Sprint = "Sprint" AutoReadOnly
	string Property Shouts = "Shout" AutoReadOnly
	string Property Sneak = "Sneak" AutoReadOnly
	string Property Run = "Run" AutoReadOnly
	string Property ToggleAlwaysRun = "Toggle Always Run" AutoReadOnly
	string Property AutoMove = "Auto-Move" AutoReadOnly
	string Property Favorites = "Favorites" AutoReadOnly
	string Property Hotkey1 = "Hotkey1" AutoReadOnly
	string Property Hotkey2 = "Hotkey2" AutoReadOnly
	string Property Hotkey3 = "Hotkey3" AutoReadOnly
	string Property Hotkey4 = "Hotkey4" AutoReadOnly
	string Property Hotkey5 = "Hotkey5" AutoReadOnly
	string Property Hotkey6 = "Hotkey6" AutoReadOnly
	string Property Hotkey7 = "Hotkey7" AutoReadOnly
	string Property Hotkey8 = "Hotkey8" AutoReadOnly
	string Property Quicksave = "Quicksave" AutoReadOnly
	string Property Quickload = "Quickload" AutoReadOnly
	string Property Wait = "Wait" AutoReadOnly
	string Property Journal = "Journal" AutoReadOnly
	string Property Pause = "Pause" AutoReadOnly
	string Property Screenshot = "Screenshot" AutoReadOnly
	string Property MultiScreenshot = "Multi-Screenshot" AutoReadOnly
	string Property Console = "Console" AutoReadOnly
	string Property CameraPath = "CameraPath" AutoReadOnly
	string Property QuickInventory = "Quick Inventory" AutoReadOnly
	string Property QuickMagic = "Quick Magic" AutoReadOnly
	string Property QuickStats = "Quick Stats" AutoReadOnly
	string Property QuickMap = "Quick Map" AutoReadOnly
EndGroup

Group Keyboard
	int Property Super = 92 AutoReadOnly
	int Property Backspace = 8 AutoReadOnly
	int Property Tab = 9 AutoReadOnly
	int Property Enter = 13 AutoReadOnly
	int Property CapsLock = 20 AutoReadOnly
	int Property Escape = 27 AutoReadOnly
	int Property Space = 32 AutoReadOnly
	int Property LeftShift = 160 AutoReadOnly
	int Property RightShift = 161 AutoReadOnly
	int Property LeftCtrl = 162 AutoReadOnly
	int Property RightCrtl = 163 AutoReadOnly
	int Property LeftAlt = 164 AutoReadOnly
	int Property RightAlt = 165 AutoReadOnly
	int Property Number0 = 48 AutoReadOnly
	int Property Number1 = 49 AutoReadOnly
	int Property Number2 = 50 AutoReadOnly
	int Property Number3 = 51 AutoReadOnly
	int Property Number4 = 52 AutoReadOnly
	int Property Number5 = 53 AutoReadOnly
	int Property Number6 = 54 AutoReadOnly
	int Property Number7 = 55 AutoReadOnly
	int Property Number8 = 56 AutoReadOnly
	int Property Number9 = 57 AutoReadOnly
	int Property A = 65 AutoReadOnly
	int Property B = 66 AutoReadOnly
	int Property C = 67 AutoReadOnly
	int Property D = 68 AutoReadOnly
	int Property E = 69 AutoReadOnly
	int Property F = 70 AutoReadOnly
	int Property G = 71 AutoReadOnly
	int Property H = 72 AutoReadOnly
	int Property I = 73 AutoReadOnly
	int Property J = 74 AutoReadOnly
	int Property K = 75 AutoReadOnly
	int Property L = 76 AutoReadOnly
	int Property M = 77 AutoReadOnly
	int Property N = 78 AutoReadOnly
	int Property O = 79 AutoReadOnly
	int Property P = 80 AutoReadOnly
	int Property Q = 81 AutoReadOnly
	int Property R = 82 AutoReadOnly
	int Property S = 83 AutoReadOnly
	int Property T = 84 AutoReadOnly
	int Property U = 85 AutoReadOnly
	int Property V = 86 AutoReadOnly
	int Property W = 87 AutoReadOnly
	int Property X = 88 AutoReadOnly
	int Property Y = 89 AutoReadOnly
	int Property Z = 90 AutoReadOnly
	int Property SemiColon = 186 AutoReadOnly
	int Property Equals = 187 AutoReadOnly
	int Property Comma = 188 AutoReadOnly
	int Property Minus = 189 AutoReadOnly
	int Property Period = 190 AutoReadOnly
	int Property ForwardSlash = 191 AutoReadOnly
	int Property LeftBracket = 219 AutoReadOnly
	int Property RightBracket = 221 AutoReadOnly
	int Property Apostrophe = 222 AutoReadOnly
	int Property BackwardSlash01 = 220 AutoReadOnly
	int Property BackwardSlash02 = 226 AutoReadOnly
	int Property F1 = 112 AutoReadOnly
	int Property F2 = 113 AutoReadOnly
	int Property F3 = 114 AutoReadOnly
	int Property F4 = 115 AutoReadOnly
	int Property F5 = 116 AutoReadOnly
	int Property F6 = 117 AutoReadOnly
	int Property F7 = 118 AutoReadOnly
	int Property F8 = 119 AutoReadOnly
	int Property F9 = 120 AutoReadOnly
	int Property F10 = 121 AutoReadOnly
	int Property F11 = 122 AutoReadOnly
	int Property NumberLock = 144 AutoReadOnly
	int Property ScreenLock = 145 AutoReadOnly
	int Property PageUp = 33 AutoReadOnly
	int Property PageDown = 34 AutoReadOnly
	int Property End = 35 AutoReadOnly
	int Property Home = 36 AutoReadOnly
	int Property Left = 37 AutoReadOnly
	int Property Up = 38 AutoReadOnly
	int Property Right = 39 AutoReadOnly
	int Property Down = 40 AutoReadOnly
	int Property Delete = 46 AutoReadOnly
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

Group Mouse
	int Property Mouse1 = 256 AutoReadOnly
	int Property Mouse2 = 257 AutoReadOnly
	int Property Mouse3 = 258 AutoReadOnly
	int Property Mouse4 = 259 AutoReadOnly
	int Property Mouse5 = 260 AutoReadOnly
EndGroup
