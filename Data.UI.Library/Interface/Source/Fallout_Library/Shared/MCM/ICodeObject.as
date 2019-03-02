package Shared.MCM
{
	public interface ICodeObject
	{
		/* v1.28
		- added Scaleform receiving function
			- This function is called on the menu root document.
		*/
		function onLibLoaded(mcmCodeObject:*, f4seCodeObject:*):void;
	}
}
