package System
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import System.Diagnostics.Debug;
	import System.Display;

	public class Display
	{
		// Stage
		public static const DefaultWidth:Number = 1280;
		public static const DefaultHeight:Number = 720;

		// Display
		//---------------------------------------------

		public static function FitToScreen(object:DisplayObject):void
		{
			ScaleToHeight(object, DefaultHeight);
		}


		public static function ScaleToHeight(object:DisplayObject, height:Number):void
		{
			Debug.WriteLine("[System.Display]", "ScaleToHeight", "object="+object+", height="+height);
			object.height = height;
			object.scaleX = object.scaleY;
		}


		public static function CenterOnStage(object:DisplayObject):void
		{
			object.x = (object.stage.width - object.width) / 2;
			object.y = (object.stage.height - object.height) / 2;
			Debug.WriteLine("[System.Display]", "CenterOnStage", "object.x="+object.x+", object.y="+object.y);
		}


		// Instance
		//---------------------------------------------

		public static function GetInstance(object:DisplayObject):String
		{
			return GetInstanceFrom(object, object);
		}

		// TODO: Incorrectly prefixes some display objects.
		public static function GetInstanceFrom(from:DisplayObject, to:DisplayObject):String
		{
			var path:String = from.name;
			while (from != to.root)
			{
				from = from.parent;
				path = from.name+"."+path;
			};
			return "stage."+path;
		}


	}
}
