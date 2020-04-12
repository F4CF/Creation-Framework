package
{
	import Shared.AS3.BSButtonHintBar;
	import Shared.AS3.BSButtonHintData;
	import Shared.GlobalFunc;
	import Shared.PlatformChangeEvent;
	import System.Diagnostics.Debug;
	import System.Diagnostics.Dump;
	import System.Diagnostics.Utility;
	import System.UI.MenuDynamic;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	/**
	 * The primary document class for the testing menu.
	 * This menu uses the papyrus runtime injection provided by xSE.
	 * The target host menu is the "Console" menu.
	*/
	public class SystemConsole extends MenuDynamic
	{
		/** The console menu's primary document class instance. */
		public function get ConsoleMenu():MovieClip { return Root.AnimHolder_mc.Menu_mc; }

		// Panel
		public var Panel:CommandPanel;

		// Button Bar
		public var ButtonHintBar_mc:BSButtonHintBar;
		private var ConsoleShowButton:BSButtonHintData;
		private var ConsoleClearButton:BSButtonHintData;


		// Initialization
		//---------------------------------------------

		public function SystemConsole()
		{
			Debug.Prefix = "System:Console";
			ButtonBar_Init();
			super();
			Debug.WriteLine("[SystemConsole]", "(CTOR)");
			this.loaderInfo.addEventListener(Event.COMPLETE, this.OnDisplayLoaded);

			stage.addEventListener(MouseEvent.CLICK, this.OnMouseClick);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, this.OnMouseDown);

			ConsoleMenu.addEventListener(MouseEvent.CLICK, this.OnMouseClick);
			ConsoleMenu.addEventListener(MouseEvent.MOUSE_DOWN, this.OnMouseDown);

			this.addEventListener(MouseEvent.CLICK, this.OnMouseClick);
			this.addEventListener(MouseEvent.MOUSE_DOWN, this.OnMouseDown);
		}


		protected override function OnAddedToStage(e:Event):void
		{
			super.OnAddedToStage(e);
			Debug.WriteLine("[SystemConsole]", "(OnAddedToStage)");
			DynamicBegin();
		}


		protected function OnDisplayLoaded(e:Event):void
		{
			Debug.WriteLine("[SystemConsole]", "(OnDisplayLoaded)", e.toString(), "e.target:"+e.target.toString(), "e.target.name:"+e.target.name);

			GlobalFunc.LockToSafeRect(ButtonHintBar_mc, "CC", ConsoleMenu.SafeX, ConsoleMenu.SafeY);

			ButtonBar_Setup();
			this.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp);

			Panel.OnDisplayLoaded(e);

			// Dump();
		}


		protected override function OnRemovedFromStage(e:Event):void
		{
			super.OnRemovedFromStage(e);
			Debug.WriteLine("[SystemConsole]", "(OnRemovedFromStage)");
			DynamicEnd();
			// Dump();
		}

		// Input
		//---------------------------------------------

		public function OnKeyUp(e:KeyboardEvent):*
		{
			if (e.keyCode == Keyboard.HOME)
			{
				Debug.WriteLine("[SystemConsole]", "(OnKeyUp)", e.toString());
			}
		}


		public function ProcessUserEvent(asUserEventName:String, abButtonDown:Boolean):Boolean
		{
			Debug.WriteLine("[SystemConsole]", "(ProcessUserEvent)", "asUserEventName:"+asUserEventName, "abButtonDown:"+abButtonDown);
			return true;
		}


		private function OnMouseClick(e:MouseEvent):void
		{
			Debug.WriteLine("[SystemConsole]", "(OnMouseClick)", e.toString());
		}


		private function OnMouseDown(e:MouseEvent):void
		{
			Debug.WriteLine("[SystemConsole]", "(OnMouseDown)", e.toString());
		}



		// Button Bar
		//---------------------------------------------

		private function ButtonBar_Init():void
		{
			Debug.WriteLine("[SystemConsole]", "(ButtonBar_Init)");
			try
			{
				ButtonHintBar_mc["componentInspectorSetting"] = true;
				ButtonHintBar_mc.BackgroundAlpha = 1;
				ButtonHintBar_mc.BackgroundColor = 0;
				ButtonHintBar_mc.bracketCornerLength = 6;
				ButtonHintBar_mc.bracketLineWidth = 1.5;
				ButtonHintBar_mc.BracketStyle = "horizontal";
				ButtonHintBar_mc.bRedirectToButtonBarMenu = false;
				ButtonHintBar_mc.bShowBrackets = true;
				ButtonHintBar_mc.bUseShadedBackground = true;
				ButtonHintBar_mc.ShadedBackgroundMethod = "Shader";
				ButtonHintBar_mc.ShadedBackgroundType = "normal";
				ButtonHintBar_mc["componentInspectorSetting"] = false;
			}
			catch (error:Error)
			{
				Debug.WriteLine("[SystemConsole]", "(ButtonBar_Setup)", "ButtonHintBar_mc", "COMPONENT", "ERROR:", error.toString());
			}
		}


		private function ButtonBar_Setup():void
		{
			Debug.WriteLine("[SystemConsole]", "(ButtonBar_Setup)");
			try
			{
				ButtonHintBar_mc.onComponentInit(new Event(Event.INIT)); // needed on unconventional menus?
				// ButtonHintBar_mc.SetPlatform(PlatformChangeEvent.PLATFORM_PC_KB_MOUSE, false);
			}
			catch (error:Error)
			{
				Debug.WriteLine("[SystemConsole]", "(ButtonBar_Setup)", "ButtonHintBar_mc", "COMPONENT-INIT", "ERROR:", error.toString());
			}



			try
			{
				// Create a new button array.
				var buttons:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();



				// Setup the unload button.
				ConsoleShowButton = new BSButtonHintData
				(
					"Show Console",
					"R",
					"Up",
					"_Positive",
					0,
					this.OnConsoleShowButton
				);
				ConsoleShowButton.name = "ShowConsole_btn";
				ConsoleShowButton.ButtonVisible = true;
				ConsoleShowButton.ButtonEnabled = true;
				ConsoleShowButton.onAnnounceDataChange = this.AnnounceDataChange;
				ConsoleShowButton.onTextClick = this.OnConsoleShowButton;
				buttons.push(ConsoleShowButton);


				// Setup the test run button.
				ConsoleClearButton = new BSButtonHintData
				(
					"Clear Console",
					"C",
					"Down",
					"_Negative",
					0,
					this.OnConsoleClearButton
				);
				ConsoleClearButton.name = "ClearConsole_btn";
				ConsoleClearButton.ButtonText = "CLEAR";
				ConsoleClearButton.ButtonVisible = true;
				ConsoleClearButton.ButtonEnabled = true;
				ConsoleClearButton.SecondaryButtonEnabled = true;
 				ConsoleClearButton.onAnnounceDataChange = this.AnnounceDataChange;
				ConsoleClearButton.onTextClick = this.OnConsoleClearButton;
				ConsoleClearButton.secondaryButtonCallback = this.OnConsoleClearButton;
				ConsoleClearButton.onSecondaryButtonClick = this.OnConsoleClearButton;
				ConsoleClearButton.addEventListener(MouseEvent.CLICK, this.OnConsoleClearClick); // this is the data not the visual
				ConsoleClearButton.addEventListener(BSButtonHintData.BUTTON_HINT_DATA_CHANGE, this.onButtonHintDataDirtyEvent); // this is the data not the visual
				buttons.push(ConsoleClearButton);


				// Populate
				ButtonHintBar_mc.SetButtonHintData(buttons);

				// ButtonHintBar_mc.SetPlatform(PlatformChangeEvent.PLATFORM_PC_KB_MOUSE, false);

				// Populate
				// ButtonHintBar_mc.SetIsDirty();

				// ButtonHintBar_mc.redrawUIComponent();
			}
			catch (error:Error)
			{
				Debug.WriteLine("[SystemConsole]", "(ButtonBar_Setup)", "ButtonHintBar_mc", "Buttons", "ERROR:", error.toString());
			}

			// Dump and trace objects.
			// Dump.BSButtonHintBar_Trace(ButtonHintBar_mc);
			// Dump.BSButtonHintData_Trace(ConsoleClearButton);
			// Dump.BSButtonHintData_Trace(ConsoleShowButton);
		}


		// TODO: This is NOT working!
		private function OnConsoleClearClick(e:MouseEvent) : void
		{
			Debug.WriteLine("[SystemConsole]", "(OnConsoleClearClick)");
		}

		// TODO: This is NOT working!
		private function OnConsoleClearButton():void
		{
			Debug.WriteLine("[SystemConsole]", "(OnConsoleClearButton)");
		}

		// TODO: This is NOT working!
		private function OnConsoleShowButton():void
		{
			Debug.WriteLine("[SystemConsole]", "(OnConsoleShowButton)");
		}

		// TODO: This is NOT working!
		private function onButtonHintDataDirtyEvent(e:Event):void
		{
			Debug.WriteLine("[SystemConsole]", "(onButtonHintDataDirtyEvent)", e.toString());
		}

		// TODO: This is NOT working!
		private function AnnounceDataChange():void
		{
			Debug.WriteLine("[SystemConsole]", "(AnnounceDataChange)");
		}


		// Dynamic
		//---------------------------------------------

		// @MenuDynamic
		// Suppress the console menu.
		private function DynamicBegin():void
		{
			Debug.WriteLine("[SystemConsole]", "(DynamicBegin)");
			try
			{
				ConsoleMenu.visible = false;
				stage.focus = ButtonHintBar_mc;
			}
			catch (error:Error)
			{
				Debug.WriteLine("[SystemConsole]", "(DynamicBegin)", "ERROR:", error.toString());
			}
		}


		// @MenuDynamic
		// Restore the console menu to it's functional state.
		private function DynamicEnd():void
		{
			Debug.WriteLine("[SystemConsole]", "(DynamicEnd)");
			try
			{
				ConsoleMenu.visible = true;
				stage.focus = null;
			}
			catch (error:Error)
			{
				Debug.WriteLine("[SystemConsole]", "(DynamicEnd)", "ERROR:", error.toString());
			}
		}


		// Console
		//---------------------------------------------

		// @ConsoleMenu
		// Add 5 caps to the player.
		public function RunBatch(filepath:String):void
		{
			var command:String = "BAT \"CMD\\"+filepath.replace(".txt", "")+"\"";
			Debug.WriteLine("[SystemConsole]", "(RunBatch)", "filepath:"+filepath, "command:"+command);
			try
			{
				ConsoleMenu.BGSCodeObj.executeCommand(command);
			}
			catch (error:Error)
			{
				Debug.WriteLine("[SystemConsole]", "(RunBatch)", "ERROR:", error.toString());
			}
		}

		// @ConsoleMenu
		// Add 5 caps to the player.
		public function AddCaps(amount:int):void
		{
			Debug.WriteLine("[SystemConsole]", "(AddCaps)", "amount:"+amount);
			try
			{
				ConsoleMenu.BGSCodeObj.executeCommand("Player.AddItem F "+amount);
			}
			catch (error:Error)
			{
				Debug.WriteLine("[SystemConsole]", "(DynamicBegin)", "ERROR:", error.toString());
			}
		}


		// @ConsoleMenu
		// Center on the cell named RedRocketExt.
		private function CenterOnCell():void
		{
			Debug.WriteLine("[SystemConsole]", "(CenterOnCell)");
			try
			{
				ConsoleMenu.BGSCodeObj.executeCommand("COC RedRocketExt");
			}
			catch (error:Error)
			{
				Debug.WriteLine("[SystemConsole]", "(CenterOnCell)", "ERROR:", error.toString());
			}
		}


		// @ConsoleMenu
		// Starts the quest named SystemXSE_UI_Code.
		private function StartQuest():void
		{
			Debug.WriteLine("[SystemConsole]", "(StartQuest)");
			try
			{
				ConsoleMenu.BGSCodeObj.executeCommand("StartQuest SystemXSE_UI_Code");
			}
			catch (error:Error)
			{
				Debug.WriteLine("[SystemConsole]", "(StartQuest)", "ERROR:", error.toString());
			}
		}


		// @ConsoleMenu
		// Stops the quest named SystemXSE_UI_Code.
		private function StopQuest():void
		{
			Debug.WriteLine("[SystemConsole]", "(StopQuest)");
			try
			{
				ConsoleMenu.BGSCodeObj.executeCommand("StopQuest SystemXSE_UI_Code");
			}
			catch (error:Error)
			{
				Debug.WriteLine("[SystemConsole]", "(StopQuest)", "ERROR:", error.toString());
			}
		}


	}
}
