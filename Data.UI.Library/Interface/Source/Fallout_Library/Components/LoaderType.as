package Components
{ // WIP
	import F4SE.Extensions;
	import F4SE.ICodeObject;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import System.Diagnostics.Debug;
	import System.Display;
	import System.IO.Path;

	// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/DisplayObject.html
	// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/Loader.html
	// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/LoaderInfo.html
	// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/net/URLRequest.html

	public dynamic class LoaderType extends MovieClip implements F4SE.ICodeObject
	{
		protected var XSE:*;

		// Stage
		private function get Resolution():Number { return stage.height; }
		public static const DefaultHeight:Number = 720;

		// Loader
		private var ContentLoader:Loader;
		private function get Info() : LoaderInfo { return ContentLoader.contentLoaderInfo; }
		private function get Url() : String { return ContentLoader.contentLoaderInfo.url; }
		protected function get Content() : DisplayObject { return ContentLoader.contentLoaderInfo.content; }
		private function get Instance() : String { return Display.GetInstanceFrom(Content, this); }


		// Initialize
		//---------------------------------------------

		public function LoaderType()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.OnRemovedFromStage);
			this.visible = false;

			ContentLoader = new Loader();
			Info.addEventListener(Event.COMPLETE, this.OnLoadComplete);
			Info.addEventListener(IOErrorEvent.IO_ERROR, this.OnLoadError);
			Debug.WriteLine("[Components.LoaderType]", "(ctor)", "Constructor Code");
		}


		public function onF4SEObjCreated(codeObject:*) : void
		{ // @F4SE.ICodeObject
			if(codeObject != null)
			{
				XSE = codeObject;
				Debug.WriteLine("[Components.LoaderType]", "(onF4SEObjCreated)", "Received the F4SE code object.");
			}
			else
			{
				Debug.WriteLine("[Components.LoaderType]", "(onF4SEObjCreated)", "The F4SE object was null.");
			}
		}


		// Events
		//---------------------------------------------

		protected function OnAddedToStage(e:Event) : void
		{
			Debug.WriteLine("[Components.LoaderType]", "(OnAddedToStage)");
		}


		protected function OnRemovedFromStage(e:Event) : void
		{
			Debug.WriteLine("[Components.LoaderType]", "(OnRemovedFromStage)", "Unloading..");
			Unload();
		}


		protected function OnLoadComplete(e:Event) : void
		{
			Debug.WriteLine("[Components.LoaderType]", "(OnLoadComplete)", e.toString());
			addChild(Content);
			this.visible = true;
		}


		protected function OnLoadError(e:IOErrorEvent) : void
		{
			Debug.WriteLine("[Components.LoaderType]", "(OnLoadError)", e.toString());
			Unload();
		}


		// Methods
		//---------------------------------------------

		public function Load(request:URLRequest) : Boolean
		{
			ContentLoader.close();
			if (Content)
			{
				Unload();
			}
			ContentLoader.load(request);
			return true;
		}


		protected function LoadPath(filePath:String) : Boolean
		{
			return Load(new URLRequest(filePath));
		}


		public function Unload() : Boolean
		{
			this.visible = false;
			ContentLoader.close();
			if (Content)
			{
				removeChild(Content);
				ContentLoader.unload();
				Debug.WriteLine("[Components.LoaderType]", "(Unload)", "Unloaded content from loader.");
				return true;
			}
			else
			{
				Debug.WriteLine("[Components.LoaderType]", "(Unload)", "No existing content to unload.");
				return false;
			}
		}


		// Functions
		//---------------------------------------------

		public override function toString() : String
		{
			var sResolution = "Resolution: "+stage.width+"x"+stage.height+" ("+this.x+"x"+this.y+")";
			var sUrl = "Url: '"+Url+"'";
			return "[Components.LoaderType] "+sResolution+", "+sUrl;
		}


	}
}
