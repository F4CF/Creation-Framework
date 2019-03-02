package Shared.F4SE
{
	import Shared.AS3.Debug;

	// TODO: Check for null arguments on f4se function calls. A null parameter may crash the game!
	public class Extensions
	{

		public static function GetDirectoryListing(f4se:*, path:String, match:String, recursive:Boolean=false):Vector.<FileSystemInfo>
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
					Debug.WriteLine("[F4SE]", "Extensions", "GetDirectoryListing", "ERROR:", error.toString());
				}
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
					Debug.WriteLine("[F4SE]", "Extensions", "GetDirectoryListing", "No files or folders were found.", "path:'"+path+"'", "match:'"+match+"'", "recursive:'"+recursive+"'");
					return null;
				}
			}
			else
			{
				Debug.WriteLine("[F4SE]", "Extensions", "GetDirectoryListing", "The f4se object cannot be null.");
				return null;
			}
		}


		public static function MountImage(f4se:*, menuName:String, mountPath:String, mountName:String):void
		{
			if (f4se != null)
			{
				Debug.WriteLine("[F4SE]", "[Extensions]", "(MountImage)", menuName, mountPath, mountName);
				try
				{
					f4se.MountImage(menuName, mountPath, mountName);
				}
				catch (error:Error)
				{
					Debug.WriteLine("[F4SE]", "Extensions", "MountImage", "ERROR:", error.toString());
				}
			}
			else
			{
				Debug.WriteLine("[F4SE]", "Extensions", "MountImage", "The f4se object cannot be null.");
			}
		}


		public static function UnmountImage(f4se:*, menuName:String, mountPath:String):void
		{
			if (f4se != null)
			{
				try
				{
					Debug.WriteLine("[F4SE]", "[Extensions]", "(UnmountImage)", menuName, mountPath);
					f4se.UnmountImage(menuName, mountPath);
				}
				catch (error:Error)
				{
					Debug.WriteLine("[F4SE]", "Extensions", "UnmountImage", "ERROR:", error.toString());
				}
			}
			else
			{
				Debug.WriteLine("[F4SE]", "Extensions", "UnmountImage", "The f4se object cannot be null.");
			}
		}


		public static function GetVersion(f4se:*):Version
		{
			if (f4se != null)
			{
				if (f4se.version != null)
				{
					var value:Version = Version.FromObject(f4se.version);
					Debug.WriteLine("[F4SE]", "Extensions", "GetVersion", "value:", value.toString());
					return value;
				}
				else
				{
					Debug.WriteLine("[F4SE]", "Extensions", "GetVersion", "f4se.version", "The 'f4se.version' object cannot be null.");
					return new Version();
				}
			}
			else
			{
				Debug.WriteLine("[F4SE]", "Extensions", "GetVersion", "f4se", "The 'f4se' object cannot be null.");
				return new Version();
			}
		}


		// public static function GetMembers(f4se:*):void
		// {
		// 	if (f4se != null)
		// 	{
		// 		trace("derpy GetMembers");
		// 	}
		// 	else
		// 	{
		// 		Debug.WriteLine("[F4SE]", "Extensions", "GetMembers", "The f4se object cannot be null.");
		// 	}
		// }


		// public static function CallFunctionNoWait(f4se:*):void
		// {
		// 	if (f4se != null)
		// 	{
		// 		trace("derpy CallFunctionNoWait");
		// 	}
		// 	else
		// 	{
		// 		Debug.WriteLine("[F4SE]", "Extensions", "CallFunctionNoWait", "The f4se object cannot be null.");
		// 	}
		// }


		// public static function AllowTextInput(f4se:*):void
		// {
		// 	if (f4se != null)
		// 	{
		// 		trace("derpy AllowTextInput");
		// 	}
		// 	else
		// 	{
		// 		Debug.WriteLine("[F4SE]", "Extensions", "AllowTextInput", "The f4se object cannot be null.");
		// 	}
		// }


		// public static function SendExternalEvent(f4se:*):void
		// {
		// 	if (f4se != null)
		// 	{
		// 		trace("derpy SendExternalEvent");
		// 	}
		// 	else
		// 	{
		// 		Debug.WriteLine("[F4SE]", "Extensions", "SendExternalEvent", "The f4se object cannot be null.");
		// 	}
		// }


		// public static function GetPlugins(f4se:*):void
		// {
		// 	if (f4se != null)
		// 	{
		// 		trace("derpy GetPlugins");
		// 	}
		// 	else
		// 	{
		// 		Debug.WriteLine("[F4SE]", "Extensions", "GetPlugins", "The f4se object cannot be null.");
		// 	}
		// }

	}
}
