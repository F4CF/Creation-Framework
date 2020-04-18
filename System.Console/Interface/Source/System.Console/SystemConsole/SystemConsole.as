package
{
	import System.Diagnostics.Debug;
	import System.Diagnostics.Dump;
	import System.UI.MenuDynamic;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
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

		// Button Bar Menu
		public var MenuButtonBar_mc:MenuButtonBar;


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

			try
			{
				// System.Diagnostics.Dump.DisplayObject_Trace(this);
				Dump();
				this.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp);
			}
			catch (error:Error)
			{
				Debug.WriteLine("[SystemConsole]", "(OnDisplayLoaded)", "ERROR:", error.toString());
			}

			Panel.OnDisplayLoaded(e);
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
			Debug.WriteLine("[SystemConsole]", "(OnKeyUp)", e.toString());
			if (e.keyCode == Keyboard.HOME)
			{
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
				// ConsoleMenu.visible = true;
				// stage.focus = ButtonHintBar_mc;
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
				// ConsoleMenu.visible = true;
				// stage.focus = null;
			}
			catch (error:Error)
			{
				Debug.WriteLine("[SystemConsole]", "(DynamicEnd)", "ERROR:", error.toString());
			}
		}


		// Console
		//---------------------------------------------

		// @ConsoleMenu
		// Executes a batch console command file.
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



	}
}
