package System
{ // TODO: F4SE stuff should be moved to `System.XSE`.
	import F4SE.IVersion;
	import System.Diagnostics.Debug;

	public class Version implements IVersion
	{
		private var major:Number;
		public function get Major():Number { return major; }
		public function set Major(value:Number):void { major = value; }

		private var minor:Number;
		public function get Minor():Number { return minor; }
		public function set Minor(value:Number):void { minor = value; }

		private var beta:Number;
		public function get Beta():Number { return beta; }
		public function set Beta(value:Number):void { beta = value; }

		private var releaseIndex:Number;
		public function get ReleaseIndex():Number { return releaseIndex; }
		public function set ReleaseIndex(value:Number):void { releaseIndex = value; }


		public function Version()
		{
			major = 0;
			minor = 0;
			beta = 0;
			releaseIndex = 0;
		}


		/**
		 * Converts F4SE version data into a Version type.
		* @param object - The F4SE version data to convert.
		* @return Version - The converted Version type, else, return null.
		 */
		public static function FromObject(object:*):Version
		{
			if (object != null)
			{
				var value:Version = new Version();
				value.Major = object.major;
				value.Minor = object.minor;
				value.Beta = object.beta;
				value.ReleaseIndex = object.releaseIdx;
				return value;
			}
			else
			{
				Debug.WriteLine("[System]", "Version", "FromObject", "The F4SE code object cannot be null.");
				return null;
			}
		}


		/**
		 *
		 * @param f4se - The F4SE code object.
		 * @return Version - The converted Version object, else, return null.
		 */
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


		public function toString():String
		{
			return String(major)+"."+String(minor)+"."+String(beta)+"."+String(releaseIndex);
		}


	}
}
