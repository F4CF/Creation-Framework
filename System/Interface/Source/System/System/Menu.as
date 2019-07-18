package System
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import Shared.IMenu;
	import System.Diagnostics.Debug;
	import System.Display;

	public class Menu extends IMenu
	{
		public function get Root():MovieClip { return stage.getChildAt(0) as MovieClip; }
		public function get Instance():String { return Display.GetInstance(this); }
		public function get Exists():Boolean { return true; }

		public function get Visible():Boolean { return this.visible; }
		public function set Visible(value:Boolean):void { this.visible = value; }

		public function get Alpha():Number { return this.alpha; }
		public function set Alpha(value:Number):void { this.alpha = value; }


		// Menu
		//---------------------------------------------

		public function Menu()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
			Debug.WriteLine("[System.Menu]", "(ctor)", "Root:"+Root, "Instance:"+Instance);
		}


		protected function OnAddedToStage(e:Event) : void
		{
			Debug.WriteLine("[System.Menu]", "(OnAddedToStage)", "Root:"+Root, "Instance:"+Instance);
		}


		protected function OnRemovedFromStage(e:Event) : void
		{
			Debug.WriteLine("[System.Menu]", "(OnRemovedFromStage)");
		}


	}
}
