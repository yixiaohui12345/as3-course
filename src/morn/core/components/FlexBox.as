package morn.core.components 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * 伸缩盒
	 * @author yxh
	 */
	public class FlexBox extends Group
	{
		protected var _blocks:Array = null;
		
		protected var _blockItems:Array = null;
		
		protected var _blockSpace:int = 0;

		public function FlexBox(labels:String=null,skin:String=null) 
		{
			this.labels = labels;
			this.skin = skin;
		}
		
		override protected function createItem(skin:String, label:String):DisplayObject {
			return new Button(skin,label);
		}
		
		/**初始化*/
		override public function initItems():void {
			_items = new Vector.<ISelect>();
			for (var i:int = 0; i < int.MAX_VALUE; i++) {
				var item:ISelect = getChildByName("item" + i) as ISelect;
				if (item == null) {
					break;
				}
				_items.push(item);
				item.selected = (i == _selectedIndex);
				(item as Button).addEventListener(MouseEvent.CLICK, onClickHandler);
			}
		}
		
		private function onClickHandler(e:MouseEvent):void
		{
			selectedIndex = int((e.currentTarget as Button).name.substr(4));
		}
		
		override protected function changeLabels():void
		{
			if (_items)
			{
				var left:Number = 0;
				for (var i:int = 0, n:int = _items.length; i < n; i++)
				{
					var btn:Button = _items[i] as Button;
					if (_skin)
						btn.skin = _skin;
					if (_skin)
						btn.skin = _skin;
					if (_labelColors)
						btn.labelColors = _labelColors;
					if (_labelStroke)
						btn.labelStroke = _labelStroke;
					if (_labelSize)
						btn.labelSize = _labelSize;
					if (_labelBold)
						btn.labelBold = _labelBold;
					if (_labelMargin)
						btn.labelMargin = _labelMargin;
					
					btn.y = left;
					btn.x = 0;
					if (_blockItems[i]&&_blockItems[i].parent)
					{
						_blockItems[i].y = left + btn.height + blockSpace;
						left += _blockItems[i].y + _blockItems[i].height + space;
					}
					else
					{
						left += btn.height + space;
					}
				}
				_contentWidth = btn.width;
				_contentHeight = left;
				sendEvent(Event.RESIZE);
			}
		}
		
		protected function createBlock(cls:Class):Component
		{
			var comp:Component = new cls();
			return comp;
		}
		
		public function get blocks():Array 
		{
			return _blocks;
		}
		
		public function set blocks(value:Array):void 
		{
			_blocks = value;
			if (value)
			{
				callLater(changeLabels);
				_blockItems = _blockItems || [];
				for (var i:int = 0, len:int = value.length; i < len; i++)
				{
					var item:DisplayObject = createBlock(value[i] as Class) as DisplayObject;
					item.name = "block" + i;
					_blockItems.push(item);
				}
			}
		}
		
		public function getBlocks(index:int):*
		{
			return _blockItems[index];
		}
		
		override protected function setSelect(index:int, selected:Boolean):void {
			if (_items && index > -1 && index < _items.length) {
				_items[index].selected = selected;
				if (_blockItems[index])
				{
					if (!selected)
					{
						_blockItems[index].remove();
					}
					else
					{
						addChild(_blockItems[index]);
					}
				}
				callLater(changeLabels);
			}
		}
		
		override public function set selectedIndex(value:int):void 
		{
			var temp:Boolean = (value == _selectedIndex);
			if (temp)
			{
				setSelect(_selectedIndex, false);
				_selectedIndex =-1;
			}
			else
			{
				setSelect(_selectedIndex, false);
				_selectedIndex = value;
				setSelect(_selectedIndex, true);
				sendEvent(Event.CHANGE);
				//兼容老版本
				sendEvent(Event.SELECT);
				if (_selectHandler != null) {
					_selectHandler.executeWith([_selectedIndex]);
				}
			}
		}
		
		public function get blockSpace():int 
		{
			return _blockSpace;
		}
		
		public function set blockSpace(value:int):void 
		{
			_blockSpace = value;
		}
	}

}