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
	import System.IO.File;
	import System.IO.FileSystem;
	import System.IO.FileSystemInfo;
	import System.IO.Path;
	import System.Input;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class CommandPanel extends BSUIComponent
	{
		// List
		public var CommandList_mc:CommandList;

		// Selected
		public var CommandCard_mc:CommandCard;

		// Button Bar
		public var ButtonHintBar_mc:BSButtonHintBar;
		private var ButtonUnload:BSButtonHintData;
		private var ButtonRun:BSButtonHintData;


		// Initialization
		//---------------------------------------------

		public function CommandPanel()
		{
			Debug.WriteLine("[CommandPanel]", "(CTOR)");
			addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
		}


		private function OnAddedToStage(e:Event):void
		{
			Debug.WriteLine("[CommandPanel]", "(OnAddedToStage)");
			SetupUnitList();
			SetupButtonBar();
		}


		// List
		//---------------------------------------------

		private function SetupUnitList():void
		{
			Debug.WriteLine("[CommandPanel]", "(SetupUnitList)");
			stage.stageFocusRect = false;
			stage.focus = CommandList_mc;

			try
			{
				CommandList_mc["componentInspectorSetting"] = true;
				CommandList_mc.listEntryClass = "CommandListEntry";
				CommandList_mc.numListItems = 10;
				CommandList_mc.restoreListIndex = true;
				CommandList_mc.textOption = BSScrollingList.TEXT_OPTION_NONE;
				CommandList_mc.verticalSpacing = -3;
				CommandList_mc["componentInspectorSetting"] = false;
			}
			catch (error:Error)
			{
				Debug.WriteLine("[CommandPanel]", "(OnAddedToStage)", "CommandList-COMPONENT", "ERROR:", error.toString());
			}

			try
			{
				CommandList_mc.onComponentInit(new Event(Event.INIT));
				CommandList_mc.SetPlatform(0, false);
				CommandList_mc.selectedIndex = 0;
				CommandList_mc.disableInput = false;
				CommandList_mc.disableSelection = false;

				CommandList_mc.addEventListener(BSScrollingList.ITEM_PRESS, OnItemPress);
				CommandList_mc.addEventListener(BSScrollingList.SELECTION_CHANGE, OnSelectionChange);
			}
			catch (error:Error)
			{
				Debug.WriteLine("[CommandPanel]", "(OnAddedToStage)", "CommandList-COMPONENT-INIT", "Error:", error.toString());
			}

			try
			{
				// CommandList_mc.entryList.push(NewEntry("COC RedRocketExt", "Command", "Center on the cell named RedRocketExt."));
				// CommandList_mc.entryList.push(NewEntry("Player.AddItem F 100", "Command", "Add 100 caps to the player."));


				// TODO: Testing this.
				GetDirectory();


				CommandList_mc.InvalidateData();
				CommandList_mc.selectedIndex = 0;
			}
			catch (error:Error)
			{
				Debug.WriteLine("[CommandPanel]", "(SetupUnitList)", "Error:", error.toString());
			}

			Dump.BSScrollingList_Trace(CommandList_mc);
		}





		private function GetDirectory():void
		{
			Debug.WriteLine("[CommandPanel]", "(GetDirectory)");
			const directory:String = "Data\\CMD";
			const match:String = "*.txt";
			const recursive:Boolean = true;

			var files:Vector.<FileSystemInfo> = FileSystem.GetListing(directory, match, recursive);
			for each(var file:FileSystemInfo in files)
			{
				if (file != null)
				{
					var fileName = Path.GetFileName(file.Path);

					Debug.WriteLine("[CommandPanel]", "(GetDirectory)", "directory:"+directory, "match:"+match, "file:"+file.toString());

					CommandList_mc.entryList.push(NewEntry(file.Path, fileName, "Date Modified: "+file.Modified));
				}
				else
				{
					Debug.WriteLine("[CommandPanel]", "(GetDirectory)", "directory:"+directory, "match:"+match, "The file was NULL!");
				}
			}
		}






		private function OnItemPress(e:Event):void
		{
			Debug.WriteLine("[CommandPanel]", "(OnItemPress)", e.toString());
			if (CommandList_mc.selectedEntry != null)
			{
				SelectionHandler(CommandList_mc.selectedEntry as CommandListEntry);
				(this.parent as SystemConsole).RunBatch((CommandList_mc.selectedEntry as CommandListEntry).Name);
				(this.parent as SystemConsole).AddCaps(1);
			}
			else
			{
				Debug.WriteLine("[CommandPanel]", "(OnItemPress)", "Error:", "The selected entry cannot be null.");
			}
		}


		private function OnSelectionChange(e:Event):void
		{
			Debug.WriteLine("[CommandPanel]", "(OnSelectionChange)", e.toString());

			if (CommandList_mc.selectedEntry != null)
			{
				SelectionHandler(CommandList_mc.selectedEntry as CommandListEntry);
			}
			else
			{
				Debug.WriteLine("[CommandPanel]", "(OnSelectionChange)", "Error:", "The selected entry cannot be null.");
			}
		}


		private function SelectionHandler(entry:CommandListEntry):void
		{
			if (entry != null)
			{
				Debug.WriteLine("[CommandPanel]", "(SelectionHandler)", "selected:", entry.toString());

				CommandCard_mc.SelectedScript_tf.text = entry.Text;
				CommandCard_mc.SelectedName_tf.text = entry.Name;
				CommandCard_mc.SelectedDescription_tf.text = entry.Description;

				Debug.WriteLine("[CommandPanel]", "(SelectionHandler)", "entry.currentFrame", entry.Icon_mc.currentFrame);
				SwitchIcon();
				Dump.BSScrollingListEntry_Trace(entry as BSScrollingListEntry);
			}
			else
			{
				Debug.WriteLine("[CommandPanel]", "(SelectionHandler)", "Error:", "The unit list entry is null.");
			}
		}


		private function SwitchIcon():void
		{
			Debug.WriteLine("[CommandPanel]", "(SwitchIcon)", "SelectedIcon_mc.currentFrame", CommandCard_mc.SelectedIcon_mc.currentFrame);

			if (CommandCard_mc.SelectedIcon_mc.currentFrame == 1)
			{
				CommandCard_mc.SelectedIcon_mc.gotoAndStop(2);
				CommandList_mc.selectedEntry.Icon_mc.gotoAndStop(2);
			}
			else
			{
				CommandCard_mc.SelectedIcon_mc.gotoAndStop(1);
				CommandList_mc.selectedEntry.Icon_mc.gotoAndStop(1);
			}

			Debug.WriteLine("[CommandPanel]", "(SwitchIcon)", "SelectedIcon_mc.currentFrame", "SWITCH:", CommandCard_mc.SelectedIcon_mc.currentFrame);
		}


		// Button Bar
		//---------------------------------------------

		private function SetupButtonBar():void
		{
			Debug.WriteLine("[CommandPanel]", "(SetupButtonBar)");

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
				Debug.WriteLine("[CommandPanel]", "(SetupButtonBar)", "ButtonHintBar_mc", "COMPONENT", "ERROR:", error.toString());
			}

			try
			{
				// ButtonHintBar_mc.onComponentInit(new Event(Event.INIT)); // needed on unconventional menus?
				ButtonHintBar_mc.SetPlatform(PlatformChangeEvent.PLATFORM_PC_KB_MOUSE, false);
			}
			catch (error:Error)
			{
				Debug.WriteLine("[CommandPanel]", "(SetupButtonBar)", "ButtonHintBar_mc", "COMPONENT-INIT", "ERROR:", error.toString());
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
				Debug.WriteLine("[CommandPanel]", "(SetupButtonBar)", "ButtonHintBar_mc", "Buttons", "ERROR:", error.toString());
			}

			// Dump and trace objects.
			Dump.BSButtonHintBar_Trace(ButtonHintBar_mc);
			Dump.BSButtonHintData_Trace(ButtonRun);
			Dump.BSButtonHintData_Trace(ButtonUnload);
		}


		private function OnButtonUnload():void
		{
			Debug.WriteLine("[CommandPanel]", "(OnButtonUnload)");
		}


		private function OnButtonRun():void
		{
			Debug.WriteLine("[CommandPanel]", "(OnButtonRun)");
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
			Debug.WriteLine("[CommandPanel]", "(SetData)");

			if (CommandList_mc.entryList != null)
			{
				if (argument != null)
				{
					var entry:CommandListEntry = ToUnitListEntry(argument);
					CommandList_mc.entryList.push(entry);

					if (rest != null)
					{
						for (var index:uint = 0; index < rest.length; index++)
						{
							var data = rest[index];
							entry = ToUnitListEntry(data);
							CommandList_mc.entryList.push(entry);
						}
					}
					else
					{
						Debug.WriteLine("[CommandPanel]", "(SetData)", "Argument:", entry);
					}
				}
				else
				{
					Debug.WriteLine("[CommandPanel]", "(SetData)", "The argument was null.");
				}

				CommandList_mc.InvalidateData();
				CommandList_mc.selectedIndex = 0;
			}
			else
			{
				Debug.WriteLine("[CommandPanel]", "(SetData)", "The `CommandList_mc.entryList` was null.");
			}
		}


		// Converts a papyrus data object into a unit list entry.
		private function ToUnitListEntry(argument:Object):CommandListEntry
		{
			// Debug.WriteLine("[CommandPanel]", "(ToUnitListEntry)");
			// Utility.TraceObject(argument);

			try
			{
				var sType:String = argument["__struct__"]["__type__"];
				var sName:String = argument["__struct__"]["__data__"]["Name"];
				var sDescription:String = argument["__struct__"]["__data__"]["Description"];
			}
			catch (error:Error)
			{
				Debug.WriteLine("[CommandPanel]", "(ToUnitListEntry)", "Error:", error.toString());
			}

			var entry:CommandListEntry = NewEntry(sType, sName, sDescription);
			entry.Text = sType;
			entry.Name = sName;
			entry.Description = sDescription;

			Debug.WriteLine("[CommandPanel]", "(ToUnitListEntry)", entry.toString());
			return entry;
		}


		// Creates a new unit list entry.
		private static function NewEntry(sText:String, sName:String, sDescription:String):CommandListEntry
		{
			Debug.WriteLine("[CommandPanel]", "(NewEntry)", "sText:"+sText, "sName:"+sName, "sDescription:"+sDescription);
			var entry:CommandListEntry = new CommandListEntry();
			entry.Text = sText;
			entry.Name = sName;
			entry.Description = sDescription;
			return entry;
		}


	}
}
