package
{
	import Shared.AS3.BSScrollingList;
	import System.Diagnostics.Debug;
	import flash.display.MovieClip;

	public dynamic class CommandIcon extends MovieClip
	{
		public const ResultIndeterminate:String = "Indeterminate";
		public const ResultPass:String = "Pass";
		public const ResultFail:String = "Fail";


		// Initialization
		//---------------------------------------------

		public function CommandIcon()
		{
			// Debug.WriteLine("[CommandIcon]", "(CTOR)");
		}


		// Methods
		//---------------------------------------------

		public function Indeterminate():void
		{
			// Debug.WriteLine("[CommandIcon]", "(Indeterminate)");
			gotoAndStop(ResultIndeterminate);
		}

		public function Pass():void
		{
			// Debug.WriteLine("[CommandIcon]", "(Pass)");
			gotoAndStop(ResultPass);
		}

		public function Fail():void
		{
			// Debug.WriteLine("[CommandIcon]", "(Fail)");
			gotoAndStop(ResultFail);
		}


	}
}
