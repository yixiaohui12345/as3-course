package morn.core.components 
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author yxh
	 */
	public class SmartTab extends Tab
	{
		protected var _showNum:Number = Number.NaN;
		
		private var _open:Boolean = false;
		
		public function SmartTab(labels:String = null, skin:String = null) 
		{
			super(labels, skin);
		}
		
		override protected function createItem(skin:String, label:String):DisplayObject {
			return new Button(skin, label);
		}
		
		override protected function changeLabels():void {
			if (_items) {
				var left:Number = 0
				var top:Number = 0;
				for (var i:int = 0, n:int = _items.length; i < n; i++) 
				{
					trace(i);
					
					var btn:Button = _items[i] as Button;
					
					
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
					if (!isNaN(_showNum) )
					{
						if (i >= _showNum && !_open){
							btn.visible = false;
						}
						else{
							btn.visible = true;
						}
						btn.y= int(i / _showNum) * (btn.height + space);
						btn.x =int(i % _showNum) * (btn.width + space);
					}
				}
			}
		}
		
		public function get showNum():Number 
		{
			return _showNum;
		}
		
		public function set showNum(value:Number):void 
		{
			if (_showNum != value)
			{
				_showNum = value;
				callLater(changeLabels)
			}
		}
		
		public function get open():Boolean 
		{
			return _open;
		}
		
		public function set open(value:Boolean):void 
		{
			if (_open != value)
			{
				_open = value;
				callLater(changeLabels);
			}
		}
	}

}