package Shared.F4SE
{
	public class Version
	{
		public var major:Number;
		public var minor:Number;
		public var beta:Number;
		public var releaseIdx:Number;


		public function Version()
		{
			major = 0;
			minor = 0;
			beta = 0;
			releaseIdx = 0;
		}


		public static function FromObject(object:*):Version
		{
			if (object != null)
			{
				var value:Version = new Version();
				value.major = object.major;
				value.minor = object.minor;
				value.beta = object.beta;
				value.releaseIdx = object.releaseIdx;
				return value;
			}
			else
			{
				AS3.Debug.WriteLine("[F4SE]", "Version", "FromObject", "The object cannot be null.");
				return null;
			}
		}


		public function toString():String
		{
			return String(major)+"."+String(minor)+"."+String(beta)+"."+String(releaseIdx);
		}

	}
}
