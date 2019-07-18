package
{
	import F4SE.ICodeObject;
	import F4SE.XSE;
	import System.Diagnostics.Debug;
	import System.UI.MenuType;
	import flash.display.MovieClip;

	public class ScopeClient extends MenuType implements F4SE.ICodeObject
	{
		// Host
		public var ScopeMenu:MovieClip;
		private const Name:String = "ScopeMenu"; // the parent menu name


		// Stage Instance
		public var Controller:MovieClip;

		// Client
		private const ClientLoadedCallback:String = "SystemScopeMenu_ClientLoadedCallback";


		// Loader
		private var Scope:ScopeLoader;
		private var ScopeFrame:int = 0;

		private const MountID:String = "ScopeMenu_ImageMount";

		// Initialize
		//---------------------------------------------

		public function ScopeClient()
		{
			Debug.Prefix = "System:UI:Scope";
			super();
			Debug.WriteLine("[ScopeClient]", "(ctor)", "Constructor Code", this.loaderInfo.url);
		}


		// @F4SE.ICodeObject
		public function onF4SEObjCreated(codeObject:*):void
		{
			F4SE.XSE.API = codeObject;
			Debug.WriteLine("[ScopeClient]", "(onF4SEObjCreated)");
		}


	}
}
