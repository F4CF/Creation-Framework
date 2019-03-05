package System.IO
{
	import F4SE.Extensions;
	import System.Diagnostics.Debug;

	public class FileSystem
	{
		// Archives
		public static const Interface:String = "Interface";
		public static const Meshes:String = "Meshes";
		public static const Textures:String = "Textures";
		public static const Materials:String = "Materials";


		/**
		 *
		 * @param f4se - The F4SE code object.
		 * @param path -
		 * @param match -
		 * @param recursive -
		 * @return Vector.<FileSystemInfo> - ???
		 */
		public static function GetListing(f4se:*, path:String, match:String, recursive:Boolean=false):Vector.<FileSystemInfo>
		{
			if (f4se != null)
			{
				var array:Array = F4SE.Extensions.GetDirectoryListing(f4se, path, match, recursive);
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
				Debug.WriteLine("[System.IO.FileSystem]", "GetListing", "The f4se object cannot be null.");
				return null;
			}
		}


	}
}
