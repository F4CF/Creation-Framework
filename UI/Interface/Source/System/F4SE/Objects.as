package F4SE
{
	import System.Diagnostics.Debug;

	/**
	 *
	 */
	public class Objects
	{

		public static function ToVersion(object:*):IVersion
		{
			if (object != null)
			{
				var value:IVersion = new IVersion();
				value.Major = object.major;
				value.Minor = object.minor;
				value.Beta = object.beta;
				value.ReleaseIndex = object.releaseIdx;
				return value;
			}
			else
			{
				Debug.WriteLine("[F4SE]", "Objects", "ToVersion", "The F4SE `version` object cannot be null.");
				return null;
			}
		}


		public static function ToFileSystemInfo(object:*):IFileSystemInfo
		{
			if (object != null)
			{
				var value:IFileSystemInfo = new IFileSystemInfo();
				value.name = object.name;
				value.path = object.nativePath;
				value.modified = object.lastModified;
				value.created = object.creationDate;
				value.isDirectory = object.isDirectory;
				value.isHidden = object.isHidden;
				return value;
			}
			else
			{
				Debug.WriteLine("[F4SE]", "Objects", "ToFileSystemInfo", "The F4SE `fileSystemInfo` object cannot be null.");
				return null;
			}
		}


	}
}
