package System.Diagnostics
{
	import Shared.AS3.BSButtonHintBar;
	import Shared.AS3.BSButtonHintData;
	import Shared.AS3.BSScrollingList;
	import Shared.AS3.BSScrollingListEntry;
	import Shared.AS3.BSUIComponent;
	import Shared.IMenu;
	import System.Diagnostics.Debug;
	import System.UI.MenuType;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Stage;
	// import flash.utils.*;

	public class Dump
	{
		// private static const DebugPrefix:String = "[Dump]";

		// Experimental
		//---------------------------------------------

		// Deprecated, Unsupported
		// private function ExamineClass(self:*):void
		// {
		// 	var className:String = flash.utils.getQualifiedClassName(self);
		// 	Debug.WriteLine("getQualifiedClassName", className);

		// 	var classInfo:String = flash.utils.describeType(self);
		// 	Debug.WriteLine("describeType:", "\n"+classInfo);
		// }


		// Functions
		//---------------------------------------------

		private static function GetName(self:Object):String
		{
			if (self != null)
			{
				var name:String = GetProperty(self, "name") as String;
				if (name != null || name != "")
				{
					return name;
				}
				else
				{
					Debug.WriteLine("[System.Diagnostics.Dump]", "GetName", "NAME-NULL");
					return "self";
				}
			}
			else
			{
				Debug.WriteLine("[System.Diagnostics.Dump]", "GetName", "SELF-NULL");
				return "null";
			}
		}


		private static function GetProperty(self:Object, property:String):Object
		{
			if (self != null)
			{
				if (self.hasOwnProperty(property) == true)
				{
					var value = self[property];
					if (value != null)
					{
						return value;
					}
					else
					{
						Debug.WriteLine("[System.Diagnostics.Dump]", "GetName", "The object property value of "+property+" was null.");
						return null;
					}
				}
				else
				{
					Debug.WriteLine("[System.Diagnostics.Dump]", "GetName", "The object property of "+property+" does not exist.");
					return null;
				}
			}
			else
			{
				Debug.WriteLine("[System.Diagnostics.Dump]", "GetName", "The object cannot be null.");
				return null;
			}
		}


		// System.UI
		//---------------------------------------------

		public static function MenuType_Trace(self:MenuType):void
		{
			const className:String = "System.UI.MenuType";
			if (self != null)
			{
				var name:String = GetName(self);
				Debug.WriteLine("["+name+"]", "("+className+")", "{Url}", self.Url);
				Debug.WriteLine("["+name+"]", "("+className+")", "{Root}", self.Root);
				Debug.WriteLine("["+name+"]", "("+className+")", "{Instance}", self.Instance);
				Debug.WriteLine("["+name+"]", "("+className+")", "{Exists}", self.Exists);
				Debug.WriteLine("["+name+"]", "("+className+")", "{Visible}", self.Visible);
				Debug.WriteLine("["+name+"]", "("+className+")", "{Alpha}", self.Alpha);
			}
			else
			{
				Debug.WriteLine("[System.Diagnostics.Dump]", "("+className+")", "NULL");
			}
		}


		// DisplayObject
		//---------------------------------------------

		// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/DisplayObject.html
		// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/LoaderInfo.html
		// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/Stage.html
		public static function DisplayObject_Trace(self:DisplayObject):void
		{
			const className:String = "flash.display.DisplayObject";
			if (self != null)
			{
				var name:String = GetName(self);
				Debug.WriteLine("["+name+"]", "("+className+")", "{name}", self.name);
				Debug.WriteLine("["+name+"]", "("+className+")", "{root.name}", self.root.name);
				Debug.WriteLine("["+name+"]", "("+className+")", "{parent.name}", self.parent.name);
				Debug.WriteLine("["+name+"]", "("+className+")", "{loaderInfo.url}", self.loaderInfo.url);
				Debug.WriteLine("["+name+"]", "("+className+")", "{loaderInfo.actionScriptVersion}", self.loaderInfo.actionScriptVersion);
				Debug.WriteLine("["+name+"]", "("+className+")", "{loaderInfo.swfVersion}", self.loaderInfo.swfVersion);
				Debug.WriteLine("["+name+"]", "("+className+")", "{loaderInfo.loaderURL}", self.loaderInfo.loaderURL);
				Debug.WriteLine("["+name+"]", "("+className+")", "{loaderInfo.contentType}", self.loaderInfo.contentType);
				Debug.WriteLine("["+name+"]", "("+className+")", "{loaderInfo.frameRate}", self.loaderInfo.frameRate);
				Debug.WriteLine("["+name+"]", "("+className+")", "{loaderInfo.isURLInaccessible}", self.loaderInfo.isURLInaccessible);
				Debug.WriteLine("["+name+"]", "("+className+")", "{stage}", self.stage.toString(), "flash.display.Stage");
				Debug.WriteLine("["+name+"]", "("+className+")", "{stage.stageHeight}", self.stage.stageHeight);
				Debug.WriteLine("["+name+"]", "("+className+")", "{stage.stageWidth}", self.stage.stageWidth);
				Debug.WriteLine("["+name+"]", "("+className+")", "{stage.height}", self.stage.height);
				Debug.WriteLine("["+name+"]", "("+className+")", "{stage.width}", self.stage.width);
				Debug.WriteLine("["+name+"]", "("+className+")", "{stage.scaleMode}", self.stage.scaleMode);
				Debug.WriteLine("["+name+"]", "("+className+")", "{stage.align}", self.stage.align);
				Debug.WriteLine("["+name+"]", "("+className+")", "{stage.z}", self.stage.z);
				Debug.WriteLine("["+name+"]", "("+className+")", "{stage.stageFocusRect}", self.stage.stageFocusRect);
				Debug.WriteLine("["+name+"]", "("+className+")", "{stage.numChildren}", self.stage.numChildren);
				Debug.WriteLine("["+name+"]", "("+className+")", "{stage.mouseChildren}", self.stage.mouseChildren);
				Debug.WriteLine("["+name+"]", "("+className+")", "{stage.frameRate}", self.stage.frameRate);
				Debug.WriteLine("["+name+"]", "("+className+")", "{stage.focus}", self.stage.focus);
				Debug.WriteLine("["+name+"]", "("+className+")", "{x}", self.x);
				Debug.WriteLine("["+name+"]", "("+className+")", "{y}", self.y);
				Debug.WriteLine("["+name+"]", "("+className+")", "{z}", self.z);
				Debug.WriteLine("["+name+"]", "("+className+")", "{alpha}", self.alpha);
				Debug.WriteLine("["+name+"]", "("+className+")", "{visible}", self.visible);
				Debug.WriteLine("["+name+"]", "("+className+")", "{blendMode}", self.blendMode);
				Debug.WriteLine("["+name+"]", "("+className+")", "{cacheAsBitmap}", self.cacheAsBitmap);
				Debug.WriteLine("["+name+"]", "("+className+")", "{filters}", self.filters);
				Debug.WriteLine("["+name+"]", "("+className+")", "{mask}", self.mask);
				Debug.WriteLine("["+name+"]", "("+className+")", "{mouseX }", self.mouseX );
				Debug.WriteLine("["+name+"]", "("+className+")", "{mouseY}", self.mouseY);
				Debug.WriteLine("["+name+"]", "("+className+")", "{scaleX}", self.scaleX);
				Debug.WriteLine("["+name+"]", "("+className+")", "{scaleY}", self.scaleY);
				Debug.WriteLine("["+name+"]", "("+className+")", "{scaleZ}", self.scaleZ);
				Debug.WriteLine("["+name+"]", "("+className+")", "{height}", self.height);
				Debug.WriteLine("["+name+"]", "("+className+")", "{width}", self.width);
			}
			else
			{
				Debug.WriteLine("[System.Diagnostics.Dump]", "("+className+")", "NULL");
			}
		}


		// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/MovieClip.html
		public static function MovieClip_Trace(self:MovieClip):void
		{
			const className:String = "flash.display.MovieClip";
			if (self != null)
			{
				var name:String = GetName(self);
				Debug.WriteLine("["+name+"]", "("+className+")", "{enabled}", self.enabled);
				Debug.WriteLine("["+name+"]", "("+className+")", "{totalFrames}", self.totalFrames);
				Debug.WriteLine("["+name+"]", "("+className+")", "{framesLoaded}", self.framesLoaded);
				Debug.WriteLine("["+name+"]", "("+className+")", "{trackAsMenu}", self.trackAsMenu);
				Debug.WriteLine("["+name+"]", "("+className+")", "{scenes.length}", self.scenes.length);
				Debug.WriteLine("["+name+"]", "("+className+")", "{isPlaying}", self.isPlaying);
				Debug.WriteLine("["+name+"]", "("+className+")", "{currentFrame}", self.currentFrame);
				Debug.WriteLine("["+name+"]", "("+className+")", "{currentFrameLabel}", self.currentFrameLabel);
				Debug.WriteLine("["+name+"]", "("+className+")", "{currentLabel}", self.currentLabel);
				Debug.WriteLine("["+name+"]", "("+className+")", "{currentLabels.length}", self.currentLabels.length);
				Debug.WriteLine("["+name+"]", "("+className+")", "{currentScene}", self.currentScene);
			}
			else
			{
				Debug.WriteLine("[System.Diagnostics.Dump]", "("+className+")", "NULL");
			}
		}


		// Bethesda Studios - IMenu
		//---------------------------------------------

		public static function IMenu_Trace(self:IMenu):void
		{
			const className:String = "Shared.IMenu";
			if (self != null)
			{
				var name:String = GetName(self);
				Debug.WriteLine("["+name+"]", "("+className+")", "{uiPlatform}", self.uiPlatform);
				Debug.WriteLine("["+name+"]", "("+className+")", "{bPS3Switch}", self.bPS3Switch);
				Debug.WriteLine("["+name+"]", "("+className+")", "{SafeX}", self.SafeX);
				Debug.WriteLine("["+name+"]", "("+className+")", "{SafeY}", self.SafeY);
			}
			else
			{
				Debug.WriteLine("[System.Diagnostics.Dump]", "("+className+")", "NULL");
			}
		}


		// Bethesda Studios - UIComponent
		//---------------------------------------------

		public static function BSUIComponent_Trace(self:BSUIComponent):void
		{
			const className:String = "Shared.AS3.BSUIComponent";
			if (self != null)
			{
				var name:String = GetName(self);
				Debug.WriteLine("["+name+"]", "("+className+")", "{bIsDirty}", self.bIsDirty);
				Debug.WriteLine("["+name+"]", "("+className+")", "{iPlatform}", self.iPlatform);
				Debug.WriteLine("["+name+"]", "("+className+")", "{bPS3Switch}", self.bPS3Switch);
				Debug.WriteLine("["+name+"]", "("+className+")", "{bAcquiredByNativeCode}", self.bAcquiredByNativeCode);
				Debug.WriteLine("["+name+"]", "("+className+")", "{bShowBrackets}", self.bShowBrackets);
				Debug.WriteLine("["+name+"]", "("+className+")", "{bracketLineWidth}", self.bracketLineWidth);
				Debug.WriteLine("["+name+"]", "("+className+")", "{bracketCornerLength}", self.bracketCornerLength);
				Debug.WriteLine("["+name+"]", "("+className+")", "{bracketPaddingX}", self.bracketPaddingX);
				Debug.WriteLine("["+name+"]", "("+className+")", "{bracketPaddingY}", self.bracketPaddingY);
				Debug.WriteLine("["+name+"]", "("+className+")", "{BracketStyle}", self.BracketStyle);
				Debug.WriteLine("["+name+"]", "("+className+")", "{bUseShadedBackground}", self.bUseShadedBackground);
				Debug.WriteLine("["+name+"]", "("+className+")", "{ShadedBackgroundType}", self.ShadedBackgroundType);
				Debug.WriteLine("["+name+"]", "("+className+")", "{ShadedBackgroundMethod}", self.ShadedBackgroundMethod);
			}
			else
			{
				Debug.WriteLine("[System.Diagnostics.Dump]", "("+className+")", "NULL");
			}
		}


		// Bethesda Studios - Scrolling List
		//---------------------------------------------

		public static function BSScrollingList_Trace(self:BSScrollingList):void
		{
			const className:String = "Shared.AS3.BSScrollingList";
			if (self != null)
			{
				var name:String = GetName(self);
				Debug.WriteLine("["+name+"]", "("+className+")", "{filterer}", self.filterer);
				Debug.WriteLine("["+name+"]", "("+className+")", "{itemsShown}", self.itemsShown);
				Debug.WriteLine("["+name+"]", "("+className+")", "{initialized}", self.initialized);
				Debug.WriteLine("["+name+"]", "("+className+")", "{selectedIndex}", self.selectedIndex);
				Debug.WriteLine("["+name+"]", "("+className+")", "{selectedClipIndex}", self.selectedClipIndex);
				Debug.WriteLine("["+name+"]", "("+className+")", "{shownItemsHeight}", self.shownItemsHeight);
				Debug.WriteLine("["+name+"]", "("+className+")", "{scrollPosition}", self.scrollPosition);
				Debug.WriteLine("["+name+"]", "("+className+")", "{maxScrollPosition}", self.maxScrollPosition);
				Debug.WriteLine("["+name+"]", "("+className+")", "{selectedEntry}", self.selectedEntry);
				Debug.WriteLine("["+name+"]", "("+className+")", "{entryList}", self.entryList);
				Debug.WriteLine("["+name+"]", "("+className+")", "{disableInput}", self.disableInput);
				Debug.WriteLine("["+name+"]", "("+className+")", "{textOption}", self.textOption);
				Debug.WriteLine("["+name+"]", "("+className+")", "{verticalSpacing}", self.verticalSpacing);
				Debug.WriteLine("["+name+"]", "("+className+")", "{numListItems}", self.numListItems);
				Debug.WriteLine("["+name+"]", "("+className+")", "{restoreListIndex}", self.restoreListIndex);
				Debug.WriteLine("["+name+"]", "("+className+")", "{disableSelection}", self.disableSelection);
			}
			else
			{
				Debug.WriteLine("[System.Diagnostics.Dump]", "("+className+")", "NULL");
			}
		}


		public static function BSScrollingListEntry_Trace(self:BSScrollingListEntry):void
		{
			const className:String = "Shared.AS3.BSScrollingListEntry";
			if (self != null)
			{
				var name:String = GetName(self);
				Debug.WriteLine("["+name+"]", "("+className+")", "{clipIndex}", self.clipIndex);
				Debug.WriteLine("["+name+"]", "("+className+")", "{itemIndex}", self.itemIndex);
				Debug.WriteLine("["+name+"]", "("+className+")", "{selected}", self.selected);
				Debug.WriteLine("["+name+"]", "("+className+")", "{hasDynamicHeight}", self.hasDynamicHeight);
				Debug.WriteLine("["+name+"]", "("+className+")", "{defaultHeight}", self.defaultHeight);
			}
			else
			{
				Debug.WriteLine("[System.Diagnostics.Dump]", "("+className+")", "NULL");
			}
		}


		// Bethesda Studios - Button Hint Bar
		//---------------------------------------------

		public static function BSButtonHintBar_Trace(self:BSButtonHintBar):void
		{
			const className:String = "Shared.AS3.BSButtonHintBar";
			if (self != null)
			{
				BSUIComponent(self);
			}
			else
			{
				Debug.WriteLine("[System.Diagnostics.Dump]", "("+className+")", "NULL");
			}
		}


		public static function BSButtonHintData_Trace(self:BSButtonHintData):void
		{
			const className:String = "Shared.AS3.BSButtonHintData";
			if (self != null)
			{
				var name:String = GetName(self);
				Debug.WriteLine("["+name+"]", "("+className+")", "{PCKey}", self.PCKey);
				Debug.WriteLine("["+name+"]", "("+className+")", "{PSNButton}", self.PSNButton);
				Debug.WriteLine("["+name+"]", "("+className+")", "{XenonButton}", self.XenonButton);
				Debug.WriteLine("["+name+"]", "("+className+")", "{Justification}", self.Justification);
				Debug.WriteLine("["+name+"]", "("+className+")", "{SecondaryPCKey}", self.SecondaryPCKey);
				Debug.WriteLine("["+name+"]", "("+className+")", "{SecondaryPSNButton}", self.SecondaryPSNButton);
				Debug.WriteLine("["+name+"]", "("+className+")", "{SecondaryXenonButton}", self.SecondaryXenonButton);
				Debug.WriteLine("["+name+"]", "("+className+")", "{DynamicMovieClipName}", self.DynamicMovieClipName);
				Debug.WriteLine("["+name+"]", "("+className+")", "{ButtonDisabled}", self.ButtonDisabled);
				Debug.WriteLine("["+name+"]", "("+className+")", "{ButtonEnabled}", self.ButtonEnabled);
				Debug.WriteLine("["+name+"]", "("+className+")", "{SecondaryButtonDisabled}", self.SecondaryButtonDisabled);
				Debug.WriteLine("["+name+"]", "("+className+")", "{SecondaryButtonEnabled}", self.SecondaryButtonEnabled);
				Debug.WriteLine("["+name+"]", "("+className+")", "{ButtonText}", self.ButtonText);
				Debug.WriteLine("["+name+"]", "("+className+")", "{ButtonVisible}", self.ButtonVisible);
				Debug.WriteLine("["+name+"]", "("+className+")", "{ButtonFlashing}", self.ButtonFlashing);
				Debug.WriteLine("["+name+"]", "("+className+")", "{hasSecondaryButton}", self.hasSecondaryButton);
			}
			else
			{
				Debug.WriteLine("[System.Diagnostics.Dump]", "("+className+")", "NULL");
			}
		}


	}
}
