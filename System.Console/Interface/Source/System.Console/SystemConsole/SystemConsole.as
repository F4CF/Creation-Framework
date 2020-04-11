package
{
	import System.Diagnostics.Debug;
	import System.UI.MenuDynamic;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;

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


		// Initialization
		//---------------------------------------------

		public function SystemConsole()
		{
			Debug.Prefix = "System:Console";
			super();
			Debug.WriteLine("[SystemConsole]", "(CTOR)");
			this.loaderInfo.addEventListener(Event.COMPLETE, this.OnDisplayLoaded);
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
			this.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp);
			// Dump();
		}


		protected override function OnRemovedFromStage(e:Event):void
		{
			super.OnRemovedFromStage(e);
			Debug.WriteLine("[SystemConsole]", "(OnRemovedFromStage)");
			DynamicEnd();
			// Dump();
		}


		public function OnKeyUp(e:KeyboardEvent):*
		{
			if (e.keyCode == Keyboard.HOME)
			{
				Debug.WriteLine("[SystemConsole]", "(OnKeyUp)", e.toString());
				AddCaps(1);
				CenterOnCell();
			}
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
				stage.focus = Panel.CommandList_mc;
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
