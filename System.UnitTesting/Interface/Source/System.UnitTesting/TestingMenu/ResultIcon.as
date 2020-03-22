package
{
	import Shared.AS3.BSScrollingList;
	import System.Diagnostics.Debug;
	import flash.display.MovieClip;

	public dynamic class ResultIcon extends MovieClip
	{
		private const ResultIndeterminate:String = "Indeterminate";
		private const ResultPass:String = "Pass";
		private const ResultFail:String = "Fail";


		// Initialization
		//---------------------------------------------

		public function ResultIcon()
		{
			Debug.WriteLine("[ResultIcon]", "(CTOR)");
		}


		// Methods
		//---------------------------------------------

		public function Indeterminate():void
		{
			Debug.WriteLine("[ResultIcon]", "(Indeterminate)");
			gotoAndStop(ResultIndeterminate);
		}

		public function Pass():void
		{
			Debug.WriteLine("[ResultIcon]", "(Pass)");
			gotoAndStop(ResultPass);
		}

		public function Fail():void
		{
			Debug.WriteLine("[ResultIcon]", "(Fail)");
			gotoAndStop(ResultFail);
		}


	}
}
