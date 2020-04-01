package
{
	import Shared.AS3.BSScrollingListEntry;
	import System.Diagnostics.Debug;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;

	public dynamic class UnitListEntry extends BSScrollingListEntry
	{
		public function get Text():String { return this["text"]; }
		public function set Text(value:String):void { this["text"] = value; }

		public function get Name():String { return Name_tf.text; }
		public function set Name(value:String):void { Name_tf.text = value; }
		public var Name_tf:TextField;

		public function get Description():String { return Description_tf.text; }
		public function set Description(value:String):void { Description_tf.text = value; }
		public var Description_tf:TextField;

		public var Icon_mc:ResultIcon;


		// Initialization
		//---------------------------------------------

		public function UnitListEntry()
		{
			// Debug.WriteLine("[UnitListEntry]", "(CTOR)");
			addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
		}


		private function OnAddedToStage(e:Event):void
		{
			// Debug.WriteLine("[UnitListEntry]", "(OnAddedToStage)");
			Text = "Unknown";
			Name = "Unnamed Unit Test";
			Description = "This is a default unit test description.";
			Icon_mc.Fail(); // this works
		}


		// Methods
		//---------------------------------------------

		public function Indeterminate():void
		{
			// Debug.WriteLine("[UnitListEntry]", "(Indeterminate)");
			Icon_mc.Indeterminate();
		}


		public function Pass():void
		{
			// Debug.WriteLine("[UnitListEntry]", "(Pass)");
			Icon_mc.Pass();
		}


		public function Fail():void
		{
			// Debug.WriteLine("[UnitListEntry]", "(Fail)");
			Icon_mc.Fail();
		}


		public override function toString():String
		{
			return Text+": "+Name+", "+Description;
		}


	}
}
