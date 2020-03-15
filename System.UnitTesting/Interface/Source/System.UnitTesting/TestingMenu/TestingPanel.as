package
{
	import Shared.AS3.BSScrollingList;
	import Shared.AS3.BSUIComponent;
	import System.Diagnostics.Debug;
	import flash.events.Event;
	import flash.text.TextField;

	public class TestingPanel extends BSUIComponent
	{
		// // Stage
		public var UnitList_mc:UnitList;


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
				UnitList_mc.numListItems = 10;
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
			// stage.focus = UnitList_mc;

			try
			{
				UnitList_mc.onComponentInit(new Event(Event.INIT));
				UnitList_mc.SetPlatform(0, false);
				UnitList_mc.selectedIndex = 0;
				UnitList_mc.disableInput = false;
				UnitList_mc.disableSelection = false;
				UnitList_mc.filterer.filterArray = new Array();
				UnitList_mc.filterer.itemFilter = UnitList_mc.filterer.filterArray[0].flag;

				UnitList_mc.entryList.push(NewEntry("Derp"));
				UnitList_mc.entryList.push(NewEntry("Derp"));
				UnitList_mc.entryList.push(NewEntry("Derp"));
				UnitList_mc.entryList.push(NewEntry("Derp"));
				UnitList_mc.entryList.push(NewEntry("Derp"));
				UnitList_mc.entryList.push(NewEntry("Derp"));
				UnitList_mc.entryList.push(NewEntry("Derp"));
				UnitList_mc.entryList.push(NewEntry("Derp"));
				UnitList_mc.entryList.push(NewEntry("Derp"));
				UnitList_mc.entryList.push(NewEntry("Derp"));
				UnitList_mc.entryList.push(NewEntry("Derp"));
				UnitList_mc.entryList.push(NewEntry("Derp"));

				UnitList_mc.InvalidateData();
				UnitList_mc.selectedIndex = 0;
			}
			catch (error:Error)
			{
				Debug.WriteLine("[TestingPanel]", "(TestList)", "Error:", error.toString());
			}
		}


		// Methods
		//---------------------------------------------

		private function NewEntry(text:String):UnitListEntry
		{
			Debug.WriteLine("[TestingPanel]", "(NewEntry)");
			var entry:UnitListEntry = new UnitListEntry();
			entry.text = text;
			return entry;
		}


	}
}
