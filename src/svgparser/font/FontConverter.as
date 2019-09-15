package svgparser.font 
{
	import flash.text.engine.FontLookup;
	
	public class FontConverter
	{
		
		public var svgFontName:String;
		public var swfFontName:String;
		public var fontLookUp:String;
		
		public function FontConverter( svgFontName:String ,swfFontName:String, fontLookUp:String =null ) 
		{
			this.svgFontName = svgFontName;
			this.swfFontName = swfFontName;
			this.fontLookUp = fontLookUp;
		}
		
	}

}