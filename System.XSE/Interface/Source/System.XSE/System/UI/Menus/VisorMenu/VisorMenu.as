package
{
	import F4SE.ICodeObject;
	import F4SE.XSE;
	import System.Diagnostics.Debug;
	import System.Diagnostics.Utility;
	import System.UI.Components.AssetLoader;
	import System.UI.MenuType;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;

	public class VisorMenu extends MenuType implements F4SE.ICodeObject
	{
		// Stage
		public var Controller:MovieClip;

		// Loader
		private var Overlay:VisorLoader;
		private const Name:String = "SystemVisorMenu";
		private const MountID:String = "System_UI_VisorMenu_ImageMount";

		// Client
		private const AssetLoadedEvent:String = "System_UI_VisorMenu_AssetLoadedEvent";


		// Initialize
		//---------------------------------------------

		public function VisorMenu()
		{
			System.Diagnostics.Debug.Prefix = "System:UI:Visor";
			super();
			Debug.WriteLine("[VisorMenu]", "(ctor)", "Constructor Code", this.loaderInfo.url);
		}


		override protected function OnAddedToStage(e:Event):void
		{
			Overlay = new VisorLoader(Name, MountID);
			Overlay.addEventListener(AssetLoader.LOAD_COMPLETE, this.OnLoadComplete);
			Overlay.addEventListener(AssetLoader.LOAD_ERROR, this.OnLoadError);
			Controller.addChild(Overlay);
			Debug.WriteLine("[VisorMenu]", "(OnAddedToStage)", "Client:"+GetClient());
		}


		// @F4SE.ICodeObject
		public function onF4SEObjCreated(codeObject:*):void
		{
			XSE.API = codeObject;
			Debug.WriteLine("[VisorMenu]", "(onF4SEObjCreated)");
		}

		// Events
		//---------------------------------------------

		private function OnLoadComplete(e:Event):void
		{
			var client:String = GetClient();
			XSE.SendExternalEvent(AssetLoadedEvent, true, client);
			Debug.WriteLine("[VisorMenu]", "(OnLoadComplete)", "Overlay found at '"+Overlay.FilePath+"' with client instance of '"+client+"'.");
		}


		private function OnLoadError(e:IOErrorEvent):void
		{
			XSE.SendExternalEvent(AssetLoadedEvent, false, null);
			Debug.WriteLine("[VisorMenu]", "(OnLoadError)", "No overlay found at '"+Overlay.FilePath+"'.");
		}


		// Methods
		//---------------------------------------------

		public function Load(filepath:String):Boolean
		{
			Debug.WriteLine("[VisorMenu]", "(Load)", "Setting the filepath to '"+filepath+"'.");
			Overlay.Load(filepath);
			return true;
		}


		public function AlphaTo(value:Number, duration:Number):Boolean
		{
			Debug.WriteLine("[VisorMenu]", "(AlphaTo)", "Alpha is tweening from "+alpha+" to "+value+" over "+duration+" seconds.");
			TweenMax.to(Controller, duration, {alpha:value});
			return true;
		}


		/**
		 * Gets the instance variable to the loaded client overlay.
		 */
		public function GetClient():String
		{
			return Overlay.GetInstance();
		}


	}
}
