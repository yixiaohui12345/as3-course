package morn.core.components.law 
{
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import morn.core.components.Button;
	import morn.core.utils.ObjectUtils;
	import morn.core.utils.StringUtils;
	import morn.core.components.AutoBitmap;
	import morn.core.components.Styles;
	import morn.core.components.TextInput;
	import morn.core.events.UIEvent;
	import morn.core.handlers.Handler;
	import morn.editor.core.IEComponent
	/**
	 * ...
	 * @author yxh
	 */
	public class EText extends EComponent
	{
		private static const GAP:int = 6;
		private static var reg:RegExp = new RegExp("\\n","g");
		protected var _textField:TextField;
		protected var _format:TextFormat;
		protected var _text:String = "";
		protected var _isHtml:Boolean;
		protected var _stroke:String;
		protected var _skin:String = null;
		protected var _bitmap:AutoBitmap;
		protected var _margin:Array = Styles.labelMargin;
		protected var _backgroundColor:int =-1;
		
		public function EText(text:String = "", skin:String = null) 
		{
			this.text = text;
			this.skin = skin;
		}
		
		/**销毁*/
		override public function dispose():void {
			super.dispose();
			_bitmap && _bitmap.dispose();	
			_bitmap = null;
			
			_textField && _textField.removeEventListener(Event.CHANGE, onTextChange);
			_textField &&_textField.removeEventListener(FocusEvent.FOCUS_IN, onFoucusIn);
			_textField &&_textField.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			_textField = null;
			_format = null;
			_margin = null;
		}
		
		override protected function preinitialize():void {
			mouseEnabled = false;
			_type = EType.TEXT;
		}
		
		override protected function createChildren():void
		{
			addChild(_bitmap = new AutoBitmap());
			addChild(_textField = new TextField());
			addChild(_eGrid = new EGrid());
			addChild(_buttonDelete=new Button("png.style.button.icon_delete"));
		}
		
		override protected function initialize():void
		{
			super.initialize();
			_format = _textField.defaultTextFormat;
			_format.font = "微软雅黑"
			_textField.autoSize=TextFieldAutoSize.LEFT;
			_textField.embedFonts = Styles.embedFonts;
			_textField.type = TextFieldType.INPUT;
			_textField.wordWrap = _textField.multiline = true;
			_bitmap.sizeGrid = Styles.defaultSizeGrid;
			_textField.x = _textField.y = GAP
			_textField.addEventListener(Event.CHANGE, onTextChange);
			_textField.addEventListener(FocusEvent.FOCUS_IN, onFoucusIn);
			_textField.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			mouseChildren = true;
			this.margin = "2,2,2,2";
			this.width = 200
			this.height = 100;
		}
		
		private var oldValue:String;
		private function onFoucusIn(e:FocusEvent):void 
		{
			oldValue = text;
		}
		
		private function onFocusOut(e:FocusEvent):void 
		{
			if (text != oldValue)
			{
				sendEvent(UIEvent.PROPERTY_CHANGE, {target:this,oldValue:oldValue,newValue:text,key:"text"});
			}
		}
		
		private function onTextChange(e:Event):void 
		{
			text = _isHtml ? _textField.htmlText : _textField.text;
		}
		
		override public function backStarter():void
		{
			
		}
		
		protected function changeText():void 
		{
			_textField.defaultTextFormat = _format;
			_isHtml ? _textField.htmlText = App.lang.getLang(_text) : _textField.text = App.lang.getLang(_text);
		}
		
		override protected function changeSize():void
		{
			if (!isNaN(_width)) {
				_textField.autoSize = TextFieldAutoSize.NONE;
				_textField.width = _width - _margin[0] - _margin[2];
				if (isNaN(_height) && wordWrap) {
					_textField.autoSize = TextFieldAutoSize.LEFT;
				} else {
					_height = isNaN(_height) ? 18 : _height;
					_textField.height = _height - _margin[1] - _margin[3];
				}
			} else {
				_width = _height = NaN;
				_textField.autoSize = TextFieldAutoSize.LEFT;
			}
			super.changeSize();
		}
		
		/**描边(格式:color,alpha,blurX,blurY,strength,quality)*/
		public function get stroke():String {
			return _stroke;
		}
		
		public function set stroke(value:String):void {
			if (_stroke != value) {
				_stroke = value;
				ObjectUtils.clearFilter(_textField, GlowFilter);
				if (Boolean(_stroke)) {
					var a:Array = StringUtils.fillArray(Styles.labelStroke, _stroke);
					ObjectUtils.addFilter(_textField, new GlowFilter(a[0], a[1], a[2], a[3], a[4], a[5]));
				}
			}
		}
		
		/**是否是多行*/
		public function get multiline():Boolean {
			return _textField.multiline;
		}
		
		public function set multiline(value:Boolean):void {
			_textField.multiline = value;
		}
		
		/**是否是密码*/
		public function get asPassword():Boolean {
			return _textField.displayAsPassword;
		}
		
		public function set asPassword(value:Boolean):void {
			_textField.displayAsPassword = value;
		}
		
		/**宽高是否自适应*/
		public function get autoSize():String {
			return _textField.autoSize;
		}
		
		public function set autoSize(value:String):void {
			_textField.autoSize = value;
		}
		
		/**是否自动换行*/
		public function get wordWrap():Boolean {
			return _textField.wordWrap;
		}
		
		public function set wordWrap(value:Boolean):void {
			_textField.wordWrap = value;
		}
		
		/**是否可选*/
		public function get selectable():Boolean {
			return _textField.selectable;
		}
		
		public function set selectable(value:Boolean):void {
			_textField.selectable = value;
			mouseEnabled = value;
		}
		
		/**是否具有背景填充*/
		public function get background():Boolean {
			return _textField.background;
		}
		
		public function set background(value:Boolean):void {
			_textField.background = value;
		}
		
		/**文本字段背景的颜色*/
		public function get backgroundColor():int {
			return _backgroundColor
		}
		
		public function set backgroundColor(value:int):void 
		{
			_backgroundColor = value;
			if (value !=-1)
			{
				this.background = true;
				_textField.backgroundColor = value;
			}
			else
			{
				this.background = false;
			}
		}
		
		/**字体颜色*/
		public function get color():Object {
			return _format.color;
		}
		
		public function set color(value:Object):void {
			_format.color = value;
			callLater(changeText);
		}
		
		/**字体类型*/
		public function get font():String {
			return _format.font;
		}
		
		public function set font(value:String):void {
			_format.font = value;
			callLater(changeText);
		}
		
		/**对齐方式*/
		public function get align():String {
			return _format.align;
		}
		
		public function set align(value:String):void {
			_format.align = value;
			callLater(changeText);
		}
		
		/**是否斜体*/
		public function get italic():Object
		{
			return _format.italic;
		}
		
		public function set italic(value:Object):void
		{
			_format.italic = value;
			callLater(changeText);
		}
		
		/**粗体类型*/
		public function get bold():Object {
			return _format.bold;
		}
		
		public function set bold(value:Object):void {
			_format.bold = value;
			callLater(changeText);
		}
		
		/**垂直间距*/
		public function get leading():Object {
			return _format.leading;
		}
		
		public function set leading(value:Object):void {
			_format.leading = value;
			callLater(changeText);
		}
		
		/**第一个字符的缩进*/
		public function get indent():Object {
			return _format.indent;
		}
		
		public function set indent(value:Object):void {
			_format.indent = value;
			callLater(changeText);
		}
		
		/**字体大小*/
		public function get size():Object {
			return _format.size;
		}
		
		public function set size(value:Object):void {
			_format.size = value;
			callLater(changeText);
		}
		
		/**下划线类型*/
		public function get underline():Object {
			return _format.underline;
		}
		
		public function set underline(value:Object):void {
			_format.underline = value;
			callLater(changeText);
		}
		
		/**字间距*/
		public function get letterSpacing():Object {
			return _format.letterSpacing;
		}
		
		public function set letterSpacing(value:Object):void {
			_format.letterSpacing = value;
			callLater(changeText);
		}
		
		public function set leftMargin(value:Object):void
		{
			_format.leftMargin = value;
			callLater(changeText);
		}
		
		public function get leftMargin():Object
		{
			return _format.leftMargin
		}
		
		public function set rightMargin(value:Object):void
		{
			_format.rightMargin = value;
			callLater(changeText);
		}
		
		public function get rightMargin():Object
		{
			return _format.rightMargin;
		}
		
		/**边距(格式:左边距,上边距,右边距,下边距)*/
		public function get margin():String {
			return _margin.join(",");
		}
		
		public function set margin(value:String):void {
			_margin = StringUtils.fillArray(_margin, value, int);
			_textField.x = _margin[0];
			_textField.y = _margin[1];
			callLater(changeSize);
		}
		
		/**是否嵌入*/
		public function get embedFonts():Boolean {
			return _textField.embedFonts;
		}
		
		public function set embedFonts(value:Boolean):void {
			_textField.embedFonts = value;
		}
		
		/**格式*/
		public function get format():TextFormat {
			return _format;
		}
		
		public function set format(value:TextFormat):void {
			_format = value;
			callLater(changeText);
		}
		
		/**文本控件实体*/
		public function get textField():TextField {
			return _textField;
		}
		
		/**将指定的字符串追加到文本的末尾*/
		public function appendText(newText:String):void {
			text += newText;
		}
		
		/**皮肤*/
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				_bitmap.bitmapData = App.asset.getBitmapData(_skin);
				if (_bitmap.bitmapData) {
					_contentWidth = _bitmap.bitmapData.width;
					_contentHeight = _bitmap.bitmapData.height;
				}
			}
		}
		
		/**九宫格信息，格式：左边距,上边距,右边距,下边距,是否重复填充(值为0或1)，例如：4,4,4,4,1*/
		public function get sizeGrid():String {
			return _bitmap.sizeGrid.join(",");
		}
		
		public function set sizeGrid(value:String):void {
			_bitmap.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid, value, int);
		}
		
		override public function commitMeasure():void {
			exeCallLater(changeText);
			exeCallLater(changeSize);
		}
		
		override public function get width():Number {
			if (!isNaN(_width) || Boolean(_skin) || Boolean(_text)) {
				return super.width;
			}
			return 0;
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			_bitmap.width = value;
			_eGrid.width = value;
			_buttonDelete.x=(width - _buttonDelete.width) * 0.5;
		}
		
		override public function get height():Number {
			if (!isNaN(_height) || Boolean(_skin) || Boolean(_text)) {
				return super.height;
			}
			return 0;
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			_bitmap.height = value;
			_eGrid.height = value;
			_buttonDelete.y = 0 - _buttonDelete.height -16 * 0.5;
		}
		
		/**是否是html格式*/
		public function get isHtml():Boolean {
			return _isHtml;
		}
		
		public function set isHtml(value:Boolean):void {
			if (_isHtml != value) {
				_isHtml = value;
				callLater(changeText);
			}
		}
		
		/**Html文本*/
		public function get htmlText():String {
			return _text;
		}
		
		public function set htmlText(value:String):void {
			_isHtml = true;
			text = value;
		}
		
		/**最多可包含的字符数*/
		public function get maxChars():int {
			return _textField.maxChars;
		}
		
		public function set maxChars(value:int):void {
			_textField.maxChars = value;
		}
		
		/**指示用户可以输入到控件的字符集*/
		public function get restrict():String {
			return _textField.restrict;
		}
		
		public function set restrict(value:String):void {
			_textField.restrict = value;
		}
		
		/**显示的文本*/
		public function get text():String {
			return _text;
		}
		
		public function set text(value:String):void {
			if (_text != value) {
				_text = value || "";
				_text = _text.replace(reg, "\n");
				//callLater(changeText);
				changeText();
				sendEvent(Event.CHANGE);
			}
		}
		
		override public function set isSelected(value:Boolean):void
		{
			super.isSelected = value;
			if (value)
			{
				doubleClickEnabled = true;
				this.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClick);
			}
			else
			{
				doubleClickEnabled = false;
				this.removeEventListener(MouseEvent.DOUBLE_CLICK, doubleClick);
			}
		}
		
		private function doubleClick(e:MouseEvent):void 
		{
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		override public function get attribute():Object
		{
			var obj:Object={className:"morn.core.components.law.EText",background:background,backgroundColor:backgroundColor,
						color:color,x:x,y:y,width:width,height:height,text:text,bold:bold,underline:underline,italic:italic,size:size,font:font,scaleX:scaleX,scaleY:scaleY,
						leading:leading, indent:indent, leftMargin:leftMargin, rightMargin:rightMargin, align:align, multiline:multiline, wordWrap:wordWrap, selectable:selectable};
						if (rotationZ != 0)
						{
							obj.rotationZ = this.rotationZ;
						}
			return obj
		}
		
		override public function get exml():XML
		{
			var xml:XML =<EText></EText>;
			xml.@isPreview = "true";
			xml.@x = x;
			xml.@y = y;
			xml.@width = width;
			xml.@height = height;
			xml.@background = background;
			xml.@backgroundColor = backgroundColor;
			xml.@text = text;
			xml.@color = color;
			xml.@bold = bold;
			xml.@underline = underline;
			xml.@italic = italic;
			xml.@size = size;
			xml.@font = font;
			xml.@leading = leading;
			xml.@indent = indent;
			xml.@leftMargin = leftMargin;
			xml.@rightMargin = rightMargin;
			xml.@align = align;
			xml.@multiline = multiline;
			xml.@wordWrap = wordWrap;
			xml.@selectable = "false";
			xml.@layer = this.parent.getChildIndex(this)
			xml.@link = link;
			scaleX !=1 ?(xml.@scaleX = scaleX):null;
			scaleY !=1 ?(xml.@scaleY = scaleY):null;
			rotation!=0?(xml.@rotation = rotation):null;
			rotationZ != 0?(xml.@rotationZ = rotationZ):null;
			rotationX != 0?(xml.@rotationX = rotationX):null;
			rotationY != 0?(xml.@rotationY = rotationY):null;
			animation&&(xml.@animation = animation);
			return xml;
		}
	}

}