package Shared.AS3
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import Shared.AS3.Debug;

	/**
	 * Exposes static methods for working with directories.
	 */
	public class Directory
	{

		public static function GetTextureExists(f4se:*, filepath:String):Boolean
		{
			var folder:String = Path.GetDirectory("Data\\Textures\\"+filepath);
			return F4SE.Extensions.GetDirectoryListing(f4se, folder, "*.dds", true).length > 0;
		}

	}
}
