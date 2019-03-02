package
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import hudframework.IHUDWidget;

	public class Main extends MovieClip implements IHUDWidget
	{
		public var BGSCodeObj:Object;


		public function Main()
		{
			super();
			this.BGSCodeObj = new Object();
		}


		public function processMessage(command:String, params:Array):void
		{
			trace("processMessage(command:'"+command+"', params:'"+params[0]+"')");
			TraceObject();
		}



		private function TraceObject():void
		{
			//this.BGSCodeObj.executeCommand("TMM 1");
			for (var element in this.BGSCodeObj)
			{
				trace(element + ":  " + this.BGSCodeObj[element]);
		 	}
		}


	}
}
