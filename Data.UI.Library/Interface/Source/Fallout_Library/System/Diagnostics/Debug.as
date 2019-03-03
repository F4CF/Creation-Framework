package System.Diagnostics
{
	public class Debug
	{

		public static function WriteLine(prefix:Object, line:Object="", ... rest):void
		{
			if (rest != null)
			{
				for (var index:uint = 0; index < rest.length; index++)
				{
					line += " "+rest[index];
				}
			}
			trace(prefix+" "+line);
		}

	}
}
