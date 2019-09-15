package morn.core.components
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import morn.core.events.UIEvent;
	
	/**
	 * ...
	 * @author yxh
	 */
	public class ColorMixer extends Component
	{
		protected var _colorBlock:Sprite = null
		
		protected var colorArray:Array = [{r: 255, g: 0, b: 0}, {r: 255, g: 255, b: 0}, {r: 0, g: 255, b: 255}, {r: 0, g: 0, b: 255}, {r: 255, g: 0, b: 255}, {r: 255, g: 0, b: 0}]
		
		protected var _selectColor:uint
		
		protected var _overColor:uint
		
		public function ColorMixer()
		{
		
		}
		
		override public function dispose():void
		{
			_colorBlock = null;
		}
		
		override protected function createChildren():void
		{
			addChild(_colorBlock = new Sprite());
		}
		
		override protected function initialize():void
		{
			addEventListener(MouseEvent.CLICK, onClickEvent);
			addEventListener(MouseEvent.MOUSE_MOVE, onMoveEvent);
			drawMixer();
		}
		
		protected function drawMixer():void
		{
			for (var i:int = 0; i < 6; i++)
			{
				drawBlocks(colorArray[i].r, colorArray[i].g, colorArray[i].b);
			}
		}
		
		private function drawBlocks(r:int, g:int, b:int):void
		{
			var rr:int
			var gg:int;
			var bb:int;
			var color:int
			for (var j:int = 0; j < 200; j += 3)
			{
				for (var i:int = 0; i < 1530; i += 5)
				{
					if (i < 255)
					{
						g += 5;
					}
					else if (i < 510)
					{
						r -= 5;
					}
					else if (i < 765)
					{
						b += 5;
					}
					else if (i < 1020)
					{
						g -= 5;
					}
					else if (i < 1275)
					{
						r += 5;
					}
					else
					{
						b -= 5;
					}
					//i%6设置一个限制,也可以不设 
					if (i % 6 == 0)
					{
						rr = (128 - r) / (100 / j * 2);
						gg = (128 - g) / (100 / j * 2);
						bb = (128 - b) / (100 / j * 2);
						//将r,b,g转化为可用的颜色值 
						color = (r + rr) << 16 | (g + gg) << 8 | (b + bb)
						_colorBlock.graphics.beginFill(color);
						//(i/6)的值恰好是i/15的整数2倍 ;
						_colorBlock.graphics.drawRect(i * 2 / 15, j, 4, 4);
						_colorBlock.graphics.endFill();
					}
				}
			}
		}
		
		private function getColor(cx:Number, cy:Number):uint
		{
			var color:uint;
			var bmd:BitmapData = new BitmapData(1, 1, false, 0x0);
			bmd.draw(_colorBlock, new Matrix(1, 0, 0, 1, -cx, -cy))
			color = bmd.getPixel(0, 0);
			bmd.dispose();
			bmd = null;
			return color;
		}
		
		protected function changeOverColor():void
		{
			this.overColor = getColor(mouseX, mouseY);
		}
		
		private function onMoveEvent(e:MouseEvent):void
		{
			if (mouseX > 0 && mouseX < this.width && mouseY > 0 && mouseY < this.height)
			{
				callLater(changeOverColor);
			}
		}
		
		private function onClickEvent(e:MouseEvent):void
		{
			this.selectColor = getColor(mouseX, mouseY);
		}
		
		override public function get width():Number
		{
			return _colorBlock.width;
		}
		
		override public function get height():Number
		{
			return _colorBlock.height;
		}
		
		public function get selectColor():uint
		{
			return _selectColor;
		}
		
		public function set selectColor(value:uint):void
		{
			if (_selectColor != value)
			{
				_selectColor = value;
				sendEvent(UIEvent.SELECT_COLOR);
			}
		}
		
		public function get overColor():uint
		{
			return _overColor;
		}
		
		public function set overColor(value:uint):void
		{
			if (_overColor != value)
			{
				_overColor = value;
				sendEvent(UIEvent.OVER_COLOR_CHANGE);
			}
		}
	}

}