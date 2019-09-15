package morn.core.components.extension 
{
	import flash.display.DisplayObject;
	import morn.core.components.Box;
	import morn.core.components.Group;
	import morn.core.components.ISelect;
	import morn.core.handlers.Handler;
	/**
	 * ...
	 * @author yxh
	 */
	public class TabClip extends Group
	{
		public static const HORIZENTAL:String = "horizontal";
		/**纵向的*/
		public static const VERTICAL:String = "vertical";
		
		protected var _sources:Object = null;
		
		public function TabClip(sources:Object = null, skin:String = null) 
		{
			this.skin = skin;
			this.sources = sources;
			_direction = HORIZENTAL;
		}
		
		override public function set labelColors(value:String):void {
			if (_labelColors != value) {
				_labelColors = value;
				callLater(changeItem);
			}
		}
		
		public function get sources():Object 
		{
			return _sources;
		}
		
		public function set sources(value:Object):void 
		{
			if (_sources!= value)
			{
				_sources = value;
				removeAllChild();
				if (value&&value is Array)
				{
					var a:Array = value as Array
					for (var i:int = 0, n:int = a.length; i < n; i++)
					{
						var item:DisplayObject = createRenderItem(_skin, value[i]);
						item.name = "item" + i;
						addChild(item);
					}
				}
				initItems();
			}
		}
		
		protected function createRenderItem(skin:String, source:Object):DisplayObject
		{
			return new ButtonClip(skin, source.label, source.iconSkin);
		}
		
		override protected function createItem(skin:String, label:String):DisplayObject {
			return null;
		}
		
		override public function commitMeasure():void {
			exeCallLater(changeItem);
		}
		
		protected function changeItem():void
		{
			if (_items)
			{
				var left:Number = 0;
				for (var i:int = 0, n:int = _items.length; i < n; i++)
				{
					var btn:ButtonClip = _items[i] as ButtonClip;
					if (_skin)
					{
						if (_labelColors)
						{
							btn.labelColors = _labelColors;
						}
						if (_direction == HORIZENTAL)
						{
							btn.y = 0;
							btn.x = left;
							left += btn.width + _space;
						}
						else
						{
							btn.x = 0;
							btn.y = left;
							left += btn.height + _space;
						}
					}
				}
			}
		}
		
		override public function get skin():String 
		{
			return _skin;
		}
		
		override public function set skin(value:String):void 
		{
			if (_skin != value) 
			{
				_skin = value;
				callLater(changeItem)
			}
			
		}
		
	}

}