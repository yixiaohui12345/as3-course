package morn.core.components 
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author yxh
	 */
	public class FreeTab extends Tab
	{
		protected var _row:int=5
		
		public function FreeTab(labels:String = null, skin:String = null) 
		{
			super(labels, skin);
		}
		
		override protected function createItem(skin:String, label:String):DisplayObject {
			return new Button(skin, label);
		}
		
		override protected function changeLabels():void {
			if (_items)
			{
				var left:Number = 0;
				if (row > 0)
				{
					var column:int = Math.ceil(_items.length / row);
					var total:int = _items.length;
					for (var i:int = 0;  i < column; i++)
					{
						for (var j:int = 0; j < row; j++)
						{
							if (i * row + j >= total)
							{
								break;
							}
							var btn:Button = _items[i*row+j] as Button;
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
							btn.y = i * btn.height+space;
							btn.x = j * btn.width;
						}
					}
				
				}
			}
		}
		
		public function get row():int 
		{
			return _row;
		}
		
		public function set row(value:int):void 
		{
			if(_row != value)
			{
				callLater(changeLabels);
			}
		}
		
	}

}