package
{
	import Shared.AS3.BSButtonHintBar;
	import Shared.AS3.BSButtonHintData;
	import Shared.AS3.BSScrollingList;
	import Shared.AS3.BSScrollingListEntry;
	import Shared.AS3.BSUIComponent;
	import Shared.PlatformChangeEvent;
	import System.Diagnostics.Debug;
	import System.Diagnostics.Dump;
	import System.Diagnostics.Utility;
	import System.Input;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class TestingPanel extends BSUIComponent
	{
		// List
		public var UnitList_mc:UnitList;

		// Selected
		public var SelectedScript_tf:TextField;
		public var SelectedName_tf:TextField;
		public var SelectedDescription_tf:TextField;
		public var SelectedIcon_mc:ResultIcon;

		// Button Bar
		public var ButtonHintBar_mc:BSButtonHintBar;
		private var ButtonUnload:BSButtonHintData;
		private var ButtonRun:BSButtonHintData;


		// Initialization
		//---------------------------------------------

		public function TestingPanel()
		{
			Debug.WriteLine("[TestingPanel]", "(CTOR)");
			addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
		}


		private function OnAddedToStage(e:Event):void
		{
			Debug.WriteLine("[TestingPanel]", "(OnAddedToStage)");
			SetupUnitList();
			SetupButtonBar();
		}


		// List
		//---------------------------------------------

		private function SetupUnitList():void
		{
			Debug.WriteLine("[TestingPanel]", "(SetupUnitList)");
			stage.stageFocusRect = false;
			stage.focus = UnitList_mc;

			try
			{
				UnitList_mc["componentInspectorSetting"] = true;
				UnitList_mc.listEntryClass = "UnitListEntry";
				UnitList_mc.numListItems = 10;
				UnitList_mc.restoreListIndex = true;
				UnitList_mc.textOption = BSScrollingList.TEXT_OPTION_NONE;
				UnitList_mc.verticalSpacing = -3;
				UnitList_mc["componentInspectorSetting"] = false;
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingPanel]", "(OnAddedToStage)", "UnitList-COMPONENT", "ERROR:", error.toString());
			}

			try
			{
				UnitList_mc.onComponentInit(new Event(Event.INIT));
				UnitList_mc.SetPlatform(0, false);
				UnitList_mc.selectedIndex = 0;
				UnitList_mc.disableInput = false;
				UnitList_mc.disableSelection = false;

				UnitList_mc.addEventListener(BSScrollingList.ITEM_PRESS, OnItemPress);
				UnitList_mc.addEventListener(BSScrollingList.SELECTION_CHANGE, OnSelectionChange);
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingPanel]", "(OnAddedToStage)", "UnitList-COMPONENT-INIT", "Error:", error.toString());
			}

			try
			{
				UnitList_mc.entryList.push(NewEntry("Unit Test #1", "SystemTests:UI:ButtonMenu", "Tests for functionality of the script."));
				UnitList_mc.entryList.push(NewEntry("Unit Test #2", "SystemTests:Array", "Tests for functionality of the script."));
				UnitList_mc.entryList.push(NewEntry("Unit Test #3", "SystemTests:Boolean", "Tests for functionality of the script."));
				UnitList_mc.entryList.push(NewEntry("Unit Test #4", "SystemTests:Collections:List", "Tests for functionality of the script."));
				UnitList_mc.entryList.push(NewEntry("Unit Test #5", "ScriptingTests:Activation", "Tests for functionality of the script."));

				UnitList_mc.InvalidateData();
				UnitList_mc.selectedIndex = 0;
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingPanel]", "(SetupUnitList)", "Error:", error.toString());
			}

			Dump.BSScrollingList_Trace(UnitList_mc);
		}


		private function OnItemPress(e:Event):void
		{
			Debug.WriteLine("[TestingPanel]", "(OnItemPress)", e.toString());
			if (UnitList_mc.selectedEntry != null)
			{
				SelectionHandler(UnitList_mc.selectedEntry as UnitListEntry);
			}
			else
			{
				Debug.WriteLine("[TestingPanel]", "(OnItemPress)", "Error:", "The selected entry cannot be null.");
			}
		}


		private function OnSelectionChange(e:Event):void
		{
			Debug.WriteLine("[TestingPanel]", "(OnSelectionChange)", e.toString());

			if (UnitList_mc.selectedEntry != null)
			{
				SelectionHandler(UnitList_mc.selectedEntry as UnitListEntry);
			}
			else
			{
				Debug.WriteLine("[TestingPanel]", "(OnSelectionChange)", "Error:", "The selected entry cannot be null.");
			}
		}


		private function SelectionHandler(entry:UnitListEntry):void
		{
			if (entry != null)
			{
				Debug.WriteLine("[TestingPanel]", "(SelectionHandler)", "selected:", entry.toString());

				SelectedScript_tf.text = entry.Text;
				SelectedName_tf.text = entry.Name;
				SelectedDescription_tf.text = entry.Description;

				Debug.WriteLine("[TestingPanel]", "(SelectionHandler)", "entry.currentFrame", entry.Icon_mc.currentFrame);
				SwitchIcon();
				Dump.BSScrollingListEntry_Trace(entry as BSScrollingListEntry);
			}
			else
			{
				Debug.WriteLine("[TestingPanel]", "(SelectionHandler)", "Error:", "The unit list entry is null.");
			}
		}


		private function SwitchIcon():void
		{
			Debug.WriteLine("[TestingPanel]", "(SwitchIcon)", "SelectedIcon_mc.currentFrame", SelectedIcon_mc.currentFrame);

			if (SelectedIcon_mc.currentFrame == 1)
			{
				SelectedIcon_mc.gotoAndStop(2);
				UnitList_mc.selectedEntry.Icon_mc.gotoAndStop(2);
			}
			else
			{
				SelectedIcon_mc.gotoAndStop(1);
				UnitList_mc.selectedEntry.Icon_mc.gotoAndStop(1);
			}

			Debug.WriteLine("[TestingPanel]", "(SwitchIcon)", "SelectedIcon_mc.currentFrame", "SWITCH:", SelectedIcon_mc.currentFrame);
		}


		// Button Bar
		//---------------------------------------------

		private function SetupButtonBar():void
		{
			Debug.WriteLine("[TestingPanel]", "(SetupButtonBar)");

			try
			{
				ButtonHintBar_mc["componentInspectorSetting"] = true;
				ButtonHintBar_mc.BackgroundAlpha = 1;
				ButtonHintBar_mc.BackgroundColor = 0;
				ButtonHintBar_mc.bracketCornerLength = 6;
				ButtonHintBar_mc.bracketLineWidth = 1.5;
				ButtonHintBar_mc.BracketStyle = "horizontal";
				ButtonHintBar_mc.bRedirectToButtonBarMenu = false;
				ButtonHintBar_mc.bShowBrackets = true;
				ButtonHintBar_mc.bUseShadedBackground = true;
				ButtonHintBar_mc.ShadedBackgroundMethod = "Shader";
				ButtonHintBar_mc.ShadedBackgroundType = "normal";
				ButtonHintBar_mc["componentInspectorSetting"] = false;
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingPanel]", "(SetupButtonBar)", "ButtonHintBar_mc", "COMPONENT", "ERROR:", error.toString());
			}

			try
			{
				// ButtonHintBar_mc.onComponentInit(new Event(Event.INIT)); // needed on unconventional menus?
				ButtonHintBar_mc.SetPlatform(PlatformChangeEvent.PLATFORM_PC_KB_MOUSE, false);
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingPanel]", "(SetupButtonBar)", "ButtonHintBar_mc", "COMPONENT-INIT", "ERROR:", error.toString());
			}

			try
			{
				// Create a new button array.
				var buttons:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();

				// Setup the unload button.
				ButtonUnload = new BSButtonHintData
				(
					"Show Console",
					"End", // END-35 key for unloading
					"Up",
					"_Positive",
					0,
					this.OnButtonUnload
				);
				ButtonUnload.name = "Unload_btn";
				ButtonUnload.ButtonVisible = true;
				ButtonUnload.ButtonEnabled = true;
				buttons.push(ButtonUnload);

				// Setup the test run button.
				ButtonRun = new BSButtonHintData
				(
					"Run Tests",
					"Z",
					"Down",
					"_Negative",
					0,
					this.OnButtonRun
				);
				ButtonRun.name = "RunTests_btn";
				ButtonRun.ButtonVisible = true;
				ButtonRun.ButtonEnabled = true;
				buttons.push(ButtonRun);

				// Populate
				ButtonHintBar_mc.SetButtonHintData(buttons);
				ButtonHintBar_mc.SetIsDirty();
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingPanel]", "(SetupButtonBar)", "ButtonHintBar_mc", "Buttons", "ERROR:", error.toString());
			}

			// Dump and trace objects.
			Dump.BSButtonHintBar_Trace(ButtonHintBar_mc);
			Dump.BSButtonHintData_Trace(ButtonRun);
			Dump.BSButtonHintData_Trace(ButtonUnload);
		}


		private function OnButtonUnload():void
		{
			Debug.WriteLine("[TestingPanel]", "(OnButtonUnload)");
		}


		private function OnButtonRun():void
		{
			Debug.WriteLine("[TestingPanel]", "(OnButtonRun)");
		}


		// private function ToButtonHint(argument:Object):BSButtonHintData
		// {
		// 	var textValue = argument["__struct__"]["__data__"]["text"];
		// 	var keyCode = 	argument["__struct__"]["__data__"]["keyCode"];

		// 	var hint:BSButtonHintData = new BSButtonHintData
		// 	(
		// 		textValue,
		// 		Input.KeyCodeToPC(keyCode),
		// 		"PlayStation",
		// 		"Xbox",
		// 		1,
		// 		null
		// 	);
		// 	return hint;
		// }




		// Methods
		//---------------------------------------------

		// @Papyrus
		public function SetData(argument:Object, ... rest):void
		{
			Debug.WriteLine("[TestingPanel]", "(SetData)");

			if (UnitList_mc.entryList != null)
			{
				if (argument != null)
				{
					var entry:UnitListEntry = ToUnitListEntry(argument);
					UnitList_mc.entryList.push(entry);

					if (rest != null)
					{
						for (var index:uint = 0; index < rest.length; index++)
						{
							var data = rest[index];
							entry = ToUnitListEntry(data);
							UnitList_mc.entryList.push(entry);
						}
					}
					else
					{
						Debug.WriteLine("[TestingPanel]", "(SetData)", "Argument:", entry);
					}
				}
				else
				{
					Debug.WriteLine("[TestingPanel]", "(SetData)", "The argument was null.");
				}

				UnitList_mc.InvalidateData();
				UnitList_mc.selectedIndex = 0;
			}
			else
			{
				Debug.WriteLine("[TestingPanel]", "(SetData)", "The `UnitList_mc.entryList` was null.");
			}
		}


		// Converts a papyrus data object into a unit list entry.
		private function ToUnitListEntry(argument:Object):UnitListEntry
		{
			// Debug.WriteLine("[TestingPanel]", "(ToUnitListEntry)");
			// Utility.TraceObject(argument);

			try
			{
				var sType:String = argument["__struct__"]["__type__"];
				var sName:String = argument["__struct__"]["__data__"]["Name"];
				var sDescription:String = argument["__struct__"]["__data__"]["Description"];
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingPanel]", "(ToUnitListEntry)", "Error:", error.toString());
			}

			var entry:UnitListEntry = NewEntry(sType, sName, sDescription);
			entry.Text = sType;
			entry.Name = sName;
			entry.Description = sDescription;

			Debug.WriteLine("[TestingPanel]", "(ToUnitListEntry)", entry.toString());
			return entry;
		}


		// Creates a new unit list entry.
		private static function NewEntry(sText:String, sName:String, sDescription:String):UnitListEntry
		{
			Debug.WriteLine("[TestingPanel]", "(NewEntry)", "sText:"+sText, "sName:"+sName, "sDescription:"+sDescription);
			var entry:UnitListEntry = new UnitListEntry();
			entry.Text = sText;
			entry.Name = sName;
			entry.Description = sDescription;
			return entry;
		}


	}
}
