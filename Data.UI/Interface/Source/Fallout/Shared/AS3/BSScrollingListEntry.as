package Shared.AS3
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import scaleform.gfx.Extensions;
	import scaleform.gfx.TextFieldEx;
	import Shared.GlobalFunc;
	import Shared.AS3.Debug;

	public class BSScrollingListEntry extends MovieClip
	{
		public var textField:TextField;
		public var border:MovieClip;
		public var ORIG_BORDER_HEIGHT:Number;

		protected var _clipIndex:uint;
		public function get clipIndex():uint { return _clipIndex; }
		public function set clipIndex(value:uint):* { _clipIndex = value; }

		protected var _itemIndex:uint;
		public function get itemIndex():uint { return _itemIndex; }
		public function set itemIndex(value:uint):* { _itemIndex = value; }

		protected var _selected:Boolean;
		public function get selected():Boolean { return _selected; }
		public function set selected(value:Boolean):* { _selected = value; }

		protected var _HasDynamicHeight:Boolean;
		public function get hasDynamicHeight():Boolean { return _HasDynamicHeight; }
		public function get defaultHeight():Number { return ORIG_BORDER_HEIGHT; }


		// BSScrollingListEntry
		//---------------------------------------------

		public function BSScrollingListEntry()
		{
			super();
			Extensions.enabled = true;
			ORIG_BORDER_HEIGHT = border != null?Number(border.height):Number(0);
			_HasDynamicHeight = true;
		}


		// Functions
		//---------------------------------------------

		public function SetEntryText(entry:Object, textOption:String):*
		{
			Debug.WriteLine("[Shared.AS3]", "[BSScrollingListEntry]", "(SetEntryText)", "textOption:"+textOption);

			if(textField != null && entry != null && entry.hasOwnProperty("text"))
			{
				if(textOption == BSScrollingList.TEXT_OPTION_SHRINK_TO_FIT)
				{
					TextFieldEx.setTextAutoSize(textField, "shrink");
				}
				else if(textOption == BSScrollingList.TEXT_OPTION_MULTILINE)
				{
					textField.autoSize = TextFieldAutoSize.LEFT;
					textField.multiline = true;
					textField.wordWrap = true;
				}
				if(entry.text != undefined)
				{
					GlobalFunc.SetText(textField, entry.text, true);
				}
				else
				{
					GlobalFunc.SetText(textField, " ", true);
				}
				textField.textColor = !!selected?uint(0):uint(16777215);
			}

			if(border != null)
			{
				border.alpha = !!selected?Number(GlobalFunc.SELECTED_RECT_ALPHA):Number(0);
				if(textField != null && textOption == BSScrollingList.TEXT_OPTION_MULTILINE && textField.numLines > 1)
				{
					var diminsion:Number = textField.y - border.y;
					border.height = textField.textHeight + diminsion * 2 + 5;
				}
				else
				{
					border.height = ORIG_BORDER_HEIGHT;
				}
			}
		}


	}
}
