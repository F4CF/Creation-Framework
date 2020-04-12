package
{

	import Shared.AS3.BSScrollingList;
	import Shared.AS3.BSScrollingListEntry;
	import Shared.AS3.BSUIComponent;
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
		}


		public function OnDisplayLoaded(e:Event):void
		{
			Debug.WriteLine("[CommandPanel]", "(OnDisplayLoaded)");
			SetupUnitList();
		}


		// List
		//---------------------------------------------

		private function SetupUnitList():void
		{
			Debug.WriteLine("[CommandPanel]", "(SetupUnitList)");
			// stage.stageFocusRect = false;
			// stage.focus = CommandList_mc;

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


		private function OnItemPress(e:Event):void
		{
			Debug.WriteLine("[CommandPanel]", "(OnItemPress)", e.toString());
			if (CommandList_mc.selectedEntry != null)
			{
				SelectionHandler(CommandList_mc.selectedEntry as CommandListEntry);
				(this.parent as SystemConsole).RunBatch((CommandList_mc.selectedEntry as CommandListEntry).Name);
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
				Dump.BSScrollingListEntry_Trace(entry as BSScrollingListEntry);
			}
			else
			{
				Debug.WriteLine("[CommandPanel]", "(SelectionHandler)", "Error:", "The unit list entry is null.");
			}
		}


		// Methods
		//---------------------------------------------

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
