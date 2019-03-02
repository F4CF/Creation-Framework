package Shared.AS3
{
	public class Path
	{
		public static function ConvertFileExtension(filepath:String, toExtension:String):String
		{
			return filepath.replace(new RegExp("\\.[^/.]+$", ""), "."+toExtension);
		}


		public static function GetFileExtension(filepath:String):String
		{
			return filepath.substring(filepath.lastIndexOf(".")+1, filepath.length);
		}


		public static function GetFileName(fullPath:String):String
		{
			var fSlash:int = fullPath.lastIndexOf("/");
			var bSlash:int = fullPath.lastIndexOf("\\");
			var index:int = fSlash > bSlash ? fSlash : bSlash;
			return fullPath.substr(index + 1);
		}


		public static function GetDirectory(path:String):String
		{
			var fSlash:int = path.lastIndexOf("/");
			var bSlash:int = path.lastIndexOf("\\");
			var index:int = fSlash > bSlash ? fSlash : bSlash;
			return path.substring(0, index);
		}


	}
}
