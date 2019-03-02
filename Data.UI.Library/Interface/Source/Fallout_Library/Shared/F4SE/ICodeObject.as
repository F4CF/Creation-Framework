package Shared.F4SE
{
	public interface ICodeObject
	{
		/* 0.6.8
		- added Scaleform receiving function
			- function onF4SEObjCreated(codeObject:Object):void
			- This function is called on the menu root document as well as first-level children
		*/
		function onF4SEObjCreated(codeObject:*):void;
	}
}
