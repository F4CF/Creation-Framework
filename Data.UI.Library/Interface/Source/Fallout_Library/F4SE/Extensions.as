package F4SE
{
	import System.Diagnostics.Debug;

	/**
	 * Exposes the F4SE code object's methods and data.
	 * https://www.creationkit.com/fallout4/index.php?title=Category:F4SE
	 * TODO: Check for null arguments on f4se function calls. A null parameter may crash the game!
	 * TODO: Add boolean return values for functions.
	 */
	public class Extensions
	{

		/**
		 * Gets an object representing the running version of F4SE.
		 * @param f4se - The F4SE `code` object to use.
		 * @return Object - The F4SE `version` object.
		 */
		public static function GetVersion(f4se:*):Object
		{
			if (f4se != null)
			{
				if (f4se.version != null)
				{
					return f4se.version;
				}
				else
				{
					Debug.WriteLine("[F4SE.Extensions]", "(GetVersion)", "f4se.version", "The 'f4se.version' object cannot be null.");
					return null;
				}
			}
			else
			{
				Debug.WriteLine("[F4SE.Extensions]", "(GetVersion)", "f4se", "The 'f4se' object cannot be null.");
				return null;
			}
		}


		/**
		 * Gets an array of objects representing `FileSystemInfo` objects for the given path.
		 * @param f4se - The F4SE `code` object to use.
		 * @param path - The directory to search within. Searches the top level folder only.
		 * @param match - Filters the listing using a string pattern. The pattern accepts a wildcard expression (*).
		 * @param recursive - Searches any child directories as well.
		 * @return Array - An array of F4SE `FileSystemInfo` objects.
		 */
		public static function GetDirectoryListing(f4se:*, path:String, match:String, recursive:Boolean=false):Array
		{
			if (f4se != null)
			{
				var array:Array;
				try
				{
					array = f4se.GetDirectoryListing(path, match, recursive);
				}
				catch (error:Error)
				{
					Debug.WriteLine("[F4SE.Extensions]", "(GetDirectoryListing)", "ERROR:", error.toString());
				}
				return array;
			}
			else
			{
				Debug.WriteLine("[F4SE.Extensions]", "(GetDirectoryListing)", "The f4se object cannot be null.");
				return null;
			}
		}


		/**
		 * Mounts a texture to the given menu.
		 * @param f4se - The F4SE `code` object to use.
		 * @param menuName - The name of a menu the texture will be mounted to.
		 * @param mountPath - The file path to a texture that will be mounted.
		 * @param mountName - A unique identifier for this texture mount.
		 */
		public static function MountImage(f4se:*, menuName:String, mountPath:String, mountName:String):void
		{
			if (f4se != null)
			{
				Debug.WriteLine("[F4SE.Extensions]", "(MountImage)", menuName, mountPath, mountName);
				try
				{
					f4se.MountImage(menuName, mountPath, mountName);
				}
				catch (error:Error)
				{
					Debug.WriteLine("[F4SE.Extensions]", "(MountImage)", "ERROR:", error.toString());
				}
			}
			else
			{
				Debug.WriteLine("[F4SE.Extensions]", "(MountImage)", "The f4se object cannot be null.");
			}
		}


		/**
		 * Unmounts a texture from the given menu.
		 * @param f4se - The F4SE `code` object to use.
		 * @param menuName - The name of a menu the texture will be unmounted from.
		 * @param mountPath - The file path to a texture that will be unmounted.
		 */
		public static function UnmountImage(f4se:*, menuName:String, mountPath:String):void
		{
			if (f4se != null)
			{
				try
				{
					Debug.WriteLine("[F4SE.Extensions]", "(UnmountImage)", menuName, mountPath);
					f4se.UnmountImage(menuName, mountPath);
				}
				catch (error:Error)
				{
					Debug.WriteLine("[F4SE.Extensions]", "(UnmountImage)", "ERROR:", error.toString());
				}
			}
			else
			{
				Debug.WriteLine("[F4SE.Extensions]", "(UnmountImage)", "The f4se object cannot be null.");
			}
		}


		// /**
		//  *
		//  * @param f4se - The F4SE `code` object to use.
		//  */
		// public static function GetMembers(f4se:*):void
		// {
		// 	if (f4se != null)
		// 	{
		// 		trace("derpy GetMembers");
		// 	}
		// 	else
		// 	{
		// 		Debug.WriteLine("[F4SE.Extensions]", "GetMembers", "The f4se object cannot be null.");
		// 	}
		// }


		// /**
		//  *
		//  * @param f4se - The F4SE `code` object to use.
		//  */
		// public static function CallFunctionNoWait(f4se:*):void
		// {
		// 	if (f4se != null)
		// 	{
		// 		trace("derpy CallFunctionNoWait");
		// 	}
		// 	else
		// 	{
		// 		Debug.WriteLine("[F4SE.Extensions]", "CallFunctionNoWait", "The f4se object cannot be null.");
		// 	}
		// }


		// /**
		//  *
		//  * @param f4se - The F4SE `code` object to use.
		//  */
		// public static function AllowTextInput(f4se:*):void
		// {
		// 	if (f4se != null)
		// 	{
		// 		trace("derpy AllowTextInput");
		// 	}
		// 	else
		// 	{
		// 		Debug.WriteLine("[F4SE.Extensions]", "AllowTextInput", "The f4se object cannot be null.");
		// 	}
		// }


		// /**
		//  *
		//  * @param f4se - The F4SE `code` object to use.
		//  */
		// public static function SendExternalEvent(f4se:*):void
		// {
		// 	if (f4se != null)
		// 	{
		// 		trace("derpy SendExternalEvent");
		// 	}
		// 	else
		// 	{
		// 		Debug.WriteLine("[F4SE.Extensions]", "SendExternalEvent", "The f4se object cannot be null.");
		// 	}
		// }


		// /**
		//  *
		//  * @param f4se - The F4SE `code` object to use.
		//  */
		// public static function GetPlugins(f4se:*):void
		// {
		// 	if (f4se != null)
		// 	{
		// 		trace("derpy GetPlugins");
		// 	}
		// 	else
		// 	{
		// 		Debug.WriteLine("[F4SE.Extensions]", "GetPlugins", "The f4se object cannot be null.");
		// 	}
		// }

	}
}
