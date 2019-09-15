package morn.core.components.extension 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import morn.core.components.AutoBitmap;
	import morn.core.components.Component;
	import morn.core.components.Group;
	import morn.core.components.Image;
	/**
	 * ...
	 * @author yxh
	 */
	public class TabAuto extends Group
	{
		public static const HORIZENTAL:String = "horizontal";
		/**纵向的*/
		public static const VERTICAL:String = "vertical";
		
		protected var _sources:Object = null;
		
		protected var _selectors:Array = [];
		
		private var _backSkin:String = null;
		
		protected var _backBitmap:Image = null;
		
		public function TabAuto(sources:Object = null, skin:String = null) 
		{
			this.skin = skin;
			this.sources = sources;
			_direction = VERTICAL;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			addChildAt(_backBitmap = new Image(),0);
		}
		
		public function get sources():Object 
		{
			return _sources;
		}
		
		public function set sources(value:Object):void 
		{
			if (_sources != value)
			{
				_sources = value;
				removeAllChild();
				_selectors.length = 0;
				
				if (value && value is Array)
				{
					var a:Array = value as Array
					for (var i:int = 0, n:int = a.length; i < n; i++)
					{
						var item:DisplayObject = createItem(_skin, value[i].label);
						item.name = "item" + i;
						_selectors.push(value[i].itemRender);
						addChild(item);
					}
				}
				initItems();
			}
		}
		
		public function open(index:int):void
		{
			if (!this.contains(_selectors[index]))
			{
				selectedIndex = index;
			}
		}
		
		override protected function createItem(skin:String, label:String):DisplayObject {
			return new TabButton(skin, label);
		}
		
		override public function set selectedIndex(value:int):void
		{
			if (_selectedIndex != value)
			{
				setSelect(_selectedIndex, false);
				_selectedIndex = value;
				setSelect(_selectedIndex, true);
				sendEvent(Event.CHANGE)
			}
			else
			{
				setSelect(_selectedIndex, false);
				_selectedIndex =-1;
			}
		}
		
		override protected function setSelect(index:int, selected:Boolean):void {
			if (_items && index > -1 && index < _items.length) {
				_items[index].selected = selected;
				if (selected)
				{
					addChild(_selectors[index]);
					callLater(changeSelectors);
				}
				else
				{
					if (_selectors[index]&&_selectors[index] is Component)
					{
						Component(_selectors[index]).remove();
					}
					callLater(changeSelectors);
				}
				
			}
		}
		
		/**皮肤*/
		override public function get skin():String {
			return _skin;
		}
		
		override public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				callLater(changeSelectors);
			}
		}
		
		public function get backSkin():String 
		{
			return _backSkin;
		}
		
		public function set backSkin(value:String):void 
		{
			_backSkin = value;
			_backBitmap.url = value;
			_backBitmap.sizeGrid = "5,5,5,5";
			callLater(changeSelectors);
		}
		
		protected function changeSelectors():void
		{
			addChildAt(_backBitmap,0);
			if (items)
			{
				var left:Number = 0;
				for (var i:int = 0, n:int = _items.length; i < n; i++)
				{
					var btn:TabButton = _items[i] as TabButton;
					if (_direction == VERTICAL)
					{
						if (labelColors)
						{
							btn.labelColors = labelColors;
						}
						btn.x = 1.5;
						if (btn.selected)
						{
							btn.y = left;
							_selectors[i].y = btn.height + left;
							left = left + btn.height + _selectors[i].height + _space;
						}
						else
						{
							btn.y = left;
							left += btn.height + _space;
						}
						_backBitmap.setSize(width, left);
					}
				}
			}
		}
	}

}