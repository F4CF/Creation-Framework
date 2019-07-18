package
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import Components.AssetLoader;
	import F4SE.XSE;
	import F4SE.ICodeObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import System.Diagnostics.Debug;
	import System.Diagnostics.Utility;
	import System.Menu;

	public class VisorMenu extends Menu implements F4SE.ICodeObject
	{
		// Stage
		public var Controller:MovieClip;

		// Loader
		private var Overlay:VisorLoader;
		private const Name:String = "SystemVisorMenu";
		private const MountID:String = "System_UI_VisorMenu_ImageMount";

		// Client
		private const ClientLoadedCallback:String = "System_UI_VisorMenu_ClientLoadedCallback";


		// Initialize
		//---------------------------------------------

		public function VisorMenu()
		{
			System.Diagnostics.Debug.Prefix = "System:UI:Visor";
			super();
			Debug.WriteLine("[VisorMenu]", "(ctor)", "Constructor Code", this.loaderInfo.url);
		}


		protected override function OnAddedToStage(e:Event):void
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
			F4SE.XSE.API = codeObject;
			Debug.WriteLine("[VisorMenu]", "(onF4SEObjCreated)");
		}

		// Events
		//---------------------------------------------

		private function OnLoadComplete(e:Event):void
		{
			var client:String = GetClient();
			XSE.SendExternalEvent(ClientLoadedCallback, true, client);
			Debug.WriteLine("[VisorMenu]", "(OnLoadComplete)", "Overlay found at '"+Overlay.FilePath+"' with client instance of '"+client+"'.");
		}


		private function OnLoadError(e:IOErrorEvent):void
		{
			XSE.SendExternalEvent(ClientLoadedCallback, false, null);
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
