package
{
	import System.Diagnostics.Debug;
	import System.UI.MenuDynamic;
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * The primary document class for the testing menu.
	 * This menu uses the papyrus runtime injection provided by xSE.
	 * The target host menu is the "Console" menu.
	*/
	public class TestingMenu extends MenuDynamic
	{
		/** The console menu's primary document class instance. */
		public function get ConsoleMenu():MovieClip { return Root.AnimHolder_mc.Menu_mc; }

		// Panel
		public var Panel:TestingPanel;


		// Initialization
		//---------------------------------------------

		public function TestingMenu()
		{
			Debug.Prefix = "System.UnitTesting.TestingMenu";
			super();
			Debug.WriteLine("[TestingMenu]", "(CTOR)");
			this.loaderInfo.addEventListener(Event.COMPLETE, this.OnDisplayLoaded);
		}


		protected override function OnAddedToStage(e:Event):void
		{
			super.OnAddedToStage(e);
			Debug.WriteLine("[TestingMenu]", "(OnAddedToStage)");
			try
			{
				// Suppress the console menu.
				ConsoleMenu.visible = false;
				stage.focus = Panel.UnitList_mc;
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingMenu]", "(OnAddedToStage)", "ERROR:", error.toString());
			}
		}


		protected function OnDisplayLoaded(e:Event):void
		{
			Debug.WriteLine("[TestingMenu]", "(OnDisplayLoaded)", e.toString(), "e.target:"+e.target.toString(), "e.target.name:"+e.target.name);
			Dump();
		}


		protected override function OnRemovedFromStage(e:Event):void
		{
			super.OnRemovedFromStage(e);
			Debug.WriteLine("[TestingMenu]", "(OnRemovedFromStage)");

			try
			{
				// Restore the console menu to it's functional state.
				ConsoleMenu.visible = true;
				stage.focus = null;
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingMenu]", "(OnRemovedFromStage)", "ERROR:", error.toString());
			}

			Dump();
		}


	}
}
