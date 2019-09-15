package svgparser.parser 
{
	import flash.display.DisplayObject;
	import svgparser.parser.IParser;
	import svgparser.parser.model.Data;
	import svgparser.parser.style.Style;
	import flash.display.Sprite;
	
	public class Symbol implements IParser
	{
		public static var LOCALNAME:String = "symbol";
		
		public function Symbol() { }
		public function parse( data:Data ):void {}
	}
}