package
{
	import Shared.AS3.BSScrollingList;
	import System.Diagnostics.Debug;
	import flash.display.MovieClip;

	public dynamic class ResultIcon extends MovieClip
	{
		public const ResultIndeterminate:String = "Indeterminate";
		public const ResultPass:String = "Pass";
		public const ResultFail:String = "Fail";


		// Initialization
		//---------------------------------------------

		public function ResultIcon()
		{
			// Debug.WriteLine("[ResultIcon]", "(CTOR)");
		}


		// Methods
		//---------------------------------------------

		public function Indeterminate():void
		{
			// Debug.WriteLine("[ResultIcon]", "(Indeterminate)");
			gotoAndStop(ResultIndeterminate);
		}

		public function Pass():void
		{
			// Debug.WriteLine("[ResultIcon]", "(Pass)");
			gotoAndStop(ResultPass);
		}

		public function Fail():void
		{
			// Debug.WriteLine("[ResultIcon]", "(Fail)");
			gotoAndStop(ResultFail);
		}


	}
}
