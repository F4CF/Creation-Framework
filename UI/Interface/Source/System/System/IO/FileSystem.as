package System.IO
{
	import F4SE.Extensions;
	import System.Diagnostics.Debug;

	public class FileSystem
	{
		/** Constant value used for loading an image based on the url protocol string.*/
		public static const ImageProtocol:String = "img://";


		// Archives
		public static const Interface:String = "Interface";
		public static const Meshes:String = "Meshes";
		public static const Textures:String = "Textures";
		public static const Materials:String = "Materials";


		/**
		 *
		 * @param path - The file or directory path to list.
		 * @param match -
		 * @param recursive -
		 * @return Vector.<FileSystemInfo> - ???
		 */
		public static function GetListing(path:String, match:String, recursive:Boolean=false):Vector.<FileSystemInfo>
		{
			if (F4SE.Extensions.API != null)
			{
				var array:Array = F4SE.Extensions.GetDirectoryListing(path, match, recursive);
				if (array != null)
				{
					if(array.length > 0)
					{
						var files:Vector.<FileSystemInfo> = new Vector.<FileSystemInfo>();
						for each(var element:* in array)
						{
							files.push(FileSystemInfo.FromObject(element));
						}
						return files;
					}
					else
					{
						Debug.WriteLine("[System.IO.FileSystem]", "GetListing", "No files or folders were found.", "path:'"+path+"'", "match:'"+match+"'", "recursive:'"+recursive+"'");
						return null;
					}
				}
				else
				{
					Debug.WriteLine("[System.IO.FileSystem]", "GetListing", "The array cannot be null.");
					return null;
				}
			}
			else
			{
				Debug.WriteLine("[System.IO.FileSystem]", "GetListing", "The F4SE object cannot be null.");
				return null;
			}
		}


	}
}
