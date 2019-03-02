package Shared.AS3
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	public class Utility
	{

		// Instance
		//---------------------------------------------

		public static function WalkMovie(object:DisplayObject):String
		{
			return WalkMovieFrom(object, object);
		}


		public static function WalkMovieFrom(from:DisplayObject, to:DisplayObject):String
		{
			var path:String = from.name;
			while (from != to.root)
			{
				from = from.parent;
				path = from.name+"."+path;
			};
			return "stage."+path;
		}


		// Display
		//---------------------------------------------

		public static function FitToScreen(object:DisplayObject):void
		{
			Debug.WriteLine("AS3", "FitToScreen", "Stage.height="+object.stage.height);
			ScaleToHeight(object, object.stage.height);
		}


		public static function ScaleToHeight(object:DisplayObject, height:Number):void
		{
			Debug.WriteLine("AS3", "ScaleToHeight", "object="+object+", height="+height);
			object.height = height;
			object.scaleX = object.scaleY;
		}


		public static function CenterOnStage(object:DisplayObject):void
		{
			object.x = (object.stage.width - object.width) / 2;
			object.y = (object.stage.height - object.height) / 2;
			Debug.WriteLine("AS3", "CenterOnStage", "object.x="+object.x+", object.y="+object.y);
		}


	}
}
