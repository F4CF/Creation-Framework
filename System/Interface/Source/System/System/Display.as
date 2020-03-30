package System
{
	import System.Diagnostics.Debug;
	import System.Display;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;

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

		// TODO: Possibly deprecate this method.
		public static function GetInstance(self:DisplayObject):String
		{
			return GetInstanceFrom(self, self);
		}


		/**
		 * Gets the full variable instance path from one display object to another.
		 *
		 * @param self - The display object that will be traversed from.
		 * @param other - The display object that will be traversed to.
		 * @return The full variable instance path.
		*/
		public static function GetInstanceFrom(self:DisplayObject, other:DisplayObject):String
		{
			var path:String = self.name;
			while (self != other.root)
			{
				self = self.parent;
				path = self.name+"."+path;
			};
			return path;
		}


	}
}
