package Shared.AS3
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.*;
	import XML;

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


		public static function TraceObject(object:Object, prefix:String = ""):void
		{
			prefix == "" ? prefix = "---" : prefix += "---";
			for (var element:* in object)
			{
				WriteLine(prefix, element + " : " + object[element], "  ");
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

				if (typeof options == "number") WriteLine(output);
				else if (typeof options == "string" && output.match(new RegExp(options, "gi")).length != 0)
				{
					WriteLine(output, "in", container.name, "-->", container);
				}

				if (child is DisplayObjectContainer) TraceDisplayList(DisplayObjectContainer(child), options, indentString + INDENT, depth + 1);
			}
		}


	}
}
