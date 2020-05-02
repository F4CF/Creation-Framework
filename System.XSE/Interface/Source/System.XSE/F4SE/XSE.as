package F4SE
{
	import System.Diagnostics.Debug;

	/**
	 * Exposes the F4SE code object's methods and data.
	 * https://www.creationkit.com/fallout4/index.php?title=Category:F4SE
	 */
	public class XSE
	{
		/** The F4SE API code object to use. */
		public static var API:*;


		/**
		 * Gets an object representing the running version of F4SE.
		 * @return Object - The F4SE 'version' object.
		 */
		public static function GetVersion():Object
		{
			if (API != null)
			{
				if (API.version != null)
				{
					return API.version;
				}
				else
				{
					Debug.WriteLine("[F4SE.XSE]", "(GetVersion)", "API.version", "The 'API.version' object cannot be null.");
					return null;
				}
			}
			else
			{
				Debug.WriteLine("[F4SE.XSE]", "(GetVersion)", "API", "The 'API' object cannot be null.");
				return null;
			}
		}


		// TODO: See if generic event arguments are allowed. First argument is strongly typed to String.
		public static function SendExternalEvent(eventName:String, ... arguments):Boolean
		{
			if (API != null)
			{
				if (eventName != null)
				{
					var success:Boolean = true;
					try
					{
						switch (arguments.length)
						{
							case 0: API.SendExternalEvent(eventName); break;
							case 1: API.SendExternalEvent(eventName, arguments[0]); break;
							case 2: API.SendExternalEvent(eventName, arguments[0], arguments[1]); break;
							case 3: API.SendExternalEvent(eventName, arguments[0], arguments[1], arguments[2]); break;
							case 4: API.SendExternalEvent(eventName, arguments[0], arguments[1], arguments[2], arguments[3]); break;
							case 5: API.SendExternalEvent(eventName, arguments[0], arguments[1], arguments[2], arguments[3], arguments[4]); break;
							case 6: API.SendExternalEvent(eventName, arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5]); break;
							case 7: API.SendExternalEvent(eventName, arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6]); break;
							case 8: API.SendExternalEvent(eventName, arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7]); break;
							case 9: API.SendExternalEvent(eventName, arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7], arguments[8]); break;
						}
					}
					catch (error:Error)
					{
						Debug.WriteLine("[F4SE.XSE]", "(SendExternalEvent)", "ERROR: ", error.toString());
						success = false;
					}
					return success;
				}
				else
				{
					Debug.WriteLine("[F4SE.XSE]", "(SendExternalEvent)", "eventName", "The 'eventName' cannot be null.");
					return false;
				}
			}
			else
			{
				Debug.WriteLine("[F4SE.XSE]", "(SendExternalEvent)", "API", "The 'API' object cannot be null.");
				return false;
			}
		}


		public static function CallFunctionNoWait(receiver:Object, functionName:String, ... arguments):Boolean
		{
			if (API != null)
			{
				if (receiver != null)
				{
					if (!receiver.hasOwnProperty("__type__"))
					{
						Debug.WriteLine("[F4SE.XSE]", "(CallFunctionNoWait)", "receiver", "The 'receiver' object must have the '__type__' property.");
						return false;
					}
					else if (!receiver.hasOwnProperty("__handleHigh__"))
					{
						Debug.WriteLine("[F4SE.XSE]", "(CallFunctionNoWait)", "receiver", "The 'receiver' object must have the '__handleHigh__' property.");
						return false;
					}
					else if (!receiver.hasOwnProperty("__handleLow__"))
					{
						Debug.WriteLine("[F4SE.XSE]", "(CallFunctionNoWait)", "receiver", "The 'receiver' object must have the '__handleLow__' property.");
						return false;
					}
					else
					{
						if (functionName != null)
						{
							var success:Boolean = true;
							try
							{
								switch (arguments.length)
								{
									case 0: API.CallFunctionNoWait(receiver, functionName); break;
									case 1: API.CallFunctionNoWait(receiver, functionName, arguments[0]); break;
									case 2: API.CallFunctionNoWait(receiver, functionName, arguments[0], arguments[1]); break;
									case 3: API.CallFunctionNoWait(receiver, functionName, arguments[0], arguments[1], arguments[2]); break;
									case 4: API.CallFunctionNoWait(receiver, functionName, arguments[0], arguments[1], arguments[2], arguments[3]); break;
									case 5: API.CallFunctionNoWait(receiver, functionName, arguments[0], arguments[1], arguments[2], arguments[3], arguments[4]); break;
									case 6: API.CallFunctionNoWait(receiver, functionName, arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5]); break;
									case 7: API.CallFunctionNoWait(receiver, functionName, arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6]); break;
									case 8: API.CallFunctionNoWait(receiver, functionName, arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7]); break;
									case 9: API.CallFunctionNoWait(receiver, functionName, arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7], arguments[8]); break;
								}
							}
							catch (error:Error)
							{
								Debug.WriteLine("[F4SE.XSE]", "(CallFunctionNoWait)", "ERROR: ", error.toString());
								success = false;
							}
							return success;
						}
						else
						{
							Debug.WriteLine("[F4SE.XSE]", "(CallFunctionNoWait)", "functionName", "The 'functionName' cannot be null.");
							return false;
						}
					}
				}
				else
				{
					Debug.WriteLine("[F4SE.XSE]", "(CallFunctionNoWait)", "receiver", "The 'receiver' object cannot be null.");
					return false;
				}
			}
			else
			{
				Debug.WriteLine("[F4SE.XSE]", "(CallFunctionNoWait)", "API", "The 'API' object cannot be null.");
				return false;
			}
		}


		public static function CallGlobalFunctionNoWait(className:String, functionName:String, ... arguments):Boolean
		{
			if (API != null)
			{
				if (className != null)
				{
					if (functionName != null)
					{
						var success:Boolean = true;
						try
						{
							switch (arguments.length)
							{
								case 0: API.CallGlobalFunctionNoWait(className, functionName); break;
								case 1: API.CallGlobalFunctionNoWait(className, functionName, arguments[0]); break;
								case 2: API.CallGlobalFunctionNoWait(className, functionName, arguments[0], arguments[1]); break;
								case 3: API.CallGlobalFunctionNoWait(className, functionName, arguments[0], arguments[1], arguments[2]); break;
								case 4: API.CallGlobalFunctionNoWait(className, functionName, arguments[0], arguments[1], arguments[2], arguments[3]); break;
								case 5: API.CallGlobalFunctionNoWait(className, functionName, arguments[0], arguments[1], arguments[2], arguments[3], arguments[4]); break;
								case 6: API.CallGlobalFunctionNoWait(className, functionName, arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5]); break;
								case 7: API.CallGlobalFunctionNoWait(className, functionName, arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6]); break;
								case 8: API.CallGlobalFunctionNoWait(className, functionName, arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7]); break;
								case 9: API.CallGlobalFunctionNoWait(className, functionName, arguments[0], arguments[1], arguments[2], arguments[3], arguments[4], arguments[5], arguments[6], arguments[7], arguments[8]); break;
							}
						}
						catch (error:Error)
						{
							Debug.WriteLine("[F4SE.XSE]", "(CallGlobalFunctionNoWait)", "ERROR: ", error.toString());
							success = false;
						}
						return success;
					}
					else
					{
						Debug.WriteLine("[F4SE.XSE]", "(CallGlobalFunctionNoWait)", "functionName", "The 'functionName' cannot be null.");
						return false;
					}
				}
				else
				{
					Debug.WriteLine("[F4SE.XSE]", "(CallGlobalFunctionNoWait)", "className", "The 'className' cannot be null.");
					return false;
				}
			}
			else
			{
				Debug.WriteLine("[F4SE.XSE]", "(CallGlobalFunctionNoWait)", "API", "The 'API' object cannot be null.");
				return false;
			}
		}


		/**
		 * Gets an array of objects representing 'FileSystemInfo' objects for the given path.
		 * @param path - The directory to search within. Searches the top level folder only.
		 * @param match - Filters the listing using a string pattern. The pattern accepts a wildcard expression (*).
		 * @param recursive - Searches any child directories as well.
		 * @return Array - An array of F4SE file system info objects.
		 */
		public static function GetDirectoryListing(path:String, match:String, recursive:Boolean=false):Array
		{
			if (API != null)
			{
				var array:Array;
				try
				{
					array = API.GetDirectoryListing(path, match, recursive);
				}
				catch (error:Error)
				{
					Debug.WriteLine("[F4SE.XSE]", "(GetDirectoryListing)", "ERROR: ", error.toString());
				}
				return array;
			}
			else
			{
				Debug.WriteLine("[F4SE.XSE]", "(GetDirectoryListing)", "The API object cannot be null.");
				return null;
			}
		}


		/**
		 * Mounts a texture to the given menu.
		 * @param menuName - The name of a menu the texture will be mounted to.
		 * @param mountPath - The file path to a texture that will be mounted.
		 * @param mountName - A unique identifier for this texture mount.
		 */
		public static function MountImage(menuName:String, mountPath:String, mountName:String):Boolean
		{
			if (API != null)
			{
				Debug.WriteLine("[F4SE.XSE]", "(MountImage)", menuName, mountPath, mountName);
				var success:Boolean = true;
				try
				{
					API.MountImage(menuName, mountPath, mountName);
				}
				catch (error:Error)
				{
					Debug.WriteLine("[F4SE.XSE]", "(MountImage)", "ERROR: ", error.toString());
					success = false;
				}
				return success;
			}
			else
			{
				Debug.WriteLine("[F4SE.XSE]", "(MountImage)", "The API object cannot be null.");
				return false;
			}
		}


		/**
		 * Unmounts a texture from the given menu.
		 * @param menuName - The name of a menu the texture will be unmounted from.
		 * @param mountPath - The file path to a texture that will be unmounted.
		 */
		public static function UnmountImage(menuName:String, mountPath:String):Boolean
		{
			if (API != null)
			{
				var success:Boolean = true;
				try
				{
					Debug.WriteLine("[F4SE.XSE]", "(UnmountImage)", menuName, mountPath);
					API.UnmountImage(menuName, mountPath);
				}
				catch (error:Error)
				{
					Debug.WriteLine("[F4SE.XSE]", "(UnmountImage)", "ERROR: ", error.toString());
					success = false;
				}
				return success;
			}
			else
			{
				Debug.WriteLine("[F4SE.XSE]", "(UnmountImage)", "The API object cannot be null.");
				return false;
			}
		}


		// /**
		//  *
		//  * @param API - The F4SE 'code' object to use.
		//  */
		// public static function GetMembers(API:*):void
		// {
		// 	if (API != null)
		// 	{
		// 		trace("derpy GetMembers");
		// 	}
		// 	else
		// 	{
		// 		Debug.WriteLine("[F4SE.XSE]", "GetMembers", "The API object cannot be null.");
		// 	}
		// }


		// /**
		//  *
		//  * @param API - The F4SE 'code' object to use.
		//  */
		// public static function CallFunctionNoWait(API:*):void
		// {
		// 	if (API != null)
		// 	{
		// 		trace("derpy CallFunctionNoWait");
		// 	}
		// 	else
		// 	{
		// 		Debug.WriteLine("[F4SE.XSE]", "CallFunctionNoWait", "The API object cannot be null.");
		// 	}
		// }


		// /**
		//  *
		//  * @param API - The F4SE 'code' object to use.
		//  */
		// public static function AllowTextInput(API:*):void
		// {
		// 	if (API != null)
		// 	{
		// 		trace("derpy AllowTextInput");
		// 	}
		// 	else
		// 	{
		// 		Debug.WriteLine("[F4SE.XSE]", "AllowTextInput", "The API object cannot be null.");
		// 	}
		// }


		// /**
		//  *
		//  * @param API - The F4SE 'code' object to use.
		//  */
		// public static function GetPlugins(API:*):void
		// {
		// 	if (API != null)
		// 	{
		// 		trace("derpy GetPlugins");
		// 	}
		// 	else
		// 	{
		// 		Debug.WriteLine("[F4SE.XSE]", "GetPlugins", "The API object cannot be null.");
		// 	}
		// }

	}
}
