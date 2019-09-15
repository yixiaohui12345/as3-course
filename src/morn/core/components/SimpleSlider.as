package morn.core.components 
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import morn.core.events.UIEvent;
	import morn.core.handlers.Handler;
	/**滑动条变化后触发*/
	[Event(name = "change", type = "flash.events.Event")]
	
	[Event(name = "scrollBegin", type = "morn.core.events.UIEvent")]
	
	[Event(name="scrollEnd",type="morn.core.events.UIEvent")]
	/**
	 * ...
	 * @author yxh
	 */
	public class SimpleSlider extends Component
	{
		protected var _back:Image = null;
		
		protected var _input:TextInput = null;
		
		protected var _tips:Label = null;
		
		protected var _hint:String = null;
		
		protected var _skin:String;
		
		protected var _tick:Number = 1;
		
		protected var _mouseStyle:String = null;
		
		protected var _value:Number = Number.NaN;
		
		protected var _max:Number = 100;
		
		protected var _min:Number = 0;
		
		protected var _limit:Number = 5;
		
		protected var endPos:Number = Number.NaN;
		
		protected var _changeHandler:Handler;
		
		public function SimpleSlider() 
		{
			
		}
		
		override public function dispose():void {
			_back && _back.dispose();
			_input && _input.dispose();
			_tips && _tips.dispose();
			_back = null;
			_input = null;
			_tips = null;
			_changeHandler = null;
		}
		
		override protected function preinitialize():void {
			mouseChildren = true;
		}
		
		override protected function createChildren():void 
		{
			addChild(_back = new Image());
			addChild(_input = new TextInput());
			addChild(_tips = new Label());
		}
		
		override protected function initialize():void
		{
			_input.restrict = "0-9";
			_tips.mouseChildren = _tips.mouseEnabled = _tips.wordWrap = _tips.multiline = false;
			_input.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			_input.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
			_input.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			_input.addEventListener(Event.CHANGE, textChange);
			_input.margin = "1,2,0,2";
			_tips.margin = "2,2,2,2";
		}
		
		private function focusIn(e:FocusEvent):void 
		{
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		private function focusOut(e:FocusEvent):void 
		{
			var v:Number = Number(_input.text);
			value = v > _max?_max:v < min?_min:v;
			//sendChangeEvent();
			sendEvent(UIEvent.SCROLL_END);
		}
		
		private function textChange(e:Event):void 
		{
			e.preventDefault();
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			endPos = App.stage.mouseY
			sendEvent(UIEvent.SCROLL_BEGIN);
			App.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			App.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			Mouse.cursor = MouseCursor.AUTO;
			App.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			App.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			sendEvent(UIEvent.SCROLL_END);
		}
		
		private function mouseMove(e:MouseEvent):void 
		{
			_mouseStyle && (Mouse.cursor = _mouseStyle);
			(Math.abs(endPos - App.stage.mouseY) > _limit)
			{
				if (App.stage.mouseY > endPos)
				{
					_value-= _tick;
				}
				else
				{
					_value+= _tick;
				}
				endPos = App.stage.mouseY;
				changeValue()
				sendChangeEvent();
			}
		}
		
		protected function sendChangeEvent():void
		{
			sendEvent(Event.CHANGE);
			if (_changeHandler != null) {
				_changeHandler.executeWith([_value]);
			}
		}
		
		private function changeText():void 
		{
			_input.text = String(_value);
		}
		
		protected function changeValue():void
		{
			_value = _value > _max?_max:_value < min?_min:_value;
			changeText();
		}
		
		protected function changeTextSize():void
		{
			if (!isNaN(_contentWidth) && !isNaN(_contentHeight) && sizeGrid)
			{
				var arr:Array = sizeGrid.split(",");
				_input.width = _contentWidth - int(arr[2])+5;
				_tips.height=_input.height = _contentHeight - int(arr[1]) - int(arr[3]);
				_input.x = int(arr[0]);
				_tips.y = _input.y = int(arr[1])
				_tips.x = _contentWidth-int(arr[2])+15
				_tips.width = _contentWidth - int(arr[2]);
			}
		}
		
		/**皮肤*/
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value)
			{
				_skin = value;
				_back.skin = _skin;
				_contentWidth = _back.width;
				_contentHeight = _back.height;
				callLater(changeTextSize);
			}
		}
		
		override public function set width(value:Number):void 
		{
			_back.width = value;
			_contentWidth = value;
			callLater(changeTextSize);
		}
		
		override public function get width():Number
		{
			return _contentWidth;
		}
		
		override public function set height(value:Number):void
		{
			_back.height = value;
			_contentHeight = value;
			callLater(changeTextSize);
		}
		
		override public function get height():Number
		{
			return _contentHeight;
		}
		
		/**九宫格信息，格式：左边距,上边距,右边距,下边距,是否重复填充(值为0或1)，例如：4,4,4,4,1*/
		public function get sizeGrid():String {
			return _back.sizeGrid;
		}
		
		public function set sizeGrid(value:String):void 
		{
			_back.sizeGrid = value;
			callLater(changeTextSize);
		}
		
		/**刻度值，默认值为1*/
		public function get tick():Number {
			return _tick;
		}
		
		public function set tick(value:Number):void {
			_tick = value;
		}
		
		/**滑块上允许的最大值*/
		public function get max():Number {
			return _max;
		}
		
		public function set max(value:Number):void {
			if (_max != value) {
				_max = value;
			}
		}
		
		/**滑块上允许的最小值*/
		public function get min():Number {
			return _min;
		}
		
		public function set min(value:Number):void {
			if (_min != value) {
				_min = value;
			}
		}
		
		public function set mouseStyle(value:String):void
		{
			if (value != _mouseStyle)
			{
				_mouseStyle = value;
			}
		}
		
		public function get value():Number 
		{
			return _value;
		}
		
		public function set value(num:Number):void 
		{
			if (_value != num)
			{
				_value = num;
				changeValue();
			}
		}
		
		/**数据变化处理器*/
		public function get changeHandler():Handler {
			return _changeHandler;
		}
		
		public function set changeHandler(value:Handler):void {
			_changeHandler = value;
		}
		
		public function get hint():String 
		{
			return _hint;
		}
		
		public function set hint(value:String):void 
		{
			if (_hint != value)
			{
				_hint = value;
				value && (_tips.text = value);
			}
		}
		
		public function set labelSize(value:Object):void
		{
			_input.size = value;
		}
		
		public function set labelColor(value:Object):void
		{
			_input.color = value;
		}
		
		public function set labelFont(value:String):void
		{
			_input.font = value;
		}
		
		public function get limit():Number 
		{
			return _limit;
		}
		
		public function set limit(value:Number):void 
		{
			_limit = value;
		}
	}

}