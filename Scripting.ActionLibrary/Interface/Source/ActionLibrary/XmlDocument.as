package
{
	import System.Diagnostics.Debug;
	import System.Diagnostics.Utility;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.FileReference;
	import flash.xml.*;

	public class XmlDocument
	{
		// TODO: Floating point numbers have typical floating point inaccuracies.
		// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/XML.html
		// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/XMLList.html
		// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/net/FileReference.html
		// https://help.adobe.com/en_US/as3/dev/WS5b3ccc516d4fbf351e63e3d118a9b90204-7e71.html
		// https://help.adobe.com/en_US/as3/dev/WS5b3ccc516d4fbf351e63e3d118a9b90204-7e6b.html
		// https://stackoverflow.com/questions/4929193/turn-an-xml-string-into-an-object-in-actionscript
		// https://www.kirupa.com/developer/flashcs3/using_xml_as3_pg1.htm

		private var TestFile:String = "MyFile.xml";

		private var XMLLoader:URLLoader;
		private var XMLPath:URLRequest;
		private var XMLObject:XML;


		// Initialize
		//---------------------------------------------

		public function XmlDocument()
		{
			Debug.WriteLine("[XML]", "(ctor)");
			XMLLoader = new URLLoader();
		}

		// Events
		//---------------------------------------------

		private function OnLoaderComplete(e:Event):void
		{
			Debug.WriteLine("[XML]", "(OnLoaderComplete)", "e:", e.toString());
			Debug.WriteLine("[XML]", "---------------------------------------------");
			Debug.WriteLine("[XML]", "(OnLoaderComplete)", "XMLPath.url:", XMLPath.url);
			Debug.WriteLine("[XML]", "(OnLoaderComplete)", "XMLLoader.data:", "\n"+XMLLoader.data.toString());
			Debug.WriteLine("[XML]", "---------------------------------------------");
			try
			{
				XML.ignoreWhitespace = true;
				XML.ignoreComments = true;
				XMLObject = new XML(XMLLoader.data);
			}
			catch (error:Error)
			{
				Debug.WriteLine("[XML]", "(OnLoaderComplete)", "Error:", error.toString());
			}

			Testing(XMLObject);
		}


		private function OnLoadError(e:IOErrorEvent):void
		{
			Debug.WriteLine("[XML]", "(OnLoadError)", "TestFile:"+TestFile, e.toString());
		}


		// Methods
		//---------------------------------------------

		public function Load(filepath:String):void
		{
			Debug.WriteLine("[XML]", "(Load)", "Loading the filepath '"+filepath+"'.");

			try
			{
				XMLPath = new URLRequest(filepath);
				XMLLoader = new URLLoader(XMLPath);
				XMLLoader.addEventListener(Event.COMPLETE, this.OnLoaderComplete);
			}
			catch (error:Error)
			{
				Debug.WriteLine("[XML]", "(Load)", "Error:", error.toString());
			}
		}


		// Testing
		//---------------------------------------------

		private static function Testing(xml:XML):void
		{
			try
			{
				TraceXML(xml, "Book");

				// GetValueFor(xml, "Book", "Author");
				// Debug.WriteLine("[XML]");

				// GetValueFor(xml, "Book", "Author");
				// Debug.WriteLine("[XML]");

				GetValueBy(xml, 0, "Price");
				Debug.WriteLine("[XML]");

				GetValueBy(xml, 1, "Price");
				Debug.WriteLine("[XML]");


				// saving out a file
				var file:FileReference = new FileReference();
				file.save(xml, "Derp.xml");
			}
			catch (error:Error)
			{
				Debug.WriteLine("[XML]", "(Testing)", "Error:", error.toString());
			}
		}


		private static function TraceXML(xml:XML, nodeName:String):void
		{
			Debug.WriteLine("TraceXML", "name:", xml.name());
			Debug.WriteLine("TraceXML", "length:", xml.length());
			Debug.WriteLine("TraceXML", "nodeKind:", xml.nodeKind());
			Debug.WriteLine("---------------------------------------------");

			var list:XMLList = xml[nodeName].children();
			for each (var node:XML in list)
			{
				Debug.WriteLine("(TraceXML)", node.name()+":", node);
			}

			Debug.WriteLine("---------------------------------------------");
		}


		private static function GetValueBy(xml:XML, index:int, propertyName:String):*
		{
			Debug.WriteLine("(GetValueBy)", xml.name()+",", "index: "+index+",", "propertyName: "+propertyName);

			var child = null;
			try
			{
				var children:XMLList = xml.children();
				var node = children[index];
				if(node.hasOwnProperty(propertyName))
				{
					child = node.child(propertyName);
				}
				else
				{
					Debug.WriteLine("[XML]", "(GetValueBy)", "The property '"+propertyName+"' does not exist.");
				}
			}
			catch (error:Error)
			{
				Debug.WriteLine("[XML]", "(GetValueBy)", "Error:", error.toString());
			}

			var result = child.text();//.toString();
			Debug.WriteLine("[XML]", "(GetValueBy)", "result:"+result);
			return result;
		}




		private static function GetValueFor(xml:XML, nodeName:String, propertyName:String):*
		{
			Debug.WriteLine("(GetValueFor)", "nodeName: "+nodeName+",", "propertyName: "+propertyName);
			var result = null;
			try
			{
				// var list:XMLList = xml[nodeName].children();
				var list:XMLList = xml.elements(nodeName);

				if(list.hasOwnProperty(propertyName))
				{
					Debug.WriteLine("[XML]", "(GetValueFor)", "propertyName:"+propertyName, "yes");
					result = list.child(propertyName);
					// result = list.elements(propertyName);
				}
				else
				{
					Debug.WriteLine("[XML]", "(GetValueFor)", "propertyName:"+propertyName, "no");
				}
			}
			catch (error:Error)
			{
				Debug.WriteLine("[XML]", "(GetValueFor)", "Error:", error.toString());
			}

			Debug.WriteLine("(GetValueFor)", "result:", result);
			return result;
		}



	}
}
