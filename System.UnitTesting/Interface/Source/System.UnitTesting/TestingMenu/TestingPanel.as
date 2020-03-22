package
{
	import Shared.AS3.BSScrollingList;
	import Shared.AS3.BSUIComponent;
	import System.Diagnostics.Debug;
	import System.Diagnostics.Utility;
	import flash.events.Event;
	import flash.text.TextField;

	public class TestingPanel extends BSUIComponent
	{
		// List
		public var UnitList_mc:UnitList;

		// Selected
		public var SelectedScript_tf:TextField;
		public var SelectedName_tf:TextField;
		public var SelectedDescription_tf:TextField;


		// Initialization
		//---------------------------------------------

		public function TestingPanel()
		{
			Debug.WriteLine("[TestingPanel]", "(CTOR)");
			addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);

			try
			{
				UnitList_mc["componentInspectorSetting"] = true;
				UnitList_mc.listEntryClass = "UnitListEntry";
				UnitList_mc.numListItems = 0;
				UnitList_mc.restoreListIndex = true;
				UnitList_mc.textOption = BSScrollingList.TEXT_OPTION_NONE;
				UnitList_mc.verticalSpacing = -3;
				UnitList_mc["componentInspectorSetting"] = false;
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingPanel]", "(CTOR)", "ERROR:", error.toString());
			}
		}


		private function OnAddedToStage(e:Event):void
		{
			Debug.WriteLine("[TestingPanel]", "(OnAddedToStage)");
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
				Debug.WriteLine("[TestingPanel]", "(OnAddedToStage)", "Error:", error.toString());
			}
		}


		// List
		//---------------------------------------------

		private function OnItemPress(e:Event):void
		{
			Debug.WriteLine("[TestingPanel]", "(OnItemPress)", e.toString());
			UnitList_mc.selectedEntry.Icon_mc.Pass();
		}


		private function OnSelectionChange(e:Event):void
		{
			Debug.WriteLine("[TestingPanel]", "(OnSelectionChange)", e.toString(), UnitList_mc.selectedEntry.toString());

			SelectedScript_tf.text = UnitList_mc.selectedEntry.Text;
			SelectedName_tf.text = UnitList_mc.selectedEntry.Name;
			SelectedDescription_tf.text = UnitList_mc.selectedEntry.Description;

			UnitList_mc.selectedEntry.Icon_mc.Pass();
		}


		// Methods
		//---------------------------------------------

		// @Papyrus
		public function SetData(argument:Object, ... rest):void
		{
			Debug.WriteLine("[TestingPanel]", "(SetData)");

			UnitList_mc.onComponentInit(new Event(Event.INIT));
			UnitList_mc.SetPlatform(0, false);
			UnitList_mc.selectedIndex = 0;
			UnitList_mc.disableInput = false;
			UnitList_mc.disableSelection = false;

			// try
			// {
			// 	UnitList_mc.ClearEntries();
			// }
			// catch (error:Error)
			// {
			// 	Debug.WriteLine("[TestingPanel]", "(SetData)", "List-Clear", "Error:", error.toString());
			// }

			try
			{
				if (argument != null)
				{
					UnitList_mc.entryList.push(ToUnitListEntry(argument));
				}
				else
				{
					Debug.WriteLine("[TestingPanel]", "(SetData)", "The argument was null.");
				}
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingPanel]", "(SetData)", "Set Argument", "Error:", error.toString());
			}

			try
			{
				if (rest != null)
				{
					for (var index:uint = 0; index < rest.length; index++)
					{
						var data = rest[index];
						UnitList_mc.entryList.push(ToUnitListEntry(data));
					}
				}
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingPanel]", "(SetData)", "Set Rest", "Error:", error.toString());
			}

			try
			{
				UnitList_mc.InvalidateData();
				// UnitList_mc.selectedIndex = 0;
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingPanel]", "(SetData)", "List-Update", "Error:", error.toString());
			}
		}


		private function ToUnitListEntry(argument:Object):UnitListEntry
		{
			Debug.WriteLine("[TestingPanel]", "(ToUnitListEntry)", "Tracing argument...");
			Utility.TraceObject(argument);

			var entry:UnitListEntry = new UnitListEntry();

			try
			{
				var sType:String = argument["__struct__"]["__type__"];
				var sName:String = argument["__struct__"]["__data__"]["Name"];
				var sDescription:String = argument["__struct__"]["__data__"]["Description"];

				entry.Text = sType;
				entry.Name = sName;
				entry.Description = sDescription;
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingPanel]", "(ToUnitListEntry)", "Error:", error.toString());
			}

			Debug.WriteLine("[TestingPanel]", "(ToUnitListEntry)", entry.toString());
			return entry;
		}


	}
}
