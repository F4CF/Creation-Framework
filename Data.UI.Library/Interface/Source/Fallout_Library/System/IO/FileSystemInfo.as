package System.IO
{
	import F4SE.IFileSystemInfo;
	import System.Diagnostics.Debug;

	/**
	 * Provides the base class for both files and directories.
	 * TODO: Perhaps I should make this immutable (?).
	 */
	public class FileSystemInfo implements IFileSystemInfo
	{
		private var name:String;
		public function get Name():String { return name; }
		public function set Name(value:String):void { name = value; }

		private var path:String;
		public function get Path():String { return path; }
		public function set Path(value:String):void { path = value; }

		private var modified:String;
		public function get Modified():String { return modified; }
		public function set Modified(value:String):void { modified = value; }

		private var created:String;
		public function get Created():String { return created; }
		public function set Created(value:String):void { created = value; }

		private var isDirectory:Boolean;
		public function get IsDirectory():Boolean { return isDirectory; }
		public function set IsDirectory(value:Boolean):void { isDirectory = value; }

		private var isHidden:Boolean;
		public function get IsHidden():Boolean { return isHidden; }
		public function set IsHidden(value:Boolean):void { isHidden = value; }


		public function FileSystemInfo()
		{
			name = "";
			path = "";
			modified = "";
			created = "";
			isDirectory = false;
			isHidden = false;
		}


		public static function FromObject(object:*):FileSystemInfo
		{
			if (object != null)
			{ // @F4SE
				var value:FileSystemInfo = new FileSystemInfo();
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
				Debug.WriteLine("[System.IO]", "FileSystemInfo", "FromObject", "The F4SE code object cannot be null.");
				return null;
			}
		}


		public function toString():String
		{
			return "Name:'"+String(name)+"', Path:'"+String(path)+"', LastModified:'"+String(modified)+"', CreationDate:'"+String(created)+"', IsDirectory:"+String(isDirectory)+", IsHidden:"+String(isHidden);
		}


	}
}
