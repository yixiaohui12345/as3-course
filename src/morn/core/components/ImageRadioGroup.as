package morn.core.components 
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author yxh
	 */
	public class ImageRadioGroup extends Group
	{
		/**横向的*/
		public static const HORIZENTAL:String = "horizontal";
		/**纵向的*/
		public static const VERTICAL:String = "vertical";
		
		protected var _images:String = null;
		
		public function ImageRadioGroup(images:String=null) 
		{
			this.images = images;
			_direction = HORIZENTAL;
		}
		
		public function set images(value:String):void
		{
			if (_images != value)
			{
				_images = value;
				removeAllChild();
				callLater(changeImages);
				if (Boolean(_images))
				{
					var a:Array = _images.split(",");
					for (var i:int = 0, n:int = a.length; i < n; i++)
					{
						var item:DisplayObject = createItem(a[i], "");
						item.name = "item" + i;
						addChild(item);
					}
				}
				initItems();
			}
		}
		
		override protected function createItem(skin:String, label:String):DisplayObject
		{
			return new Button(skin, label);
		}
		
		protected function changeImages():void
		{
			if (_items)
			{
				var left:Number = 0;
				for (var i:int = 0, n:int = _items.length; i < n; i++)
				{
					var button:Button = _items[i] as Button;
					if (_direction == HORIZENTAL)
					{
						button.y = 0;
						button.x = left;
						left += button.width + _space;
					}
					else
					{
						button.x = 0;
						button.y = left;
						left += button.height + _space;
					}
				}
			}
		}
		
		/**布局方向*/
		override public function get direction():String {
			return _direction;
		}
		
		override public function set direction(value:String):void {
			_direction = value;
			callLater(changeImages);
		}
		
		/**间隔*/
		override public function get space():Number {
			return _space;
		}
		
		override public function set space(value:Number):void {
			_space = value;
			callLater(changeImages);
		}
		
		override public function commitMeasure():void {
			exeCallLater(changeImages);
		}
		
		public function set toolTips(value:Object):void
		{
			if (value)
			{
				var a:Array = String(value).split(",");
				if (_items)
				{
					for (var i:int = 0, n:int = _items.length; i < n; i++)
					{
						var button:Button = _items[i] as Button;
						button.toolTip = a[i];
					}
				}
			}
		}
	}

}