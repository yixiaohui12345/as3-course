package svgparser.parser.model 
{
	import flash.display.DisplayObjectContainer;
	import svgparser.parser.FilterSet;
	import svgparser.parser.IGradient;
	import flash.display.DisplayObject;
		
	public class PersistentData
	{
		private var _rootXML:XML;
		private var _rootCanvas:DisplayObjectContainer;
		private var _gradients:Array = [];
		private var _filters:Array = [];
		private var _clippaths:Array = [];
		private var _graphics:Array = [];
		private var _symbols:XMLList = new XMLList();
		
		public function PersistentData() { }
				
		public function get rootXML():XML { return _rootXML; }
		public function set rootXML(value:XML):void 
		{
			if( !_rootXML ) _rootXML = value;
		}
		
		public function get rootCanvas():DisplayObjectContainer { return _rootCanvas; }
		public function set rootCanvas(value:DisplayObjectContainer):void 
		{
			if( !_rootCanvas ) _rootCanvas = value;
		}
		
		public function getGradientById( id:String ):IGradient { 
			for each( var grad:IGradient in _gradients ) 
				if ( grad.getId() == id ) return grad;
			return null; 
		}
		public function addGradient(value:IGradient):void 
		{
			for each( var grad:IGradient in _gradients ) 
				if ( grad.getId() == value.getId() ) return;
			_gradients.push( value );
		}
		
		public function getFilterById( id:String ):FilterSet {
			for each( var fl:FilterSet in _filters ) 
				if ( fl.id == id ) return fl;
			return null; 
		}
		public function addFilter(value:FilterSet):void 
		{
			for each( var fl:FilterSet in _filters ) 
				if ( fl.id == value.id ) return;
			_filters.push( value );
		}
		
		public function getClipPathById( id:String ):DisplayObject {
			for each( var cp:DisplayObject in _clippaths ) 
				if ( cp.name == id ) return cp;
			return null;
		}
		
		public function addClipPath(value:DisplayObject):void 
		{
			for each( var cp:DisplayObject in _clippaths ) 
				if ( cp.name == value.name ) return;
			_clippaths.push( value );
		}
	}

}