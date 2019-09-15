package mouse 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	import morn.core.components.Image;
	/**
	 * ...
	 * @author yxh
	 */
	public class MouseModules 
	{
		private var mouseList:Array=[MouseType.MOUSE_MOVING,MouseType.MOUSE_HORIZON,MouseType.MOUSE_LEFT,MouseType.MOUSE_RIGHT,MouseType.MOUSE_VERTICAL]
		
		private var mouseStyleList:Array=["png.style.icon.mouse_moving","png.style.icon.mouse_horizon","png.style.icon.mouse_left","png.style.icon.mouse_right","png.style.icon.mouse_vertical"]
		
		public function MouseModules() 
		{
			var point:Point = new Point(16, 16);
			for (var i:int = 0; i < 5; i++)
			{
				var image:Image = new Image(mouseStyleList[i]);
				var bmd:BitmapData = new BitmapData(32,32, true, 0x000000);
				bmd.draw(image);
				var cursorVector:Vector.<BitmapData> = new Vector.<BitmapData>();
				cursorVector[0] = bmd;
				var cursorData:MouseCursorData = new MouseCursorData();
				cursorData.hotSpot =point
				cursorData.data = cursorVector;
				Mouse.registerCursor(mouseList[i], cursorData);
			}
		}
		
		private static var _inst:MouseModules = null;
		public static function get inst():MouseModules
		{
			if (_inst == null)
			{
				_inst = new MouseModules();
			}
			return _inst;
		}
		
		public function init():void
		{
		}
	}
}