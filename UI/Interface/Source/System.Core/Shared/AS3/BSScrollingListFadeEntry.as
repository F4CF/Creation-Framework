package Shared.AS3
{
	import Shared.AS3.Debug;

	public class BSScrollingListFadeEntry extends BSScrollingListEntry
	{
		const fUnselectedBorderAlpha:Number = 0.5;


		public function BSScrollingListFadeEntry()
		{
			super();
		}

		override public function SetEntryText(object:Object, textOption:String) : *
		{
			Debug.WriteLine("[Shared.AS3]", "[BSScrollingListFadeEntry]", "(SetEntryText)", "textOption:"+textOption);
			super.SetEntryText(object, textOption);
			var _loc3_:* = stage.focus == this.parent;
			if(!_loc3_ && this.parent != null)
			{
				_loc3_ = stage.focus == this.parent.parent;
			}
			if(!_loc3_ && this.selected)
			{
				border.alpha = this.fUnselectedBorderAlpha;
			}
		}


	}
}
