package svgparser.parser.filters 
{
	import flash.filters.BlurFilter;
	import flash.filters.BitmapFilter;
	import flash.display.DisplayObject;
	import svgparser.parser.Constants;
	
	public class GaussianBlur implements IFilter
	{
		public static var LOCALNAME:String = "feGaussianBlur";
		
		public var id:String;
		public var amount:Number;
		private var quality:int = Constants.BLUR_QUALITY;
		private var _result:String;
		private var _in:String;
		private var _in2:String;
		
		public function GaussianBlur( xml:XML ) 
		{
			parse( xml );
		}
		
		public function parse( xml:XML ):void 
		{
			id = xml.@id;
			amount = Number ( xml.@stdDeviation ) * 2.55;
		}
		
		public function getFlashFilter():BitmapFilter 
		{
			return new BlurFilter( amount , amount , quality ) as BitmapFilter;
		}
		
		public function setSourceGraphic( d:DisplayObject ):void { }

		
	}

}