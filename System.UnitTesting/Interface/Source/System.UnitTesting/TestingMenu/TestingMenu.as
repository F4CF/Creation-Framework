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

		// Asset
		private const ReadyEvent:String = "System_Diagnostics_TestingReadyEvent";
		private const UnloadEvent:String = "System_Diagnostics_TestingUnloadEvent";

		// Panel
		public var Panel:TestingPanel;


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
			AquireXSE();
			Load();
			XSE.SendExternalEvent(ReadyEvent);
			DebugTraceDisplay();
		}


		private function OnRemovedFromStage(e:Event):void
		{
			Debug.WriteLine("[TestingMenu]", "(OnRemovedFromStage)");
			XSE.SendExternalEvent(UnloadEvent);
			DebugTraceDisplay();
		}


		// XSE
		//---------------------------------------------

		private function AquireXSE():void
		{
			try
			{
				XSE.API = MenuRoot.f4se;
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingMenu]", "(AquireXSE)", "ERROR:", error.toString());
			}
		}


		// Methods
		//---------------------------------------------

		private function Load():void
		{
			try
			{
				// `stage.focus` is needed for item pressed?
				stage.focus = Panel.UnitList_mc;
				ConsoleMenu.visible = false;
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingMenu]", "(Load)", "ERROR:", error.toString());
			}
		}


		// @Papyrus
		// https://community.adobe.com/t5/animate/unloading-an-swf-movie-from-the-swf-itself-in-as3/
		public function Unload():void
		{
			Debug.WriteLine("[TestingMenu]", "(Unload)");
			try
			{
				stage.focus = null;
				ConsoleMenu.visible = true;

				// stage.removeChild(parent);
				RemoveFromStage();
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingMenu]", "(Unload)", "ERROR:", error.toString());
			}
		}

		// Display
		//---------------------------------------------

		// Unload the "loaded" swf file from the display list.
		private function RemoveFromStage():void
		{
			if (parent != null)
			{
				if (parent.loaderInfo != null)
				{
					if (parent.loaderInfo.loader != null)
					{
						Debug.WriteLine("[TestingMenu]", "(RemoveFromStage)", "Removing...");
						parent.loaderInfo.loader.unloadAndStop();
					}
					else
					{
						Debug.WriteLine("[TestingMenu]", "(RemoveFromStage)", "The parent loader object cannot be null.");
					}
				}
				else
				{
					Debug.WriteLine("[TestingMenu]", "(RemoveFromStage)", "The parent loader info cannot be null.");
				}
			}
			else
			{
				Debug.WriteLine("[TestingMenu]", "(RemoveFromStage)", "The parent cannot be null.");
			}
		}


		// Debug
		//---------------------------------------------

		private function DebugTraceLoader():void
		{
			Debug.WriteLine("[TestingMenu]", "(DebugTraceLoader)");
			Debug.WriteLine("---------------------------------------------");
			// Utility.TraceDisplayList(stage);
			Debug.WriteLine("---------------------------------------------");
		}


		private function DebugTraceDisplay():void
		{
			Debug.WriteLine("[TestingMenu]", "(DebugTraceDisplay)");
			Debug.WriteLine("---------------------------------------------");
			Utility.TraceDisplayList(stage);
			Debug.WriteLine("---------------------------------------------");
		}


	}
}
