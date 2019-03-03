package System.Diagnostics
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.*;
	import XML;
	import System.Diagnostics.Debug;

	public class Utility
	{

		public static function TraceObject(object:Object, prefix:String = ""):void
		{
			prefix == "" ? prefix = "---" : prefix += "---";
			for (var element:* in object)
			{
				Debug.WriteLine(prefix, element + " : " + object[element], "  ");
				if (typeof(object[element]) == "object") TraceObject(object[element], prefix);
			}
		}


		public static function TraceDisplayList(container:DisplayObjectContainer, options:* = undefined, indentString:String = "", depth:int = 0, childAt:int = 0):void
		{
			if (typeof options == "undefined") options = Number.POSITIVE_INFINITY;
			if (depth > options) return;

			const INDENT:String = "   ";
			var index:int = container.numChildren;

			while (index--)
			{
				var child:DisplayObject = container.getChildAt(index);
				var output:String = indentString+(childAt++)+": "+child.name+" --> "+child;

				// debug alpha/visible properties
				output += "\t\talpha: "+child.alpha.toFixed(2)+"/"+child.visible;

				// debug x and y position
				output += ", @: ("+child.x+", "+child.y+")";

				// debug transform properties
				output += ", w:"+child.width+"px ("+child.scaleX.toFixed(2)+")";
				output += ", h:"+child.height+"px ("+child.scaleY.toFixed(2)+")";
				output += ", r:"+child.rotation.toFixed(1)+"";

				if (typeof options == "number") Debug.WriteLine(output);
				else if (typeof options == "string" && output.match(new RegExp(options, "gi")).length != 0)
				{
					Debug.WriteLine(output, "in", container.name, "-->", container);
				}

				if (child is DisplayObjectContainer) TraceDisplayList(DisplayObjectContainer(child), options, indentString + INDENT, depth + 1);
			}
		}


	}
}
