package svgparser.parser.abstract
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import svgparser.parser.model.Data;
	import svgparser.parser.style.Style;
	import svgparser.parser.Constants;
	import svgparser.parser.IGradient;
	
	public class AbstractPaint
	{
		public function AbstractPaint() {}
		
		protected function paint( target:Shape, style:Style , data:Data ):void 
		{
			if ( data.hasParentStyle ) style.addStyle( data.getStyleXML() );
			if ( style.hasStroke  ) target.graphics.lineStyle( 	style.stroke_width, style.stroke, style.stroke_opacity, 
																Constants.LINE_PIXEL_HINTING, Constants.LINE_SCALE_MODE , 
																style.stroke_linecap ,style.stroke_linejoin, style.stroke_miterlimit  );
			if ( style.hasGradientStroke ) 
			{
				var sgrad:IGradient = data.getGradientById( style.stroke_id );
				if( sgrad ) target.graphics.lineGradientStyle( 	sgrad.type, sgrad.colors, sgrad.alphas, 
																sgrad.ratios, sgrad.matrix, sgrad.method );
			}
			if ( style.hasFill ) target.graphics.beginFill( style.fill , style.fill_opacity );
			if ( style.hasGradientFill ) 
			{
				var grad:IGradient = data.getGradientById( style.fill_id );
				if ( grad ) target.graphics.beginGradientFill( 	grad.type, grad.colors, grad.alphas , 
																grad.ratios , grad.matrix , grad.method  );
			}
			
			draw( target.graphics );	//draw graphics
			
			if ( style.hasFill || style.hasGradientFill || style.hasStroke ) target.graphics.endFill();
			style.applyStyle( target, data );
		}
		
		protected function draw( graphics:Graphics ):void 
		{
			throw new Error( "AbstractPaint draw method" );
		}		
	}

}