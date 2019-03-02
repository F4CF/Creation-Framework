package Shared
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import Shared.AS3.Debug;
	import Shared.AS3.Utility;
	import Shared.IMenu;

	public class Display extends IMenu implements IDisplay
	{
		private var menu:MovieClip;
		public function get MenuRoot():MovieClip { return menu; }

		// IDisplay
		public function get Exists():Boolean { return true; }
		public function get Visible():Boolean { return this.visible; }
		public function set Visible(argument:Boolean):void { this.visible = argument; }


		// Menu
		//---------------------------------------------

		public function Display()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
			Debug.WriteLine("[Display]", "(ctor)", Utility.WalkMovie(this));
		}


		public function OnAddedToStage(e:Event) : void
		{
			Debug.WriteLine("[Display]", "(OnAddedToStage)", Utility.WalkMovie(this));
			menu = stage.getChildAt(0) as MovieClip;
		}


	}
}
