package morn.core.components.law 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import morn.core.components.Group;
	/**
	 * ...
	 * @author yxh
	 */
	public class EGrid extends Group
	{
		private var list:Array = [];
		private var GRID_SIZE:int = 16;
		
		public function EGrid() 
		{
			this.mouseEnabled = false;
			for (var i:int = 0; i < 8; i++)
			{
				var item:Sprite = getRectShape();
				item.name = "item" + String(i + 1);
				addChild(item);
				list.push(item);
			}
		}
		
		public function setNewPosition():void
		{
			list[0].x =0
			list[0].y =0
			
			list[1].x = width*0.5
			list[1].y =0
			
			list[2].x = width
			list[2].y =0
			
			list[3].x =0
			list[3].y = height * 0.5;
			
			list[4].x = width
			list[4].y = height * 0.5;
			
			list[5].x =0
			list[5].y = height
			
			list[6].x = width * 0.5;
			list[6].y = height
			
			list[7].x = width
			list[7].y = height
			
			graphics.clear();
			graphics.lineStyle(1, 0xff0000);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
			
			graphics.beginFill(0, 0);
			graphics.lineStyle(1, 0xf2f2f2,0);
			graphics.drawRect( -16, -16, width + 32, height + 32);
			graphics.endFill();
		}
		
		public function set editState(value:Boolean):void
		{
			for (var i:int = 0; i < 8; i++)
			{
				list[i] && (list[i].visible = value)
			}
		}
		
		private function handleDelete(e:MouseEvent):void 
		{
			if (this.parent &&this.parent&& this.parent.parent is EPage)
			{
				var p:EPage = EPage(this.parent.parent);
				var c:EComponent = this.parent as EComponent;
				p.removeElement(c);
			}
		}
		
		private function getRectShape():Sprite
		{
			var item:Sprite = new Sprite();
			item.graphics.lineStyle(0.5, 0xFF3300);
			item.graphics.beginFill(0xffffff)
			item.graphics.drawCircle(0,0, GRID_SIZE*0.5);
			item.graphics.endFill();
			return item;
		}
		
		override public function set height(value:Number):void
		{
			if (_height != value)
			{
				_height = value;
				callLater(setNewPosition);
			}
		}
		
		override public function set width(value:Number):void
		{
			if (_width != value)
			{
				_width = value;
				callLater(setNewPosition);
			}
		}
		
		override public function dispose():void
		{
			for (var i:int = 0; i < 8; i++)
			{
				list[i].parent.removeChild(list[i]);
				list[i] = null;
			}
			list.length = 0;
			list = null;
			graphics.clear();
		}
	}
}