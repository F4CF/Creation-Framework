package System.IO
{
	import F4SE.Extensions;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import System.Diagnostics.Debug;

	/**
	 * Provides static methods for working with files.
	 * TODO: Allow match pattern from the root of `Data\` directory.
	 * TODO: Should I have the `Exists` condition strictly `.length == 1` or `.length > 0`?
	 */
	public class File
	{
		// Type Extensions
		public static const SWF:String = "swf";
		public static const NIF:String = "nif";
		public static const DDS:String = "dds";


		/**
		 * Determines whether the specified file exists.
		 * @param f4se - The F4SE code object to use.
		 * @param filepath - The file to check. "Fallout 4\Data\{FILEPATH}"
		 * @return true if the path contains the name of an existing file; otherwise, false.
		 */
		public static function Exists(f4se:*, filepath:String):Boolean
		{
			var name:String = Path.GetFileName(filepath);
			var folder:String = Path.GetDirectory(filepath);
			return F4SE.Extensions.GetDirectoryListing(f4se, folder, name, false).length == 1;
		}


		/**
		 * Determines whether the specified file exists within an archive directory.
		 * @param f4se - The F4SE code object to use.
		 * @param archive - The archive directory to check within. "Fallout 4\Data\{ARCHIVE}\..."
		 * @param filepath - The file to check. "Fallout 4\Data\{ARCHIVE}\{FILEPATH}"
		 * @return true if the path contains the name of an existing file; otherwise, false.
		 */
		public static function ExistsIn(f4se:*, archive:String, filepath:String):Boolean
		{
			var name:String = Path.GetFileName(filepath);
			var folder:String = Path.GetDirectory("Data\\"+archive+"\\"+filepath);
			return F4SE.Extensions.GetDirectoryListing(f4se, folder, name, false).length == 1;
		}


	}
}
