package Components
{
	import Components.AssetLoader;
	import F4SE.XSE;
	import flash.display.MovieClip;
	import flash.events.Event;
	import System.Diagnostics.Debug;
	import System.Diagnostics.Utility;
	import System.Display;
	import System.IO.File;
	import System.IO.FileSystem;
	import System.IO.Path;

	public dynamic class PriorityLoader extends AssetLoader
	{
		// Initialize
		//---------------------------------------------

		public function PriorityLoader(menuName:String, mountID:String)
		{
			super(menuName, mountID);
		}


		// Events
		//---------------------------------------------

		override protected function OnLoadComplete(e:Event):void
		{
			Display.ScaleToHeight(Content, Display.DefaultHeight);
			super.OnLoadComplete(e);
			Utility.TraceDisplayList(MovieClip(stage.getChildAt(0)));
			Debug.WriteLine("[PriorityLoader]", "(OnLoadComplete)", e.toString()+", "+toString());
		}


		// Methods
		//---------------------------------------------

		override public function Load(filepath:String):Boolean
		{
			var extension:String = Path.GetExtension(filepath);
			var path:String = filepath;

			if (extension == File.NIF)
			{
				extension = File.SWF;
				path = Path.ChangeExtension(filepath, extension);
			}

			if (extension == File.SWF && File.ExistsIn(FileSystem.Interface, path))
			{
				Debug.WriteLine("[PriorityLoader]", "Found SWF:", "path:"+path);
				return super.Load(path);
			}
			else
			{
				extension = File.DDS;
				path = Path.ChangeExtension(filepath, extension);
			}

			if (extension == File.DDS && File.ExistsIn(FileSystem.Textures, path))
			{
				Debug.WriteLine("[PriorityLoader]", "Found DDS:", "path:"+path);
				return super.Load(path);
			}
			else
			{
				Debug.WriteLine("[PriorityLoader]", "No overlay file was found.");
				Unload();
				return false;
			}
		}


	}
}
