package System.UI
{
	import Shared.IMenu;
	import System.Diagnostics.Debug;
	import System.Diagnostics.Dump;
	import System.Diagnostics.Utility;
	import System.Display;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	// The base class for menu types.
	public class MenuType extends IMenu
	{
		// The host menu.
		private var menu:MovieClip;
		public function get Root():MovieClip { return menu; }

		// The swf file path for this menu.
		public function get Url():String { return this.loaderInfo.url; }

		// The instance variable path from this menu to the display root.
		public function get Instance():String { return Display.GetInstanceFrom(this, Root); }

		// Callable by Papyrus to check for existence.
		public function get Exists():Boolean { return true; }

		// MovieClip
		public function get Visible():Boolean { return this.visible; }
		public function set Visible(value:Boolean):void { this.visible = value; }

		public function get Alpha():Number { return this.alpha; }
		public function set Alpha(value:Number):void { this.alpha = value; }


		// MenuType
		//---------------------------------------------

		public function MenuType()
		{
			Debug.WriteLine("[System.UI.MenuType]", "(CTOR)");
		}


		// @IMenu
		protected override function onStageInit(e:Event):*
		{
			Debug.WriteLine("[System.UI.MenuType]", "(IMenu::onStageInit)", e.toString());
			super.onStageInit(e);
			OnAddedToStage(e);
		}

		protected function OnAddedToStage(e:Event):void
		{
			Debug.WriteLine("[System.UI.MenuType]", "(OnAddedToStage)");
			menu = GetRoot();
		}


		// @IMenu
		protected override function onStageDestruct(e:Event):*
		{
			Debug.WriteLine("[System.UI.MenuType]", "(IMenu::onStageDestruct)", e.toString());
			super.onStageDestruct(e);
			OnRemovedFromStage(e);
		}

		protected function OnRemovedFromStage(e:Event):void
		{
			Debug.WriteLine("[System.UI.MenuType]", "(OnRemovedFromStage)");
		}

		//---------------------------------------------

		// @IMenu
		protected override function onPlatformRequestEvent(e:Event):*
		{
			Debug.WriteLine("[System.UI.MenuType]", "(IMenu::onPlatformRequestEvent)", e.toString());
			super.onPlatformRequestEvent(e);
		}

		// @IMenu
		protected override function onSetSafeRect():void
		{
			Debug.WriteLine("[System.UI.MenuType]", "(IMenu::onSetSafeRect)");
			super.onSetSafeRect();
		}

		// @IMenu
		protected override function onMouseFocus(e:FocusEvent):*
		{
			Debug.WriteLine("[System.UI.MenuType]", "(IMenu::onMouseFocus)", e.toString());
			super.onMouseFocus(e);
		}

		// @IMenu
		public override function SetPlatform(auiPlatform:uint, abPS3Switch:Boolean):*
		{
			Debug.WriteLine("[System.UI.MenuType]", "(IMenu::SetPlatform)", "auiPlatform:"+auiPlatform, "abPS3Switch:"+abPS3Switch);
			super.SetPlatform(auiPlatform, abPS3Switch);
		}

		// @IMenu
		public override function SetSafeRect(aSafeX:Number, aSafeY:Number):*
		{
			Debug.WriteLine("[System.UI.MenuType]", "(IMenu::SetSafeRect)", "aSafeX:"+aSafeX, "aSafeY:"+aSafeY);
			super.SetSafeRect(aSafeX, aSafeY);
		}

		// @IMenu
		public override function ShrinkFontToFit(textField:TextField, amaxScrollV:int):*
		{
			Debug.WriteLine("[System.UI.MenuType]", "(IMenu::ShrinkFontToFit)", "textField:"+textField.text, "amaxScrollV:"+amaxScrollV);
			super.ShrinkFontToFit(textField, amaxScrollV);
		}


		// Methods
		//---------------------------------------------

		protected function Dump():void
		{
			Debug.WriteLine("\n\n");
			Debug.WriteLine("["+this.name+"]", "(Dump)");
			Debug.WriteLine("---------------------------------------------");
			System.Diagnostics.Dump.MenuType_Trace(this);
			System.Diagnostics.Dump.IMenu_Trace(this);
			System.Diagnostics.Dump.MovieClip_Trace(this);
			System.Diagnostics.Dump.DisplayObject_Trace(this);
			Debug.WriteLine("---------------------------------------------");
			Utility.TraceDisplayList(stage);
			Debug.WriteLine("---------------------------------------------");
			Debug.WriteLine("\n\n");
		}


		private function GetRoot():MovieClip
		{
			return stage.getChildAt(0) as MovieClip;
		}


	}
}
