package svgparser.parser 
{
	import flash.display.Sprite;
	import svgparser.parser.IParser;
	import svgparser.parser.style.Style;
	
	public class Svg extends Group implements IParser
	{
		
		public static var LOCALNAME:String = "svg";
		
		public function Svg() {}
		
	}

}