package
{
	import Shared.AS3.BSScrollingList;
	import System.Diagnostics.Debug;
	import flash.display.MovieClip;
	import flash.text.TextField;

	public dynamic class CommandCard extends MovieClip
	{
		public var SelectedScript_tf:TextField;
		public var SelectedName_tf:TextField;
		public var SelectedDescription_tf:TextField;


		// Initialization
		//---------------------------------------------

		public function CommandCard()
		{
			Debug.WriteLine("[CommandCard]", "(CTOR)");
		}


	}
}
