package org.utils
{
	
	/**
	 * ...
	 * @author yxh
	 */
	public class ColorUtils
	{
		private static const H_PARAM:int = 40;
		private static const S_PARAM:int = 240;
		private static const L_PARAM:int = 240;
		
		public function ColorUtils()
		{
		
		}
		
		/**RGB转10进制*/
        public static function rgbToNumber(r:Number, g:Number, b:Number):uint
        {
            return r<<16 | g<<8 | b;
        }
		
		public static function toARGB(color:uint):Array
		{
			var a:uint = color >> 24 & 0xFF;
			var r:uint = color >> 16 & 0xFF;
			var g:uint = color >> 8 & 0xFF;
			var b:uint = color & 0xFF;
			return [r, g, b, a];
		}
		
		public static function getRgb(H:int, S:int, L:int):Array
		{
			var h:Number = H / 240;
			var s:Number = S / 240;
			var l:Number = L / 240;
			var r:Number;
			var g:Number;
			var b:Number;
			if (s == 0)
			{
				r = g = b = l;
				return [near(r * 255),near(g * 255),near(b * 255)]
			}
			else
			{
				var p2:Number;
				if (l < 0.5)
				{
					p2 = l * (1 + s);
				}
				else
				{
					p2 = l + s - l * s;
				}
				var p1:Number;
				p1 = 2 * l - p2;
				
				r = hue(p1, p2, h + 1 / 3);
				g = hue(p1, p2, h);
				b = hue(p1, p2, h - 1 / 3);
				
				var _r:int = near(r * 255);
				var _g:int = near(g * 255);
				var _b:int = near(b * 255);
				return [_r, _g, _b];
			}
		}
		
		public static function rToH(r:uint, g:uint, b:uint):Array
		{
			var red:Number = r / 255;
			var green:Number = g / 255;
			var blue:Number = b / 255;
			var s:Number;
			var h:Number;
			var l:Number;
			var maxcolor:Number = Math.max(red, green, blue);
			var mincolor:Number = Math.min(red, green, blue);
			if (maxcolor == mincolor)
			{
				s = 0.0;
				h = 0.0;
			}
			else
			{
				l = (maxcolor + mincolor) / 2;
			}
			
			if (l < 0.5)
				s = (maxcolor - mincolor) / (maxcolor + mincolor);
			if (l >= 0.5)
				s = (maxcolor - mincolor) / (2.0 - maxcolor - mincolor);
			
			if (red == maxcolor)
			{
				h = (green - blue) / (maxcolor - mincolor);
			}
			if (green == maxcolor)
			{
				h = 2.0 + (blue - red) / (maxcolor - mincolor);
			}
			if (blue == maxcolor)
			{
				h = 4.0 + (red - green) / (maxcolor - mincolor);
			}
			var _h:int = near(h * H_PARAM);
			var _s:int = near(s * S_PARAM);
			var _l:int = near(l * L_PARAM);
			return [_h, _s, _l];
		}
		
		private static function hue(p1:Number, p2:Number, hue:Number):Number
		{
			if (hue < 0)
				hue = hue + 1;
			if (hue > 1)
				hue = hue - 1;
			
			if (hue * 6 < 1)
			{
				return p1 + (p2 - p1) * 6.0 * hue;
			}
			else if (2 * hue < 1)
			{
				return p2;
			}
			else if (3 * hue < 2)
			{
				return p1 + (p2 - p1) * ((2.0 / 3.0) - hue) * 6.0;
			}
			else
			{
				return p1;
			}
		}
		
		private static function near(x:Number):int
		{
			if (x - Math.floor(x) < 0.5)
			{
				return Math.floor(x);
			}
			else
			{
				return Math.floor(x) + 1;
			}
		}
	}

}