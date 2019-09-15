package  svgparser
{
	import flash.display.Sprite;
	import svgparser.font.FontConverter;
	import svgparser.parser.SvgFactory;
	
	public class SvgDisplay extends Sprite{
		
		protected var svg:XML;
		protected var settings:Settings;
		
		public function SvgDisplay( xml:XML = null) 
		{ 
			settings = new Settings();
			if( xml ) parse( xml );
		}
		
		public function parse( xml:XML ):void 
		{
			this.svg = XML( xml );
			new SvgFactory().parse( xml , this, settings );
		}
		
		public function addFontConversion( svgFontName:String , swfFontName:String , fontLookup:String = null ):void {
			settings.addFontConversion( new FontConverter( svgFontName, swfFontName, fontLookup ) );
		}
		
	}
	
}