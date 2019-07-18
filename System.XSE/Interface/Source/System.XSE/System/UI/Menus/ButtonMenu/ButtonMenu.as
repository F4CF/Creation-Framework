package
{
	import Shared.AS3.BSButtonHintBar;
	import Shared.AS3.BSButtonHintData;
	import Shared.GlobalFunc;
	import System.Diagnostics.Debug;
	import System.Diagnostics.Utility;
	import System.Input;
	import System.UI.MenuType;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class ButtonMenu extends MenuType implements IButtonMenu
	{

		public var ButtonBarHolder:MovieClip;


		// Menu
		//---------------------------------------------

		public function ButtonMenu()
		{
			System.Diagnostics.Debug.Prefix = "System:UI:ButtonMenu";
			super();
			Debug.WriteLine("[ButtonMenu] Constructor");
			ButtonBarHolder.ButtonHintBar_mc.bRedirectToButtonBarMenu = false;
		}


		override protected function onSetSafeRect() : void
		{
			GlobalFunc.LockToSafeRect(ButtonBarHolder, "BC", SafeX, SafeY);
			Debug.WriteLine("[ButtonMenu] onSetSafeRect");
		}


		// Methods
		//---------------------------------------------

		public function SetButtons(argument:Object, ... rest) : void
		{
			Debug.WriteLine("[ButtonMenu] SetButtons");

			if (argument != null)
			{
				var Buttons:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();

				Utility.TraceObject(argument);
				var button:BSButtonHintData = ToButtonHint(argument);
				button.ButtonVisible = true;
				button.ButtonEnabled = true;
				Buttons.push(button);

				if (rest != null)
				{
					for (var i:uint = 0; i < rest.length; i++)
					{
						Utility.TraceObject(rest[i]);
						var exbutton:BSButtonHintData = ToButtonHint(rest[i]);
						exbutton.ButtonVisible = true;
						exbutton.ButtonEnabled = true;
						Buttons.push(exbutton);
					}
				}

				ButtonBarHolder.ButtonHintBar_mc.SetButtonHintData(Buttons);
			}
			else
			{
				Debug.WriteLine("[ButtonMenu] Argument was null!");
			}
		}


		private function ToButtonHint(argument:Object) : BSButtonHintData
		{
			var textValue = argument["__struct__"]["__data__"]["text"];
			var keyCode = 	argument["__struct__"]["__data__"]["keyCode"];

			var hint:BSButtonHintData = new BSButtonHintData
			(
				textValue,
				Input.KeyCodeToPC(keyCode),
				"PlayStation",
				"Xbox",
				1,
				null
			);
			return hint;
		}


	}
}
