package System.Diagnostics
{
	/**
	 * Provides a set of methods and properties that help debug your code.
	 */
	public class Debug
	{
		// Fields
		//---------------------------------------------

		/**
		 * Prefixes all logged lines with a string. The prefix will be written within wrapping brackets.
		 * @example This value may be set so callers can be identified within the log file.
		 * A sensible value would be your project's name, for example "Immersive Logging".
		 * The log line would be written as `[Immersive Logging] Hello World!`.
		 * By default, a log line will be written as `[Library] Hello World!`.
		 */
		public static var Prefix:String = "Library";

		/**
		 * Enables or disables logging.
		 */
		public static var Enabled:Boolean = true;


		// Methods
		//---------------------------------------------

		/**
		 * Writes information about the debug to the `F4SE.log` file.
		 * The F4SE log files will be written to `...\<Documents>\My Games\Fallout4\F4SE\`.
		 * Logging from Scaleform must be enabled by adding bEnableGFXLog=1 to the [Interface] section of your F4SE.ini.
		 * Create the file `Fallout 4\Data\F4SE\F4SE.ini` if it does not exist.
		 * @param prefix - Prefixes the log line with a string. The prefix will be written within wrapping brackets.
		 * If no `line` parameter is given, the `prefix` parameter will behave as `line` does.
		 * @param line - The log line to write. The `line` parameter will be written as-is.
		 * @param rest - Any number of additional parameters may also be provided. Each additional parameter will
		 * be converted to String and appended to the log line. The `rest` parameters will be written as-is.
		 * @see https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/package.html#trace()
		 * @see https://www.creationkit.com/fallout4/index.php?title=Category:F4SE#Logging
		 */
		public static function WriteLine(prefix:Object, line:Object="", ... rest):void
		{
			if (!Enabled) { return; }
			if (rest != null)
			{
				for (var index:uint = 0; index < rest.length; index++)
				{
					line += " "+rest[index];
				}
			}
			if (Prefix != null)
			{
				trace("["+Prefix+"]"+prefix+" "+line);
			}
			else
			{
				trace(prefix+" "+line);
			}
		}


	}
}
