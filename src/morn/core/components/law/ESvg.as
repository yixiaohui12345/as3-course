package morn.core.components.law 
{
	import morn.core.components.Button;
	import morn.core.handlers.Handler;
	import svgparser.SvgDisplay;
	/**
	 * ...
	 * @author yxh
	 */
	public class ESvg extends EComponent
	{
		private var _url:String = null;
		
		private var _scale:Number = 1;
		
		private var _svgXML:XML = null;
		
		private var _svg:SvgDisplay = null;
		
		public function ESvg(url:String=null) 
		{
			this.url = url;
		}
		
		override protected function preinitialize():void
		{
			super.preinitialize();
			_type = EType.SVG;
		}
		
		override protected function createChildren():void
		{
			addChild(_svg = new SvgDisplay());
			addChild(_eGrid = new EGrid());
			addChild(_buttonDelete=new Button("png.style.button.icon_delete"));
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
		}
		
		public function get url():String {
			return url;
		}
		
		public function set url(value:String):void 
		{
			if (_url != value)
			{
				_url = value;
				App.loader.loadTXT(value, new Handler(completeHandler))
			}
		}
		
		public function get svgXML():XML 
		{
			return _svgXML;
		}
		
		public function set svgXML(value:XML):void 
		{
			if (_svgXML != value)
			{
				_svgXML = value
				_svg.parse(_svgXML);
				
				_eGrid.width = _svg.width
				_eGrid.height = _svg.height
				
				_buttonDelete.x = (_svg.width - _buttonDelete.width) * 0.5;
				_buttonDelete.y = -16*0.5-_buttonDelete.height
			}
		}
		
		private function completeHandler(data:Object):void
		{
			this.svgXML = XML(App.loader.getResLoaded(_url));
			
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			_svg.width = value
			_eGrid.width = value;
			_buttonDelete.x=(width - _buttonDelete.width) * 0.5;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			_svg.height = value
			_eGrid.height = value;
			_buttonDelete.y = 0 - _buttonDelete.height -16 * 0.5;
		}
		
		override public function set scale(value:Number):void
		{
			if (value != _scale)
			{
				_scale = value;
				_svg.scaleX=_svg.scaleY = value;
				_eGrid.width = value * _svg.width;
				_eGrid.height = value * _svg.height;
				_buttonDelete.x = (value * _svg.width - _buttonDelete.width) * 0.5;
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
						rotation:rotation,rotationX:rotationX,rotationY:rotationY,rotationZ:rotationZ,url:url};
		}
		
		override public function get exml():XML
		{
			var xml:XML =<ESvg></ESvg>;
			xml.@isPreview = "true";
			xml.@x = x;
			xml.@y = y;
			xml.@width = width;
			xml.@height = height;
			xml.@url = url;
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
		
		/**销毁*/
		override public function dispose():void
		{
			super.dispose();
		
			_svg = null;
		}
	}

}