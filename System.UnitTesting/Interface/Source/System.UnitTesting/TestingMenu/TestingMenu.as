package
{
	import F4SE.XSE;
	import Shared.AS3.BSUIComponent;
	import System.Diagnostics.Debug;
	import System.Diagnostics.Utility;
	import System.Display;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class TestingMenu extends BSUIComponent
	{
		// ConsoleMenu
		private var menu:MovieClip;
		public function get MenuRoot():MovieClip { return menu; }
		public function get ConsoleMenu():MovieClip { return MenuRoot.AnimHolder_mc.Menu_mc; }

		private var Panel:TestingPanel;
		const TestingLoadEvent:String = "System_Diagnostics_TestingLoadEvent";
		const TestingUnloadEvent:String = "System_Diagnostics_TestingUnloadEvent";


		// Initialization
		//---------------------------------------------

		public function TestingMenu()
		{
			Debug.WriteLine("[TestingMenu]", "(CTOR)");
			addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, OnRemovedFromStage);
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
			addEventListener(Event.ADDED, OnAdded);
		}


		private function OnAddedToStage(e:Event):void
		{
			Debug.WriteLine("[TestingMenu]", "(OnAddedToStage)");
			menu = stage.getChildAt(0) as MovieClip;

			// Panel = new TestingPanel();
			// ConsoleMenu.addChild(Panel);

			// Debug.WriteLine("[TestingMenu]", "(OnAddedToStage)", "Tracing BGSCodeObj...");
			// Utility.TraceObject(ConsoleMenu.BGSCodeObj);

			// Debug.WriteLine("[TestingMenu]", "(OnAddedToStage)", "Tracing display list...");
			// Utility.TraceDisplayList(ConsoleMenu);

			XSE.API = MenuRoot.f4se;
			Load();
		}


		private function OnRemovedFromStage(e:Event):void
		{
			Debug.WriteLine("[TestingMenu]", "(OnRemovedFromStage)");
			XSE.SendExternalEvent(TestingUnloadEvent);
		}


		private function OnEnterFrame(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
			Debug.WriteLine("[TestingMenu]", "(OnEnterFrame)");
		}


		private function OnAdded(e:Event):void
		{
			if(e.target == this)
			{
				Debug.WriteLine("[TestingMenu]", "(OnAdded)");
			}
		}


		// Methods
		//---------------------------------------------

		public function Load():void
		{
			Debug.WriteLine("[TestingMenu]", "(Load)");
			try
			{
				ConsoleMenu.visible = false;
				XSE.SendExternalEvent(TestingLoadEvent);
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingPanel]", "(Load)", "ERROR:", error.toString());
			}
		}


		public function Unload():void
		{
			Debug.WriteLine("[TestingMenu]", "(Unload)");
			try
			{
				ConsoleMenu.visible = true;
				this.parent.removeChild(this);
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingPanel]", "(Unload)", "ERROR:", error.toString());
			}
		}


	}
}
