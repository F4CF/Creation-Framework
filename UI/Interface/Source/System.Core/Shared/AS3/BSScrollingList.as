package Shared.AS3
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.getDefinitionByName;
	import Mobile.ScrollList.EventWithParams;
	import Mobile.ScrollList.MobileListItemRenderer;
	import Mobile.ScrollList.MobileScrollList;
	import Shared.AS3.COMPANIONAPP.BSScrollingListInterface;
	import Shared.AS3.COMPANIONAPP.CompanionAppMode;
	import Shared.PlatformChangeEvent;

	public class BSScrollingList extends MovieClip
	{
		public var ScrollUp:MovieClip;
		public var ScrollDown:MovieClip;
		public var border:MovieClip;
		public var scrollList:MobileScrollList;

		protected var EntryHolder_mc:MovieClip;
		protected var fListHeight:Number;
		protected var bMouseDrivenNav:Boolean;
		protected var iPlatform:Number;
		protected var bReverseList:Boolean;
		protected var bUpdated:Boolean;

		public static const TEXT_OPTION_NONE:String = "None";
		public static const TEXT_OPTION_SHRINK_TO_FIT:String = "Shrink To Fit";
		public static const TEXT_OPTION_MULTILINE:String = "Multi-Line";

		public static const SELECTION_CHANGE:String = "BSScrollingList::selectionChange";
		public static const ITEM_PRESS:String = "BSScrollingList::itemPress";
		public static const LIST_PRESS:String = "BSScrollingList::listPress";
		public static const LIST_ITEMS_CREATED:String = "BSScrollingList::listItemsCreated";
		public static const PLAY_FOCUS_SOUND:String = "BSScrollingList::playFocusSound";
		public static const MOBILE_ITEM_PRESS:String = "BSScrollingList::mobileItemPress";


		// Properties
		//---------------------------------------------

		private function get needMobileScrollList():Boolean { return CompanionAppMode.isOn; }

		protected var bInitialized:Boolean;
		public function get initialized():Boolean { return bInitialized; }

		protected var iListItemsShown:uint;
		public function get itemsShown():uint { return iListItemsShown; }

		protected var _filterer:ListFilterer;
		public function get filterer():ListFilterer { return _filterer; }
		public function set filterer(value:ListFilterer):* { _filterer = value; }

		protected var iSelectedIndex:int;
		public function get selectedIndex():int { return iSelectedIndex; }
		public function set selectedIndex(value:int):* { doSetSelectedIndex(value); }


		public function get selectedEntry():Object { return EntriesA[iSelectedIndex]; }

		protected var EntriesA:Array;
		public function get entryList():Array { return EntriesA; }
		public function set entryList(value:Array):*
		{
			EntriesA = value;
			if(EntriesA == null)
			{
				EntriesA = new Array();
			}
		}

		protected var iSelectedClipIndex:int;
		public function get selectedClipIndex():int { return iSelectedClipIndex; }
		public function set selectedClipIndex(value:int):* { doSetSelectedIndex(GetEntryFromClipIndex(value)); }

		protected var fShownItemsHeight:Number;
		public function get shownItemsHeight():Number { return fShownItemsHeight; }

		protected var iMaxScrollPosition:uint;
		public function get maxScrollPosition():uint { return iMaxScrollPosition; }

		protected var iScrollPosition:uint;
		public function get scrollPosition():uint { return iScrollPosition; }
		public function set scrollPosition(value:uint):*
		{
			if(value != iScrollPosition && value >= 0 && value <= iMaxScrollPosition)
			{
				updateScrollPosition(value);
			}
		}

		protected var bDisableInput:Boolean;
		public function get disableInput():Boolean { return bDisableInput; }
		public function set disableInput(value:Boolean):* { bDisableInput = value; }

		protected var strTextOption:String;
		public function get textOption():String { return strTextOption; }
		public function set textOption(value:String):* { strTextOption = value; }

		protected var fVerticalSpacing:Number;
		public function get verticalSpacing():* { return fVerticalSpacing; }
		public function set verticalSpacing(value:Number):* { fVerticalSpacing = value; }

		protected var uiNumListItems:uint;
		public function get numListItems():uint { return uiNumListItems; }
		public function set numListItems(value:uint):* { uiNumListItems = value; }

		protected var bRestoreListIndex:Boolean;
		public function get restoreListIndex():Boolean { return bRestoreListIndex; }
		public function set restoreListIndex(value:Boolean):* { bRestoreListIndex = value; }

		protected var bDisableSelection:Boolean;
		public function get disableSelection():Boolean { return bDisableSelection; }
		public function set disableSelection(value:Boolean):* { bDisableSelection = value; }

		protected var bAllowSelectionDisabledListNav:Boolean;
		public function set allowWheelScrollNoSelectionChange(value:Boolean):* { bAllowSelectionDisabledListNav = value; }

		protected var ListEntryClass:Class;
		private var _itemRendererClassName:String;
		public function set listEntryClass(className:String):*
		{
			ListEntryClass = getDefinitionByName(className) as Class;
			_itemRendererClassName = className;
		}


		// BSScrollingList
		//---------------------------------------------

		public function BSScrollingList()
		{
			trace("BSScrollingList::ctor");
			super();
			EntriesA = new Array();

			_filterer = new ListFilterer();
			addEventListener(ListFilterer.FILTER_CHANGE, this.onFilterChange);

			strTextOption = TEXT_OPTION_NONE;
			fVerticalSpacing = 0;
			uiNumListItems = 0;
			bRestoreListIndex = true;
			bDisableSelection = false;
			bAllowSelectionDisabledListNav = false;
			bDisableInput = false;
			bMouseDrivenNav = false;
			bReverseList = false;
			bUpdated = false;
			bInitialized = false;

			if(loaderInfo != null)
			{
				loaderInfo.addEventListener(Event.INIT, this.onComponentInit);
			}

			addEventListener(Event.ADDED_TO_STAGE, this.onStageInit);
			addEventListener(Event.REMOVED_FROM_STAGE, this.onStageDestruct);
			addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
			addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);

			if(!needMobileScrollList)
			{
				addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
			}

			if(border == null)
			{
				throw new Error("No \'border\' clip found.  BSScrollingList requires a border rect to define its extents.");
			}

			EntryHolder_mc = new MovieClip();
			addChildAt(EntryHolder_mc, getChildIndex(border) + 1);
			iSelectedIndex = -1;
			iSelectedClipIndex = -1;
			iScrollPosition = 0;
			iMaxScrollPosition = 0;
			iListItemsShown = 0;
			fListHeight = 0;
			iPlatform = 1;
		}


		// Events
		//---------------------------------------------

		public function onComponentInit(e:Event):*
		{
			trace("BSScrollingList::onComponentInit");
			if(needMobileScrollList)
			{
				createMobileScrollingList();
				if(border != null)
				{
					border.alpha = 0;
				}
			}
			if(loaderInfo != null)
			{
				loaderInfo.removeEventListener(Event.INIT, this.onComponentInit);
			}
			if(!bInitialized)
			{
				SetNumListItems(uiNumListItems);
			}
		}


		protected function onStageInit(e:Event):*
		{
			trace("BSScrollingList::onStageInit");
			stage.addEventListener(PlatformChangeEvent.PLATFORM_CHANGE, this.onSetPlatform);
			if(!bInitialized)
			{
				SetNumListItems(uiNumListItems);
			}
			if(ScrollUp != null && !CompanionAppMode.isOn)
			{
				ScrollUp.addEventListener(MouseEvent.CLICK, this.onScrollArrowClick);
			}
			if(ScrollDown != null && !CompanionAppMode.isOn)
			{
				ScrollDown.addEventListener(MouseEvent.CLICK, this.onScrollArrowClick);
			}
		}


		protected function onStageDestruct(e:Event):*
		{
			trace("BSScrollingList::onStageDestruct");
			stage.removeEventListener(PlatformChangeEvent.PLATFORM_CHANGE, this.onSetPlatform);
			if(needMobileScrollList)
			{
				destroyMobileScrollingList();
			}
		}


		public function onScrollArrowClick(e:Event):*
		{
			if(!bDisableInput && (!bDisableSelection || bAllowSelectionDisabledListNav))
			{
				doSetSelectedIndex(-1);
				if(e.target == ScrollUp || e.target.parent == ScrollUp)
				{
					scrollPosition = scrollPosition - 1;
				}
				else if(e.target == ScrollDown || e.target.parent == ScrollDown)
				{
					scrollPosition = scrollPosition + 1;
				}
				e.stopPropagation();
			}
		}


		public function onEntryRollover(e:Event):*
		{
			var index:* = undefined;
			bMouseDrivenNav = true;
			if(!bDisableInput && !bDisableSelection)
			{
				index = iSelectedIndex;
				doSetSelectedIndex((e.currentTarget as BSScrollingListEntry).itemIndex);
				if(index != iSelectedIndex)
				{
					dispatchEvent(new Event(PLAY_FOCUS_SOUND, true, true));
				}
			}
		}


		public function onEntryPress(e:MouseEvent):*
		{
			e.stopPropagation();
			bMouseDrivenNav = true;
			onItemPress();
		}


		public function onKeyDown(e:KeyboardEvent):*
		{
			if(!bDisableInput)
			{
				if(e.keyCode == Keyboard.UP)
				{
					moveSelectionUp();
					e.stopPropagation();
				}
				else if(e.keyCode == Keyboard.DOWN)
				{
					moveSelectionDown();
					e.stopPropagation();
				}
			}
		}


		public function onKeyUp(e:KeyboardEvent):*
		{
			if(!bDisableInput && !bDisableSelection && e.keyCode == Keyboard.ENTER)
			{
				onItemPress();
				e.stopPropagation();
			}
		}


		public function onMouseWheel(e:MouseEvent):*
		{
			var position:* = undefined;
			if(!bDisableInput && (!bDisableSelection || bAllowSelectionDisabledListNav) && iMaxScrollPosition > 0)
			{
				position = scrollPosition;
				if(e.delta < 0)
				{
					scrollPosition = scrollPosition + 1;
				}
				else if(e.delta > 0)
				{
					scrollPosition = scrollPosition - 1;
				}
				SetFocusUnderMouse();
				e.stopPropagation();
				if(position != scrollPosition)
				{
					dispatchEvent(new Event(PLAY_FOCUS_SOUND, true, true));
				}
			}
		}


		public function onFilterChange():*
		{
			iSelectedIndex = _filterer.ClampIndex(iSelectedIndex);
			CalculateMaxScrollPosition();
		}


		protected function onItemPress():*
		{
			if(!bDisableInput && !bDisableSelection && iSelectedIndex != -1)
			{
				dispatchEvent(new Event(ITEM_PRESS,true,true));
			}
			else
			{
				dispatchEvent(new Event(LIST_PRESS,true,true));
			}
		}


		protected function onSetPlatform(e:Event):*
		{
			trace("BSScrollingList::onSetPlatform");
			var event:PlatformChangeEvent = e as PlatformChangeEvent;
			SetPlatform(event.uiPlatform, event.bPS3Switch);
		}


		// Functions
		//---------------------------------------------

		public function ClearList():*
		{
			trace("BSScrollingList::ClearList");
			EntriesA.splice(0, EntriesA.length);
		}

		public function GetClipByIndex(index:uint):BSScrollingListEntry
		{
			return index < EntryHolder_mc.numChildren?EntryHolder_mc.getChildAt(index) as BSScrollingListEntry:null;
		}

		public function GetEntryFromClipIndex(index:int):int
		{
			var result:int = -1;
			var i:uint = 0;
			while(i < EntriesA.length)
			{
				if(EntriesA[i].clipIndex <= index)
				{
					result = i;
				}
				i++;
			}
			return result;
		}

		private function SetFocusUnderMouse():*
		{
			var entry:BSScrollingListEntry = null;
			var entryBorder:MovieClip = null;
			var point:Point = null;
			var i:int = 0;
			while(i < iListItemsShown)
			{
				entry = GetClipByIndex(i);
				entryBorder = entry.border;
				point = localToGlobal(new Point(mouseX, mouseY));
				if(entry.hitTestPoint(point.x, point.y, false))
				{
					selectedIndex = entry.itemIndex;
				}
				i++;
			}
		}

		protected function doSetSelectedIndex(index:int):*
		{
			trace("BSScrollingList::doSetSelectedIndex -- index:"+index);
			var selected:int = 0;
			var _loc3_:Boolean = false;
			var _loc4_:int = 0;
			var entry:BSScrollingListEntry = null;
			var _loc6_:int = 0;
			var _loc7_:int = 0;
			var _loc8_:int = 0;
			var _loc9_:int = 0;
			var _loc10_:int = 0;
			var _loc11_:uint = 0;

			if(!bInitialized || numListItems == 0)
			{
				trace("BSScrollingList::doSetSelectedIndex -- Can\'t set selection before list has been created.");
			}

			if(!bDisableSelection && index != iSelectedIndex)
			{
				selected = iSelectedIndex;
				iSelectedIndex = index;

				if(EntriesA.length == 0)
				{
					iSelectedIndex = -1;
				}

				if(selected != -1 && selected < EntriesA.length && EntriesA[selected].clipIndex != int.MAX_VALUE)
				{
					SetEntry(GetClipByIndex(EntriesA[selected].clipIndex), EntriesA[selected]);
				}

				if(iSelectedIndex != -1)
				{
					iSelectedIndex = _filterer.ClampIndex(iSelectedIndex);
					if(iSelectedIndex == int.MAX_VALUE)
					{
						iSelectedIndex = -1;
					}

					if(iSelectedIndex != -1 && selected != iSelectedIndex)
					{
						_loc3_ = false;
						if(textOption == TEXT_OPTION_MULTILINE)
						{
							_loc4_ = GetEntryFromClipIndex(uiNumListItems - 1);
							if(_loc4_ != -1 && _loc4_ == iSelectedIndex && EntriesA[_loc4_].clipIndex != int.MAX_VALUE)
							{
								entry = GetClipByIndex(EntriesA[_loc4_].clipIndex);
								if(entry != null && entry.y + entry.height > fListHeight)
								{
									_loc3_ = true;
								}
							}
						}

						if(EntriesA[iSelectedIndex].clipIndex != int.MAX_VALUE && !_loc3_)
						{
							SetEntry(GetClipByIndex(EntriesA[iSelectedIndex].clipIndex), EntriesA[iSelectedIndex]);
						}
						else
						{
							_loc6_ = GetEntryFromClipIndex(0);
							_loc7_ = GetEntryFromClipIndex(uiNumListItems - 1);
							_loc9_ = 0;
							if(iSelectedIndex < _loc6_)
							{
								_loc8_ = _loc6_;
								do
								{
									_loc8_ = _filterer.GetPrevFilterMatch(_loc8_);
									_loc9_--;
								}
								while(_loc8_ != iSelectedIndex);

							}
							else if(iSelectedIndex > _loc7_)
							{
								_loc8_ = _loc7_;
								do
								{
									_loc8_ = _filterer.GetNextFilterMatch(_loc8_);
									_loc9_++;
								}
								while(_loc8_ != iSelectedIndex);

							}
							else if(_loc3_)
							{
								_loc9_++;
							}
							scrollPosition = scrollPosition + _loc9_;
						}
					}

					if(needMobileScrollList)
					{
						if(scrollList != null)
						{
							if(iSelectedIndex != -1)
							{
								_loc10_ = EntriesA[iSelectedIndex].clipIndex;
								_loc11_ = 0;
								while(_loc11_ < scrollList.data.length)
								{
									if(EntriesA[iSelectedIndex] == scrollList.data[_loc11_])
									{
										_loc10_ = _loc11_;
										break;
									}
									_loc11_++;
								}
								scrollList.selectedIndex = _loc10_;
							}
							else
							{
								scrollList.selectedIndex = -1;
							}
						}
					}
				}

				if(selected != iSelectedIndex)
				{
					iSelectedClipIndex = iSelectedIndex != -1?int(EntriesA[iSelectedIndex].clipIndex):-1;
					dispatchEvent(new Event(SELECTION_CHANGE, true, true));
				}
			}
		}

		protected function updateScrollPosition(position:uint):*
		{
			iScrollPosition = position;
			UpdateList();
		}

		protected function SetNumListItems(count:uint):*
		{
			trace("BSScrollingList::SetNumListItems -- Count"+count);
			var i:uint = 0;
			var entry:MovieClip = null;
			if(ListEntryClass != null && count > 0)
			{
				i = 0;
				while(i < count)
				{
					entry = GetNewListEntry(i);
					if(entry != null)
					{
						entry.clipIndex = i;
						entry.addEventListener(MouseEvent.MOUSE_OVER, this.onEntryRollover);
						entry.addEventListener(MouseEvent.CLICK, this.onEntryPress);
						EntryHolder_mc.addChild(entry);
					}
					else
					{
						trace("BSScrollingList::SetNumListItems -- List Entry Class is invalid or does not derive from BSScrollingListEntry.");
					}
					i++;
				}
				bInitialized = true;
				dispatchEvent(new Event(LIST_ITEMS_CREATED, true, true));
			}
		}

		protected function GetNewListEntry(param1:uint):BSScrollingListEntry
		{
			return new ListEntryClass() as BSScrollingListEntry;
		}

		public function UpdateList():*
		{
			if(!bInitialized || numListItems == 0)
			{
				trace("BSScrollingList::UpdateList -- Can\'t update list before list has been created.");
			}
			var _loc1_:Number = 0;
			var _loc2_:Number = _filterer.ClampIndex(0);
			var _loc3_:Number = _loc2_;

			var index:uint = 0;

			index = 0;
			while(index < EntriesA.length)
			{
				EntriesA[index].clipIndex = int.MAX_VALUE;
				if(index < iScrollPosition)
				{
					_loc2_ = _filterer.GetNextFilterMatch(_loc2_);
				}
				index++;
			}

			index = 0;
			while(index < uiNumListItems)
			{
				var entry:BSScrollingListEntry = null;
				entry = GetClipByIndex(index);
				if(entry)
				{
					entry.visible = false;
					entry.itemIndex = int.MAX_VALUE;
				}
				index++;
			}

			var _loc6_:Vector.<Object> = new Vector.<Object>();
			this.iListItemsShown = 0;
			if(this.needMobileScrollList)
			{
				while(_loc3_ != int.MAX_VALUE && _loc3_ != -1 && _loc3_ < this.EntriesA.length && _loc1_ <= this.fListHeight)
				{
					_loc6_.push(this.EntriesA[_loc3_]);
					_loc3_ = this._filterer.GetNextFilterMatch(_loc3_);
				}
			}

			while(_loc2_ != int.MAX_VALUE && _loc2_ != -1 && _loc2_ < this.EntriesA.length && this.iListItemsShown < this.uiNumListItems && _loc1_ <= this.fListHeight)
			{
				var _loc8_:BSScrollingListEntry = null;
				_loc8_ = this.GetClipByIndex(this.iListItemsShown);
				if(_loc8_)
				{
					this.SetEntry(_loc8_,this.EntriesA[_loc2_]);
					this.EntriesA[_loc2_].clipIndex = this.iListItemsShown;
					_loc8_.itemIndex = _loc2_;
					_loc8_.visible = !this.needMobileScrollList;
					_loc1_ = _loc1_ + _loc8_.height;
					if(_loc1_ <= this.fListHeight && this.iListItemsShown < this.uiNumListItems)
					{
						_loc1_ = _loc1_ + this.fVerticalSpacing;
						this.iListItemsShown++;
					}
					else if(this.textOption != TEXT_OPTION_MULTILINE)
					{
						this.EntriesA[_loc2_].clipIndex = int.MAX_VALUE;
						_loc8_.visible = false;
					}
					else
					{
						this.iListItemsShown++;
					}
				}
				_loc2_ = this._filterer.GetNextFilterMatch(_loc2_);
			}

			if(this.needMobileScrollList)
			{
				this.setMobileScrollingListData(_loc6_);
			}

			this.PositionEntries();
			if(this.ScrollUp != null)
			{
				this.ScrollUp.visible = this.scrollPosition > 0;
			}

			if(this.ScrollDown != null)
			{
				this.ScrollDown.visible = this.scrollPosition < this.iMaxScrollPosition;
			}

			this.bUpdated = true;
		}

		protected function PositionEntries():*
		{
			var _loc1_:Number = 0;
			var _loc2_:Number = border.y;
			var index:int = 0;
			while(index < iListItemsShown)
			{
				GetClipByIndex(index).y = _loc2_ + _loc1_;
				_loc1_ = _loc1_ + (GetClipByIndex(index).height + fVerticalSpacing);
				index++;
			}
			fShownItemsHeight = _loc1_;
		}

		public function InvalidateData():*
		{
			var condition:Boolean = false;
			_filterer.filterArray = EntriesA;
			fListHeight = border.height;
			CalculateMaxScrollPosition();
			if(!restoreListIndex)
			{
				if(iSelectedIndex >= EntriesA.length)
				{
					iSelectedIndex = EntriesA.length - 1;
					condition = true;
				}
			}
			if(iScrollPosition > iMaxScrollPosition)
			{
				iScrollPosition = iMaxScrollPosition;
			}
			UpdateList();
			if(restoreListIndex && !needMobileScrollList)
			{
				selectedClipIndex = iSelectedClipIndex;
			}
			else if(condition)
			{
				dispatchEvent(new Event(SELECTION_CHANGE, true, true));
			}
		}

		public function UpdateSelectedEntry():*
		{
			if(iSelectedIndex != -1)
			{
				SetEntry(GetClipByIndex(EntriesA[iSelectedIndex].clipIndex),EntriesA[iSelectedIndex]);
			}
		}

		public function UpdateEntry(object:Object):*
		{
			SetEntry(GetClipByIndex(object.clipIndex), object);
		}

		protected function CalculateMaxScrollPosition():*
		{
			var _loc2_:Number = NaN;
			var _loc3_:int = 0;
			var _loc4_:int = 0;
			var _loc5_:int = 0;
			var _loc6_:int = 0;
			var _loc7_:int = 0;
			var _loc1_:int = !!this._filterer.EntryMatchesFilter(this.EntriesA[this.EntriesA.length - 1])?int(this.EntriesA.length - 1):int(this._filterer.GetPrevFilterMatch(this.EntriesA.length - 1));
			if(_loc1_ == int.MAX_VALUE)
			{
				this.iMaxScrollPosition = 0;
			}
			else
			{
				_loc2_ = this.GetEntryHeight(_loc1_);
				_loc3_ = _loc1_;
				_loc4_ = 1;
				while(_loc3_ != int.MAX_VALUE && _loc2_ < this.fListHeight && _loc4_ < this.uiNumListItems)
				{
					_loc5_ = _loc3_;
					_loc3_ = this._filterer.GetPrevFilterMatch(_loc3_);
					if(_loc3_ != int.MAX_VALUE)
					{
						_loc2_ = _loc2_ + (this.GetEntryHeight(_loc3_) + this.fVerticalSpacing);
						if(_loc2_ < this.fListHeight)
						{
							_loc4_++;
						}
						else
						{
							_loc3_ = _loc5_;
						}
					}
				}
				if(_loc3_ == int.MAX_VALUE)
				{
					this.iMaxScrollPosition = 0;
				}
				else
				{
					_loc6_ = 0;
					_loc7_ = this._filterer.GetPrevFilterMatch(_loc3_);
					while(_loc7_ != int.MAX_VALUE)
					{
						_loc6_++;
						_loc7_ = this._filterer.GetPrevFilterMatch(_loc7_);
					}
					this.iMaxScrollPosition = _loc6_;
				}
			}
		}

		protected function GetEntryHeight(index:Number):Number
		{
			var entry:BSScrollingListEntry = GetClipByIndex(0);
			var result:Number = 0;
			if(entry != null)
			{
				if(entry.hasDynamicHeight)
				{
					SetEntry(entry, EntriesA[index]);
					result = entry.height;
				}
				else
				{
					result = entry.defaultHeight;
				}
			}
			return result;
		}

		public function moveSelectionUp():*
		{
			var index:Number = NaN;
			if(!bDisableSelection || bAllowSelectionDisabledListNav)
			{
				if(selectedIndex > 0)
				{
					index = _filterer.GetPrevFilterMatch(selectedIndex);
					if(index != int.MAX_VALUE)
					{
						selectedIndex = index;
						bMouseDrivenNav = false;
						dispatchEvent(new Event(PLAY_FOCUS_SOUND, true, true));
					}
				}
			}
			else
			{
				scrollPosition = scrollPosition - 1;
			}
		}

		public function moveSelectionDown():*
		{
			var index:Number = NaN;
			if(!bDisableSelection || bAllowSelectionDisabledListNav)
			{
				if(selectedIndex < EntriesA.length - 1)
				{
					index = _filterer.GetNextFilterMatch(selectedIndex);
					if(index != int.MAX_VALUE)
					{
						selectedIndex = index;
						bMouseDrivenNav = false;
						dispatchEvent(new Event(PLAY_FOCUS_SOUND, true, true));
					}
				}
			}
			else
			{
				scrollPosition = scrollPosition + 1;
			}
		}

		protected function SetEntry(entry:BSScrollingListEntry, object:Object):*
		{
			if(entry != null)
			{
				entry.selected = object == selectedEntry;
				entry.SetEntryText(object, strTextOption);
			}
		}

		public function SetPlatform(uiPlatform:Number, bPS3Switch:Boolean):*
		{
			this.iPlatform = uiPlatform;
			this.bMouseDrivenNav = this.iPlatform == 0?true:false;
		}


		// Mobile
		//---------------------------------------------

		protected function createMobileScrollingList():void
		{
			var _loc1_:Number = NaN;
			var _loc2_:Number = NaN;
			var _loc3_:Number = NaN;
			var _loc4_:String = null;
			var _loc5_:Boolean = false;
			var _loc6_:Boolean = false;
			if(this._itemRendererClassName != null)
			{
				_loc1_ = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).maskDimension;
				_loc2_ = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).spaceBetweenButtons;
				_loc3_ = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).scrollDirection;
				_loc4_ = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).linkageId;
				_loc5_ = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).clickable;
				_loc6_ = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).reversed;
				this.scrollList = new MobileScrollList(_loc1_,_loc2_,_loc3_);
				this.scrollList.itemRendererLinkageId = _loc4_;
				this.scrollList.noScrollShortList = true;
				this.scrollList.clickable = _loc5_;
				this.scrollList.endListAlign = _loc6_;
				this.scrollList.textOption = this.strTextOption;
				this.scrollList.setScrollIndicators(this.ScrollUp,this.ScrollDown);
				this.scrollList.x = 0;
				this.scrollList.y = 0;
				addChild(this.scrollList);
				this.scrollList.addEventListener(MobileScrollList.ITEM_SELECT,this.onMobileScrollListItemSelected,false,0,true);
			}
		}

		protected function destroyMobileScrollingList():void
		{
			if(this.scrollList != null)
			{
				this.scrollList.removeEventListener(MobileScrollList.ITEM_SELECT,this.onMobileScrollListItemSelected);
				removeChild(this.scrollList);
				this.scrollList.destroy();
			}
		}

		protected function onMobileScrollListItemSelected(e:EventWithParams):void
		{
			var renderer:MobileListItemRenderer = e.params.renderer as MobileListItemRenderer;
			if(renderer.data == null)
			{
				return;
			}
			var _loc3_:int = renderer.data.id;
			var _loc4_:* = this.iSelectedIndex;
			this.iSelectedIndex = this.GetEntryFromClipIndex(_loc3_);

			var i:uint = 0;
			while(i < this.EntriesA.length)
			{
				if(this.EntriesA[i] == renderer.data)
				{
					this.iSelectedIndex = i;
					break;
				}
				i++;
			}

			if(!this.EntriesA[this.iSelectedIndex].isDivider)
			{
				if(_loc4_ != this.iSelectedIndex)
				{
					this.iSelectedClipIndex = this.iSelectedIndex != -1?int(this.EntriesA[this.iSelectedIndex].clipIndex):-1;
					dispatchEvent(new Event(SELECTION_CHANGE, true, true));
					if(this.scrollList.itemRendererLinkageId == BSScrollingListInterface.PIPBOY_MESSAGE_RENDERER_LINKAGE_ID)
					{
						this.onItemPress();
					}
					dispatchEvent(new Event(MOBILE_ITEM_PRESS, true, true));
				}
				else if(this.scrollList.itemRendererLinkageId == BSScrollingListInterface.RADIO_RENDERER_LINKAGE_ID || this.scrollList.itemRendererLinkageId == BSScrollingListInterface.QUEST_RENDERER_LINKAGE_ID || this.scrollList.itemRendererLinkageId == BSScrollingListInterface.QUEST_OBJECTIVES_RENDERER_LINKAGE_ID || this.scrollList.itemRendererLinkageId == BSScrollingListInterface.INVENTORY_RENDERER_LINKAGE_ID || this.scrollList.itemRendererLinkageId == BSScrollingListInterface.PIPBOY_MESSAGE_RENDERER_LINKAGE_ID)
				{
					this.onItemPress();
				}
			}
		}

		protected function setMobileScrollingListData(data:Vector.<Object>):void
		{
			if(data != null)
			{
				if(data.length > 0)
				{
					this.scrollList.setData(data);
				}
				else
				{
					this.scrollList.invalidateData();
				}
			}
			else
			{
				trace("setMobileScrollingListData::Error: No data received to display List Items!");
			}
		}


	}
}
