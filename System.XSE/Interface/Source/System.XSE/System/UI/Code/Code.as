package System.UI.Code
{
	import F4SE.Extensions;
	import F4SE.ICodeObject;
	import flash.display.MovieClip;
	import System.Diagnostics.Debug;

	public class Code extends MovieClip implements F4SE.ICodeObject
	{
		// Stage
		public var Controller:MovieClip;

		// Client
		// private const ClientLoadedCallback:String = "SystemCode_ClientLoadedCallback";


		// Initialize
		//---------------------------------------------

		public function Code()
		{
			super();
			Debug.Prefix = "System.UI";
			Debug.WriteLine("[Code]", "(ctor)", "Constructor Code", this.loaderInfo.url);
		}


		// @F4SE.ICodeObject
		public function onF4SEObjCreated(codeObject:*):void
		{
			F4SE.Extensions.API = codeObject;
			Debug.WriteLine("[Code]", "(onF4SEObjCreated)");
		}


	}
}
