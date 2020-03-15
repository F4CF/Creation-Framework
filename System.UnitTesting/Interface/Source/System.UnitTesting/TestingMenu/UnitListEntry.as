package
{
	import Shared.AS3.BSScrollingListEntry;
	import System.Diagnostics.Debug;

	public dynamic class UnitListEntry extends BSScrollingListEntry
	{
		public function get Text():String { return this["text"]; }
		public function set Text(value:String):void { this["text"] = value; }


		public function UnitListEntry()
		{
			Debug.WriteLine("[UnitListEntry]", "(CTOR)");
		}


	}
}
