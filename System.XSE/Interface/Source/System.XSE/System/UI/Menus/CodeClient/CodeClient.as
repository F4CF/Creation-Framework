package
{
	import F4SE.ICodeObject;
	import F4SE.XSE;
	import System.Diagnostics.Debug;
	import System.UI.MenuType;
	import flash.display.MovieClip;

	public class CodeClient extends MenuType implements F4SE.ICodeObject
	{
		// Stage
		public var Controller:MovieClip;

		// Client
		private const ClientLoadedCallback:String = "SystemCodeClient_ClientLoadedCallback";


		// Initialize
		//---------------------------------------------

		public function CodeClient()
		{
			Debug.Prefix = "System.UI";
			super();
			Debug.WriteLine("[CodeClient]", "(ctor)", "Constructor Code", this.loaderInfo.url);
		}


		// @F4SE.ICodeObject
		public function onF4SEObjCreated(codeObject:*):void
		{
			XSE.API = codeObject;
			XSE.SendExternalEvent(ClientLoadedCallback, true, Instance);
			Debug.WriteLine("[CodeClient]", "(onF4SEObjCreated)");
		}


	}
}
