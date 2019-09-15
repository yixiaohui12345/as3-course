package morn.core.components 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import morn.core.handlers.Handler;
	
	/**
	 * ...
	 * @author yxh
	 */
	public class FreeCombobox extends Component
	{
		protected var _skin:String = null;
		
		protected var _button:Button = null;
		
		protected var _contentView:View = null;
		
		protected var _isOpen:Boolean = false;
		
		public function FreeCombobox(skin:String=null) 
		{
			this.skin = skin;
		}
		
		override public function dispose():void {
			super.dispose();
			_button && _button.dispose();
			_contentView && _contentView.dispose();
		}
		
		override protected function preinitialize():void {
			mouseChildren = true;
		}
		
		override protected function createChildren():void 
		{
			addChild(_button = new Button());
		}
		
		override protected function initialize():void 
		{
			_button.btnLabel.align = "left";
			_button.labelMargin = "5";
			_button.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
		}
		
		private function onButtonMouseDown(e:MouseEvent):void {
			callLater(changeOpen);
		}
		
		protected function changeOpen():void {
			isOpen = !_isOpen;
		}
		
		/**是否打开*/
		public function get isOpen():Boolean {
			return _isOpen;
		}
		
		public function set isOpen(value:Boolean):void {
			if (_isOpen!=value)
			{
				_isOpen = value;
				_button.selected = _isOpen;
				if (_isOpen)
				{
					var p:Point = localToGlobal(new Point());
					var py:Number = p.y + _button.height;
					if (_contentView)
					{
						py = py + _contentView.height <= App.stage.stageHeight ? py : p.y - _contentView.height;
						_contentView.setPosition(p.x, py);
						App.stage.addChild(_contentView);
						App.stage.addEventListener(MouseEvent.MOUSE_DOWN, removeContent);
					}
				}
				else
				{
					_contentView && _contentView.remove();
					App.stage.removeEventListener(MouseEvent.MOUSE_DOWN, removeContent);
				}
			}
		}
		
		private function removeContent(e:Event):void {
			if (e == null || (!_button.contains(e.target as DisplayObject) && !_contentView.contains(e.target as DisplayObject)))
			{
				isOpen = false;
			}
		}
		
		public function get skin():String {
			return _button.skin;
		}
		
		public function set skin(value:String):void {
			if (_button.skin != value)
			{
				_button.skin = value;
				_contentWidth = _button.width;
				_contentHeight = _button.height;
			}
		}
		
		/**九宫格信息，格式：左边距,上边距,右边距,下边距,是否重复填充(值为0或1)，例如：4,4,4,4,1*/
		public function get sizeGrid():String {
			return _button.sizeGrid;
		}
		
		public function set sizeGrid(value:String):void {
			_button.sizeGrid = value;
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			_button.width = _width;
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			_button.height = _height;
		}
		
		public function get contentView():View 
		{
			return _contentView;
		}
		
		public function set contentView(value:View):void 
		{
			_contentView = value;
		}
	}

}