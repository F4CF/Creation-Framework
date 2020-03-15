package
{
	import System.Diagnostics.Debug;
	import System.Diagnostics.Utility;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	public class ActionJSON
	{
		// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/JSON.html
		// https://help.adobe.com/en_US/as3/dev/WS324d8efcab3b0d1e2408f9e3131fddffcfc-8000.html

		private var FilePath:String = "MyFile.json";
		private var JSONLoader:URLLoader;
		private var JSONPath:URLRequest;


		// Initialize
		//---------------------------------------------

		public function ActionJSON()
		{
			Debug.WriteLine("[ActionJSON]", "(ctor)");
			JSONLoader = new URLLoader();
		}


		// Events
		//---------------------------------------------

		private function OnLoaderComplete(e:Event):void
		{
			Debug.WriteLine("[ActionJSON]", "(OnLoaderComplete)", "e:", e.toString());
			Debug.WriteLine("[ActionJSON]", "---------------------------------------------");
			Debug.WriteLine("[ActionJSON]", "(OnLoaderComplete)", "JSONPath.url:", JSONPath.url);
			Debug.WriteLine("[ActionJSON]", "(OnLoaderComplete)", "JSONLoader.data:", "\n"+JSONLoader.data.toString());
			Debug.WriteLine("[ActionJSON]", "---------------------------------------------");

			// TODO: The parser might only take a SINGLE json string value rather then a entire json object string?

			try // "ReferenceError" Error #1069
			{
				var jsonString = JSON.stringify(JSONLoader.data);
				Debug.WriteLine("[ActionJSON]", "(OnLoaderComplete)", "jsonString", jsonString);
				Debug.WriteLine("[ActionJSON]", "---------------------------------------------");
			}
			catch (error:Error)
			{
				Debug.WriteLine("[ActionJSON]", "(OnLoaderComplete)", "jsonString", "Error:", error.toString());
			}

			try // "ReferenceError" Error #1069
			{
				var jsonObject = JSON.parse(jsonString, this.OnJSON);
				Debug.WriteLine("[ActionJSON]", "(OnLoaderComplete)", "jsonObject", jsonObject.toString());
				Debug.WriteLine("[ActionJSON]", "---------------------------------------------");
			}
			catch (error:Error)
			{
				Debug.WriteLine("[ActionJSON]", "(OnLoaderComplete)", "jsonObject", "Error:", error.toString());
			}

			Utility.TraceObject(jsonObject);
			Debug.WriteLine("[ActionJSON]", "---------------------------------------------");
		}


		private function OnLoadError(e:IOErrorEvent):void
		{
			Debug.WriteLine("[ActionJSON]", "(OnLoadError)", "FilePath:"+FilePath, e.toString());
		}


		private function OnJSON(key:*, value:*):*
		{
			Debug.WriteLine("[ActionJSON]", "(OnJSON)", "key:"+key, "value:"+value);
		}


		// Methods
		//---------------------------------------------

		public function Load(filepath:String):void
		{
			JSONPath = new URLRequest();
			JSONPath.url = filepath;
			JSONLoader.addEventListener(Event.COMPLETE, this.OnLoaderComplete);
			JSONLoader.load(JSONPath);
			Debug.WriteLine("[ActionJSON]", "(Load)", "Loading the filepath '"+filepath+"'.");
		}


	}
}
