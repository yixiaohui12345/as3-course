package svgparser.parser.model 
{
	import flash.display.DisplayObjectContainer ;
	import flash.display.DisplayObject;
	import svgparser.font.FontConverter;
	import svgparser.parser.style.Style;
	import svgparser.parser.SvgFactory;
	import svgparser.parser.FilterSet;
	import svgparser.parser.IGradient;
	import svgparser.Settings;
	
	public class Data
	{
		private var _currentXML:XML;
		private var _currentCanvas:DisplayObjectContainer;
		private var _settings:Settings;
		private var _persistent:PersistentData;
		private var _styleXML:XML;
		
		public function Data( xml:XML, canvas:DisplayObjectContainer , settings:Settings = null , persistent:PersistentData = null ) 
		{
			_persistent = ( persistent  ) ?  persistent : new PersistentData();
			_currentXML = _persistent.rootXML =  xml;
			_currentCanvas = _persistent.rootCanvas = canvas;
			this._settings = settings;
		}
		
		//return new Data with persistent data intact
		public function copy( xml:XML = null , canvas:DisplayObjectContainer = null):Data	
		{	
			if ( !xml ) xml = _currentXML;
			if ( !canvas ) canvas = _currentCanvas;
			return new Data( xml, canvas, _settings, _persistent );
		}
		
		public function overrideStyle( xml:XML):void {
			xml.@transform = null;
			_styleXML = xml;
		}
		
		public function getStyleXML():XML {
			return _styleXML;
		}
		
		public function get hasParentStyle():Boolean {
			return Boolean( _styleXML );
		}
		
		public function replaceFont ( style:Style ):void {
			if ( !_settings.hasFontConversion() ) return;
			var fc:FontConverter = _settings.getSwfFont( style.font_family );
			if ( !fc )  return;
			style.font_family = fc.swfFontName;
			if ( fc.fontLookUp != null ) style.fontLookup = fc.fontLookUp;
		}
		
		public function getGradientById( id:String ):IGradient { 
			return _persistent.getGradientById( id );
		}
		public function addGradient(value:IGradient):void 
		{
			_persistent.addGradient( value );
		}
		
		public function getFilterById( id:String ):FilterSet {
			return _persistent.getFilterById( id );
		}
		public function addFilter(value:FilterSet):void 
		{
			_persistent.addFilter( value );
		}
		
		public function getClipPathById( id:String ):DisplayObject {
			return _persistent.getClipPathById( id );
		}
		
		public function addClipPath(value:DisplayObject):void 
		{
			_persistent.addClipPath( value );
		}
		
		public function get xml():XML { return _persistent.rootXML; }
		public function get canvas():DisplayObjectContainer { return _persistent.rootCanvas; }
		
		public function get currentCanvas():DisplayObjectContainer  { return _currentCanvas; }
		public function set currentCanvas( value:DisplayObjectContainer ):void {
			_currentCanvas = value;
		}
		public function get currentXml():XML { return _currentXML; }
		public function set currentXml( value:XML ):void {
			_currentXML = value;
		}
		public function get settings():Settings { return _settings; }
	}

}