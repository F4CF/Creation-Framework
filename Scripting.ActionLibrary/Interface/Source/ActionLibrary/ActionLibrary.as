package
{
	import F4SE.ICodeObject;
	import System.Diagnostics.Debug;
	import System.Diagnostics.Utility;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	public class ActionLibrary extends MovieClip
	{

		// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/net/package-detail.html
		// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/net/URLLoader.html
		// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/net/URLRequest.html
		// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/net/URLVariables.html


		private var Document:XmlDocument;


		// Initialize
		//---------------------------------------------

		public function ActionLibrary()
		{
			System.Diagnostics.Debug.Prefix = "Action Library";
			addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
			Debug.WriteLine("(ctor)", this.loaderInfo.url);
		}


		private function OnAddedToStage(e:Event):void
		{
			Debug.WriteLine("(OnAddedToStage)");
			Document = new XmlDocument();
		}


		// Loader
		//---------------------------------------------

		public function Load(filepath:String):void
		{
			Document.Load(filepath);
		}


	}
}
