package Shared.F4SE
{
	import Shared.AS3.Debug;

	public class FileSystemInfo
	{
		public var Name:String;
		public var Path:String;
		public var Modified:String;
		public var Created:String;
		public var IsDirectory:Boolean;
		public var IsHidden:Boolean;


		public function FileSystemInfo()
		{
			Name = "";
			Path = "";
			Modified = "";
			Created = "";
			IsDirectory = false;
			IsHidden = false;
		}


		public static function FromObject(object:*):FileSystemInfo
		{
			if (object != null)
			{
				var value:FileSystemInfo = new FileSystemInfo();
				value.Name = object.name;
				value.Path = object.nativePath;
				value.Modified = object.lastModified;
				value.Created = object.creationDate;
				value.IsDirectory = object.isDirectory;
				value.IsHidden = object.isHidden;
				return value;
			}
			else
			{
				Debug.WriteLine("[F4SE]", "FileSystemInfo", "FromObject", "The object cannot be null.");
				return null;
			}
		}


		public function toString():String
		{
			return "Name:'"+String(Name)+"', Path:'"+String(Path)+"', LastModified:'"+String(Modified)+"', CreationDate:'"+String(Created)+"', IsDirectory:"+String(IsDirectory)+", IsHidden:"+String(IsHidden)
		}


	}
}
