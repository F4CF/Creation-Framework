package System.Diagnostics
{
	public class Debug
	{
		// Configuration
		//---------------------------------------------

		/**
		 *
		 */
		public static var Prefix:String;

		/**
		 *
		 */
		public static var Enabled:Boolean = true;


		// Methods
		//---------------------------------------------

		/**
		 * Writes information about the debug to the `F4SE.log` file.
		 * The F4SE log files will be written to `...\<Documents>\My Games\Fallout4\F4SE\`.
		 * Logging from Scaleform must be enabled by adding bEnableGFXLog=1 to the [Interface] section of your F4SE.ini.
		 * Create the file `Fallout 4\Data\F4SE\F4SE.ini` if it does not exist.
		 * @param prefix - Prefixes the line with a string. The prefix will be written with wrapping brackets.
		 * If no line parameter is given, the prefix parameter will behave as the line does.
		 * @param line - The log line to write. The line will be written as-is.
		 * @param rest - Any number of additional parameters may also be provided. Each additional parameter will
		 * be converted to String and appended to the log line. The rest parameters will be written as-is.
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
