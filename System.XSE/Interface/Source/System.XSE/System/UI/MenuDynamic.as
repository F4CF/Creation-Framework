package System.UI
{
	import F4SE.ICodeObject;
	import F4SE.XSE;
	import System.Diagnostics.Debug;
	import System.Diagnostics.Utility;
	import System.Display;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;

	// The base class for menu types that are dynamically loaded with the `UI.Load()` Papyrus API provided by XSE.
	// TODO: Rename the extenal events ReadyEvent & UnloadEvent.
	public class MenuDynamic extends MenuType implements F4SE.ICodeObject
	{
		// TODO: The extenal client event, deprecate.
		private const ClientLoadedCallback:String = "SystemUI_ClientLoadedCallback";

		// TODO: The asset extenal ready event.
		public static const ReadyEvent:String = "System:UI:MenuDynamic:ReadyEvent";

		// TODO: The asset extenal unload and dispose event.
		public static const UnloadEvent:String = "System:UI:MenuDynamic:UnloadEvent";


		// Initialization
		//---------------------------------------------

		public function MenuDynamic()
		{
			Debug.WriteLine("[System.UI.MenuDynamic]", "(CTOR)");
		}


		protected override function OnAddedToStage(e:Event):void
		{
			super.OnAddedToStage(e);
			Debug.WriteLine("[System.UI.MenuDynamic]", "(OnAddedToStage)");
			onF4SEObjCreated(Root.f4se);
			SendReadyEventCallback();
		}


		protected override function OnRemovedFromStage(e:Event):void
		{
			super.OnRemovedFromStage(e);
			Debug.WriteLine("[System.UI.MenuDynamic]", "(OnRemovedFromStage)");
			SendUnloadEventCallback();
		}


		// XSE
		//---------------------------------------------

		// @F4SE.ICodeObject
		public function onF4SEObjCreated(codeObject:*):void
		{
			if (XSE.API == null)
			{
				if (codeObject != null)
				{
					XSE.API = codeObject;
					Debug.WriteLine("[System.UI.MenuDynamic]", "(onF4SEObjCreated)", "The XSE API has been acquired.");
					SendClientLoadedCallback(true, Instance);
				}
				else
				{
					Debug.WriteLine("[System.UI.MenuDynamic]", "(onF4SEObjCreated)", "The code object cannot be null.");
				}
			}
			else
			{
				Debug.WriteLine("[System.UI.MenuDynamic]", "(onF4SEObjCreated)", "No action necessary. The XSE API has already been acquired.");
			}
		}


		// Papyrus
		//---------------------------------------------

		// @Papyrus
		// Unloads the "loaded" aka "injected" swf file from the display list.
		// Attempts to unload child SWF file contents and stops the execution of commands from loaded SWF files.
		// Where `instance2` is "this", and `instance1` is the XSE created swf loader.
		// The `instance1` object is the `flash.display.Loader` class created when Papyrus calls the `UI.Load()` function.
		// ```
		// [Library] 0: root1 --> [object MovieClip]
		// [Library]    0: instance1 --> [object Loader]
		// [Library]       0: instance2 --> [object MyMenu]
		// ```
		// SEE: https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/Loader.html#unloadAndStop()
		// SEE: https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/Loader.html#contentLoaderInfo
		public function Unload():Boolean
		{
			Debug.WriteLine("[System.UI.MenuDynamic]", "(Unload)", "Attempting to unload object at `"+Instance+"`.");
			if (parent != null)
			{
				var loader:Loader = parent as Loader;
				if (loader != null)
				{
					Debug.WriteLine("[System.UI.MenuDynamic]", "(Unload)", loader.contentLoaderInfo.url.toString(), loader.loaderInfo.url.toString());
					Root.removeChild(loader);
					loader.unloadAndStop();
					return true;
				}
				else
				{
					Debug.WriteLine("[System.UI.MenuDynamic]", "(Unload)", "The parent must be a `flash.display.Loader` class type.");
					return false;
				}
			}
			else
			{
				Debug.WriteLine("[System.UI.MenuDynamic]", "(Unload)", "The parent cannot be null.");
				return false;
			}
		}


		// Papyrus Callbacks
		//---------------------------------------------

		// TODO: Deprecate this method in favor of `SendReadyEventCallback`.
		protected function SendClientLoadedCallback(success:Boolean, variable:String):Boolean
		{
			Debug.WriteLine("[System.UI.MenuDynamic]", "(SendClientLoadedCallback)", "Sending external event:", ClientLoadedCallback, "success:"+success, "variable:"+variable);
			return XSE.SendExternalEvent(ClientLoadedCallback, success, variable);
		}


		protected function SendReadyEventCallback():Boolean
		{
			Debug.WriteLine("[System.UI.MenuDynamic]", "(SendReadyEventCallback)", "Sending external event:", ReadyEvent);
			return XSE.SendExternalEvent(ReadyEvent);
		}


		protected function SendUnloadEventCallback():Boolean
		{
			Debug.WriteLine("[System.UI.MenuDynamic]", "(SendUnloadEventCallback)", "Sending external event:", UnloadEvent);
			return XSE.SendExternalEvent(UnloadEvent);
		}


	}
}
