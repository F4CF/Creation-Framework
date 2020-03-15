package
{
	import System.Display;
	import System.Diagnostics.Debug;
	import System.Diagnostics.Utility;
	import flash.display.MovieClip;
	import flash.events.Event;
	import Shared.AS3.BSUIComponent;

	public class TestingMenu extends BSUIComponent
	{
		// ConsoleMenu
		private var menu:MovieClip;
		public function get MenuRoot():MovieClip { return menu; }
		public function get ConsoleMenu():MovieClip { return MenuRoot.AnimHolder_mc.Menu_mc; }

		private var Panel:TestingPanel;


		// Initialization
		//---------------------------------------------

		public function TestingMenu()
		{
			Debug.WriteLine("[TestingMenu]", "(CTOR)");
			addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, OnRemovedFromStage);
		}


		private function OnAddedToStage(e:Event):void
		{
			Debug.WriteLine("[TestingMenu]", "(OnAddedToStage)");
			menu = stage.getChildAt(0) as MovieClip;

			Panel = new TestingPanel();
			addEventListener(Event.ADDED_TO_STAGE, OnPanelAddedToStage);
			ConsoleMenu.addChild(Panel);

			// Debug.WriteLine("[TestingMenu]", "(OnAddedToStage)", "Tracing BGSCodeObj...");
			// Utility.TraceObject(ConsoleMenu.BGSCodeObj);

			// Debug.WriteLine("[TestingMenu]", "(OnAddedToStage)", "Tracing display list...");
			// Utility.TraceDisplayList(ConsoleMenu);
		}


		private function OnPanelAddedToStage(e:Event):void
		{
			Debug.WriteLine("[TestingMenu]", "(OnPanelAddedToStage)");
		}


		private function OnRemovedFromStage(e:Event):void
		{
			Debug.WriteLine("[TestingMenu]", "(OnRemovedFromStage)");
		}


	}
}
