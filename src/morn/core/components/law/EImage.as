package morn.core.components.law 
{
	import flash.display.DisplayObject;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.net.registerClassAlias;
	import flash.system.ApplicationDomain;
	import flash.utils.getDefinitionByName;
	import morn.core.components.AutoBitmap;
	import morn.core.components.Button;
	import morn.core.components.Image;
	import morn.core.components.Label;
	import morn.core.components.Styles;
	import morn.core.events.UIEvent;
	import morn.core.utils.StringUtils;
	import morn.editor.core.IEComponent;
	
	/**
	 * 2016/7/26 15:54
	 * @author yxh
	 */
	public class EImage extends EComponent implements IEComponent
	{
		protected var _image:Image;
		
		protected var _scale:Number = 1;
		
		protected var _label:Label = null;
		
		public function EImage(url:String=null) 
		{
			this.url = url;
		}
		
		override protected function preinitialize():void
		{
			super.preinitialize();
			_type = EType.IMAGE;
		}
		
		override protected function createChildren():void
		{
			addChild(_label = new Label("加载失败，请检查图片路径是否正确"));
			addChild(_image = new Image());
			addChild(_eGrid = new EGrid());
			addChild(_buttonDelete=new Button("png.style.button.icon_delete"));
		}
		
		override protected function initialize():void
		{
			super.initialize();
			_label.visible = _label.selectable = _label.wordWrap= false;
			_label.width = 150;
			_label.height = 30;
			_label.align = "center";
			_label.color = 0;
			_image.addEventListener(UIEvent.IMAGE_LOADED, loadedEvent);
		}
		
		private function loadedEvent(e:UIEvent):void 
		{
			if (!_image.bitmapData)
			{
				this.width = 150;
				this.height = 60;
				_label.centerY = _label.centerX = 0;
				_label.visible = true;
				_buttonDelete.x = (150 - _buttonDelete.width) * 0.5;
				_buttonDelete.y = -16 * 0.5 - _buttonDelete.height
				return;
			}
			_label.visible = false;
			_starter.width = _image.width;
			_starter.height = _image.height;
			
			_eGrid.width = _image.width
			_eGrid.height = _image.height
			
			_buttonDelete.x = (_image.width - _buttonDelete.width) * 0.5;
			_buttonDelete.y = -16*0.5-_buttonDelete.height
		}
		
		public function get url():String {
			return _image.url;
		}
		
		public function set url(value:String):void 
		{
			_image.url = value;
		}
		
		/**图片地址，等同于url*/
		public function get skin():String {
			return _image.url
		}
		
		public function set skin(value:String):void {
			_image.url = value;
		}
		
		/**源位图数据*/
		public function get bitmapData():BitmapData 
		{
			return _image.bitmapData
		}
		
		public function set bitmapData(value:BitmapData):void 
		{
			_image.bitmapData = value;
		}
		/**九宫格信息，格式：左边距,上边距,右边距,下边距,是否重复填充(值为0或1)，例如：4,4,4,4,1*/
		public function get sizeGrid():String {
			if (_image.sizeGrid) {
				return _image.sizeGrid;
			}
			return null;
		}
		
		public function set sizeGrid(value:String):void 
		{
			_image.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid, value, int).join();
		}
		
		/**位图控件实例*/
		public function get bitmap():AutoBitmap {
			return _image.bitmap;
		}
		
		/**是否对位图进行平滑处理*/
		public function get smoothing():Boolean {
			return _image.smoothing;
		}
		
		public function set smoothing(value:Boolean):void {
			_image.smoothing = value;
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			_image.width = value
			_eGrid.width = value;
			_buttonDelete.x=(width - _buttonDelete.width) * 0.5;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			_image.height = value
			_eGrid.height = value;
			_buttonDelete.y = 0 - _buttonDelete.height -16 * 0.5;
		}
		
		override public function set scale(value:Number):void
		{
			if (value != _scale)
			{
				_scale = value;
				_image.scale = value;
				_eGrid.width = value * _image.width;
				_eGrid.height = value * _image.height;
				_buttonDelete.x = (value * _image.width - _buttonDelete.width) * 0.5;
				_buttonDelete.y = -16*0.8-_buttonDelete.height
			}
		}
		
		override public function get scale():Number
		{
			return _scale
		}
		
		override public function get attribute():Object
		{
			return {className:"morn.core.components.law.EImage", x:x, y:y, width:width, height:height, scaleX:scaleX, scaleY:scaleY,
						rotation:rotation,rotationX:rotationX,rotationY:rotationY,rotationZ:rotationZ,url:url,skin:skin,smoothing:smoothing};
		}
		
		override public function get exml():XML
		{
			var xml:XML =<EImage></EImage>;
			xml.@isPreview = "true";
			xml.@x = x;
			xml.@y = y;
			xml.@width = width;
			xml.@height = height;
			xml.@url = url;
			xml.@layer = this.parent.getChildIndex(this)
			xml.@smoothing = smoothing;
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
		
		/**销毁*/
		override public function dispose():void
		{
			super.dispose();
			
			_label && _label.dispose();
			_label = null;
			
			_image && _image.dispose();
			_image && _image.removeEventListener(UIEvent.IMAGE_LOADED, loadedEvent);
			_image = null;
		}
	}

}