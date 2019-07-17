package System
{
	import Shared.IMenu;
	import System.Diagnostics.Debug;
	import System.Display;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Menu extends IMenu
	{
		private var menu:MovieClip;
		public function get MenuRoot():MovieClip { return menu; }

		// IDisplay
		public function get Exists():Boolean { return true; }
		public function get Visible():Boolean { return this.visible; }
		public function set Visible(argument:Boolean):void { this.visible = argument; }


		// Menu
		//---------------------------------------------

		public function Menu()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
			Debug.WriteLine("[System.Menu]", "(ctor)", Display.GetInstance(this));
		}


		public function OnAddedToStage(e:Event) : void
		{
			Debug.WriteLine("[System.Menu]", "(OnAddedToStage)", Display.GetInstance(this));
			menu = stage.getChildAt(0) as MovieClip;
		}


	}
}
