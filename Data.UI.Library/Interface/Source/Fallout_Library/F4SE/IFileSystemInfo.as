package F4SE
{
	public interface IFileSystemInfo
	{
		function get Name():String;
		function get Path():String;
		function get Modified():String;
		function get Created():String;
		function get IsDirectory():Boolean;
		function get IsHidden():Boolean;
	}
}
