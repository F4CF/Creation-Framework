package
{
	import System.Diagnostics.Debug;
	import System.UI.Components.PriorityLoader;
	import flash.events.Event;

	public dynamic class ScopeLoader extends PriorityLoader
	{
		// Initialize
		//---------------------------------------------

		public function ScopeLoader(menuName:String, mountID:String)
		{
			super(menuName, mountID);
		}


		override protected function OnLoadComplete(e:Event):void
		{
			Debug.WriteLine("[ScopeLoader]", "(OnLoadComplete)", "FilePath:"+FilePath);
			this.dispatchEvent(new Event(LOAD_COMPLETE));
		}


	}
}
