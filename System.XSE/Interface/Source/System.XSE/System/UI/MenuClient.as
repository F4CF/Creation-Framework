package System.UI
{
	import F4SE.XSE;
	import F4SE.ICodeObject;
	import System.Diagnostics.Debug;
	import System.Display;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class MenuClient extends MenuType implements F4SE.ICodeObject
	{
		// Client
		private const ClientLoadedCallback:String = "SystemUI_ClientLoadedCallback";

		// Initialize
		//---------------------------------------------

		public function MenuClient()
		{
			Debug.WriteLine("[MenuClient]", "(ctor)");
		}


		// @F4SE.ICodeObject
		public function onF4SEObjCreated(codeObject:*):void
		{
			if (XSE.API == null)
			{
				if (UseXSE(codeObject))
				{
					Debug.WriteLine("[MenuClient]", "(onF4SEObjCreated)", "The XSE API has been acquired.");
				}
			}
		}


		override protected function OnAddedToStage(e:Event):void
		{
			if (XSE.API == null)
			{
				if (UseXSE(Root.f4se))
				{
					Debug.WriteLine("[MenuClient]", "(OnAddedToStage)", "The XSE API has been acquired.");
				}
			}
		}


		// Methods
		//---------------------------------------------

		protected function UseXSE(codeObject:*):Boolean
		{
			if (codeObject != null)
			{
				XSE.API = codeObject;
				return SendClientLoadedCallback(Display.GetInstanceFrom(this, Root));
			}
			else
			{
				Debug.WriteLine("[MenuClient]", "(UseXSE)", "The code object cannot be null.");
				return false;
			}
		}


		protected function SendClientLoadedCallback(variable:String):Boolean
		{
			return XSE.API.SendExternalEvent(ClientLoadedCallback, true, variable);
		}


	}
}
