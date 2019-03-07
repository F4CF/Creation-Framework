package System.IO
{
	import System.Diagnostics.Debug;

	/**
	 * Performs operations on String instances that contain file or directory path information.
	 *
	 * https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/String.html
	 */
	public class Path
	{

		/**
		 * Changes the extension of a path string.
		 * @param path - The path information to modify. The path cannot contain any of the characters defined in GetInvalidPathChars().
		 * @param extension - The new extension (with or without a leading period). Specify null to remove an existing extension from path.
		 * @return String - The modified path information.
		 */
		public static function ChangeExtension(path:String, extension:String):String
		{
			var expression:RegExp = new RegExp("\\.[^/.]+$", "");
			if (extension == null)
			{
				return path.replace(expression, "");
			}
			else
			{
				if (extension.indexOf(".") > 0)
				{
					return path.replace(expression, extension);
				}
				else
				{
					return path.replace(expression, "."+extension);
				}
			}
		}


		/**
		 * Returns the extension of the specified path string.
		 * @param path - The path string from which to get the extension.
		 * @return String - The extension of the specified path (including the period "."), or null, or Empty.
		 * 	* If path is null, GetExtension(String) returns null.
		 * 	* If path does not have extension information, GetExtension(String) returns Empty.
		 */
		public static function GetExtension(path:String):String
		{
			if (path == null)
			{
				return null;
			}
			else
			{
				return path.substring(path.lastIndexOf(".") + 1, path.length);
			}
		}


		/**
		 * Gets the file name and extension.
		 * @param fullPath -
		 * @return String -
		 */
		public static function GetFileName(fullPath:String):String
		{
			var fSlash:int = fullPath.lastIndexOf("/");
			var bSlash:int = fullPath.lastIndexOf("\\");
			var index:int = fSlash > bSlash ? fSlash : bSlash;
			return fullPath.substr(index + 1);
		}


		/**
		 *
		 * @param path -
		 * @return String -
		 */
		public static function GetDirectory(path:String):String
		{
			var fSlash:int = path.lastIndexOf("/");
			var bSlash:int = path.lastIndexOf("\\");
			var index:int = fSlash > bSlash ? fSlash : bSlash;
			return path.substring(0, index);
		}


		/**
		 * Gets an array containing the characters that are not allowed in path names.
		 *
		 * The following characters are invalid in a path:
		 * Char    Hex Value
		 * ",      0022
		 * <,      003C
		 * >,      003E
		 * |,      007C
		 *
		 * @param path -
		 * @return ???? -
		 */
		public static function GetInvalidPathChars():Array
		{
			return [',', '<', '>', '|'];
		}


		/**
		 * Gets an array containing the characters that are not allowed in path names.
		 *
		 * The following characters are invalid in a filename:
		 * Char    Hex Value
		 * ",      0022
		 * <,      003C
		 * >,      003E
		 * |,      007C
		 *
		 * @param path -
		 * @return ???? -
		 */
		public static function GetInvalidFileNameChars():Array
		{
			return [',', '<', '>', '|'];
		}


		// public static function HasInvalidPathChars(path:String):Boolean
		// public static function RemoveInvalidPathChars(path:String):String


	}
}
