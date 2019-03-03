package System.IO
{
	import F4SE.Extensions;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import System.Diagnostics.Debug;

	/**
	 * Exposes static methods for working with files.
	 */
	public class File
	{
		public static const SWF:String = "swf";
		public static const DDS:String = "dds";


		public static function Exists(f4se:*, archive:String, filepath:String):Boolean
		{
			var name:String = Path.GetFileName(filepath);
			var folder:String = Path.GetDirectory("Data\\"+archive+"\\"+filepath);

			if (archive == FileSystem.Interface)
			{
				return F4SE.Extensions.GetDirectoryListing(f4se, folder, name, false).length > 0;
			}
			else if (archive == FileSystem.Textures)
			{
				return F4SE.Extensions.GetDirectoryListing(f4se, folder, name, false).length > 0;
			}
			else
			{
				Debug.WriteLine("[System.IO.File]", "(Exists)", "archive: "+archive, "The archive is unhandled.");
				return false;
			}
		}


	}
}
