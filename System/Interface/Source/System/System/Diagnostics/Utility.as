package System.Diagnostics
{
	import System.Diagnostics.Debug;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.*;

	public class Utility
	{
		// Object
		//---------------------------------------------

		/**
		 * Will trace the members of an object.
		 * @param self - The object to trace.
		 * */
		public static function TraceObject(self:*):void
		{
			var className:String = flash.utils.getQualifiedClassName(self);
			var classInfo:String = flash.utils.describeType(self);

			if (classInfo != null && classInfo != "")
			{
				Debug.WriteLine("\n"+className+"\n"+classInfo);
			}
			else
			{
				Debug.WriteLine(self.toString());
				TraceObjectRecursive(self);
			}
		}


		// TODO: The for-in method works for dynamic objects ONLY!
		/**
		 * This function uses recursion to trace the members of an object.
		 * @param self - The object to use.
		 * @param indentation - The current line indentation contains prefixs for nesting.
		 * */
		private static function TraceObjectRecursive(self:*, indentation:String = ""):void
		{
			const INDENT:String = "---";
			indentation == "" ? indentation = INDENT : indentation += INDENT;
			for (var member:* in self)
			{
				Debug.WriteLine(indentation, member + " : " + self[member], "  ");
				if (typeof(self[member]) == "object")
				{
					TraceObjectRecursive(self[member], indentation);
				}
			}
		}


		// Display Object
		//---------------------------------------------

		/**
		 * Will trace the parent to child relationship of display objects as a hierarchy.
		 * Some visual details such as alpha, width, height, and some other details are also traced.
		 * If a `Debug.Prefix` is set, then it will be used here.
		 * This function is recursive.
		 * @param self - The display object container to trace.
		 * @param options - Used to specify a maximum recursion depth or filter the results by name.
		 * The option defaults to a maximum recursion depth of infinity, the entire display list.
		 * @example Recurse and trace the entire display list.
		 * 	Utility.TraceDisplayList(stage);
		 * @example Recurse only to a depth of one hundred.
		 * 	Utility.TraceDisplayList(stage, 100);
		 * @example Recurse to, and only trace the display object with the given name.
		 * 	Utility.TraceDisplayList(stage, "ButtonHintBar_mc");
		*/
		public static function TraceDisplayList(self:DisplayObjectContainer, options:* = undefined):void
		{
			TraceDisplayListRecursive(self, options);
		}


		/**
		 * This function uses recursion to trace the parent to child relationship of display objects as a hierarchy.
		 * @param self - The display object container to recurse.
		 * @param options - Used to specify a maximum recursion depth or filter the results by name.
		 * The option defaults to a maximum recursion depth of infinity, the entire display list.
		 * @param indentation - The current line indentation contains prefixs for nesting.
		 * @param depth - The current depth of recursion.
		 * @param childAt - The current child index.
		*/
		private static function TraceDisplayListRecursive(self:DisplayObjectContainer, options:* = undefined, indentation:String = "", depth:int = 0, childAt:int = 0):void
		{
			if (typeof options == "undefined") { options = Number.POSITIVE_INFINITY; }
			if (depth > options) { return; }

			const INDENT:String = "   ";
			var index:int = self.numChildren;

			while (index--)
			{
				var child:DisplayObject = self.getChildAt(index);
				var output:String = indentation+(childAt++)+": "+child.name+" --> "+child;

				// indent child properties
				output += "\t\t";

				// debug alpha/visible properties
				output += "alpha: "+child.alpha.toFixed(2)+"/"+child.visible;

				// debug x and y position
				output += ", @: ("+child.x+", "+child.y+")";

				// debug transform properties
				output += ", w:"+child.width+"px ("+child.scaleX.toFixed(2)+")";
				output += ", h:"+child.height+"px ("+child.scaleY.toFixed(2)+")";
				output += ", r:"+child.rotation.toFixed(1)+"";

				if (typeof options == "number")
				{
					Debug.WriteLine(output);
				}
				else if (typeof options == "string" && output.match(new RegExp(options, "gi")).length != 0)
				{
					Debug.WriteLine(output, "in", self.name, "-->", self);
				}

				// Recurse on further display object children.
				if (child is DisplayObjectContainer)
				{
					TraceDisplayListRecursive(DisplayObjectContainer(child), options, indentation + INDENT, depth + 1);
				}
			}
		}


	}
}
