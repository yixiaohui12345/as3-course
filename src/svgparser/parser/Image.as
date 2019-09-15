package svgparser.parser
{
	import flash.display.DisplayObjectContainer ;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.events.Event;
	import svgparser.parser.IParser;
	import svgparser.parser.model.Data;
	import svgparser.parser.Constants;
	import svgparser.parser.style.Style;
	import svgparser.parser.utils.StyleUtil;
	
	public class Image implements IParser
	{
		public static var LOCALNAME:String = "image";
		
		private var _x:Number;
		private var _y:Number;
		private var _width:Number;
		private var _height:Number;
		private var _href:String;
		private var _binaryData:String;
		
		private var _imageWidth:Number;
		private var _imageHeight:Number;
		
		private var _data:Data;
		private var _style:Style;

		public function Image() {}
		
		public function parse( data:Data ):void 
		{
			_x = StyleUtil.toNumber( data.currentXml.@x );
			_y = StyleUtil.toNumber( data.currentXml.@y );
			_width = StyleUtil.toNumber( data.currentXml.@width );
			_height = StyleUtil.toNumber( data.currentXml.@height );
			
			_style = new Style( data.currentXml );
			_data = data;
			
			var xlink:Namespace = Constants.xlink;
			_href = data.currentXml.@xlink::href;
			if ( _href.indexOf( "data:" ) == 0 ) {
				_binaryData = _href;
				_href = null;
			}
			
			if ( _href != null ) loadImage();
		}
		
		private function loadImage():void 
		{
			var loader:Loader = new Loader();
			loader.name = _style.id;
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, loadComplete );
			loader.load( new URLRequest( _href ) );
			_data.currentCanvas.addChild( loader );
		}
		
		private function loadComplete( e:Event ):void 
		{
			var loader:Loader = e.currentTarget.loader as Loader;
			_imageWidth = loader.content.width;
			_imageHeight = loader.content.height;
			loader.content.x = _x;
			loader.content.y = _y;
			if ( _imageWidth != _width || _imageHeight != _height ) {
				loader.content.height = _height;
				loader.content.width = _width;
			}
			_style.applyStyle( loader.content , _data , false );
			loader.x = loader.content.x;
			loader.y = loader.content.y;
			loader.content.x = 0;
			loader.content.y = 0;
			_data = null;
			_style = null;
		}
	}

}