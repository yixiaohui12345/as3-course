package org.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.PNGEncoderOptions;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.BitmapData;
	import flash.display.JPEGEncoderOptions
	import flash.utils.ByteArray;

	/**
	 * ...
	 * @author yxh
	 */
	public class DrawHelper  
	{
		public static const JPG:String = "jpg";
		
		public static const PNG:String = "png";
		
		public static function createThumbnailByType(source:DisplayObject, targetRect:Rectangle, full:Boolean = true):Bitmap
		{
			var rect:Rectangle = source.getBounds(source);
			var scale:Number = 0;
			var perw:Number = targetRect.width / rect.width;
			var perh:Number = targetRect.height / rect.height;
			if (rect.width > rect.height)
			{
				if (rect.width>targetRect.width)
				{
					if (rect.height > targetRect.height)
					{
						scale = perw > perh?perw:perh;
					}
					else
					{
						scale =perw
					}
				}
				else
				{
					scale = 1;
				}
			}
			else if (rect.width < rect.height)
			{
				if (rect.height > targetRect.height)
				{
					if (rect.width > targetRect.width)
					{
						scale =  perw > perh?perw:perh;
					}
					else
					{
						scale=perh
					}
				}
				else
				{
					scale = 1
				}
			}
			else
			{
				if (rect.height > targetRect.height)
				{
					scale = targetRect.height / rect.height;
				}
				else
				{
					scale=1
				}
			}
			//var perw:Number = targetRect.width / rect.width;
			//var perh:Number = targetRect.height / rect.height;
			 //var scale:Number = (full==true)?((perw <= perh)?perw:perh):((perw <= perh)?perh:perw); 
			var offerW:Number = (targetRect.width - rect.width * scale) / 2;  
			var offerH:Number = (targetRect.height - rect.height * scale) / 2;  
			var bmd:BitmapData = new BitmapData(targetRect.width,targetRect.height,true,0x000000);
			var matrix:Matrix = new Matrix();
			matrix.scale(scale, scale);
			matrix.translate( offerW, offerH);  
			bmd.draw(source, matrix);
			//if (source is Bitmap)
			//{
				//(source as Bitmap).bitmapData.dispose();
			//}
			var bmp:Bitmap = new Bitmap(bmd,"auto",true);
			return bmp;
		}
		
		public static function copyBitmap(bmd:BitmapData, rect:Rectangle, point:Point):Bitmap
		{
			var bitmapData:BitmapData = new BitmapData(rect.width, rect.height, true, 1)
			bitmapData.copyPixels(bmd, rect, point);
			var bitmap:Bitmap = new Bitmap(bitmapData, PixelSnapping.AUTO, true);
			return bitmap;
		}
		
		public static function copyBitmapData(bmd:BitmapData):BitmapData
		{
			if (bmd == null)
			{
				return null;
			}
			var temp:BitmapData = new BitmapData(bmd.rect.width, bmd.rect.height, bmd.transparent);
			temp.copyPixels(bmd, bmd.rect, new Point(0, 0));
			return temp;
		}
	
		/**
		 * 获取缩略图
		 * @param	source       目标
		 * @param	targetRect   目标宽高
		 * @param	full         是否全显示
		 * @return
		 */
		public static function createThumbnail(source:DisplayObject,targetRect:Rectangle, full:Boolean = true):BitmapData
		{
			//获取显示对象矩形范围
			var rect:Rectangle = source.getBounds(source);
			//计算出应当缩放的比例
			var perw:Number = targetRect.width / rect.width;
			var perh:Number = targetRect.height / rect.height;
			//var scale:Boolean =(full==true)? ((perw <= perh) ? perw : perh) : ((perw <= perh) ? perh : perw);
			//计算缩放后与规定尺寸之间的偏移量
			
			//开始绘制快照（这里透明参数是false,是方便观察效果，实际应用可改为true)
			var bmd:BitmapData = new BitmapData(targetRect.width, targetRect.height, false, 0xffffff);
			var matrix:Matrix = new Matrix();
			matrix.scale(perw, perh);
			bmd.draw(source, matrix);
			if (source is Bitmap)
			{
				(source as Bitmap).bitmapData.dispose();
			}
			//var bmp:Bitmap = new Bitmap(bmd, "auto", true);
			return bmd;
		}
		
		public static function DrawMovieClip(target:DisplayObject,rect:Rectangle):Bitmap
		{
			var _rect:Rectangle = new Rectangle(rect.x, rect.y, rect.width, rect.height);
			var bmd:BitmapData = new BitmapData(rect.width, rect.height, true, 0xffffff);
			
			bmd.draw(target,null,null,null,rect,true)
			var bitmap:Bitmap = new Bitmap(bmd);
			if (target is Bitmap)
			{
				Bitmap(target).bitmapData.dispose();
			}
			return bitmap;
			
		}
		
		/**
		 * displayobject 转 byteArray
		 * @param	target   截取目标对象
		 * @param	rect     截取范围
		 * @return
		 */
		public static function DisplayObjectToByteArray(target:DisplayObject,rect:Rectangle):ByteArray
		{
			//modify at 2014-6-16 by yxh
			var _rect:Rectangle = new Rectangle(rect.x, rect.y, rect.width, rect.height);
			var bmd:BitmapData = new BitmapData(_rect.width, _rect.height, true);
			bmd.draw(target);
			
			var pixels:ByteArray = new ByteArray();
			bmd.encode(bmd.rect,new flash.display.JPEGEncoderOptions(),pixels);
			
			return pixels;
		}
		
		/**
		 * 已经截取好的bitmap转化为bytearray
		 * @param	bitmap
		 * @return
		 */
		public static function BitmapToByteArray(bitmap:Bitmap,type:String=PNG):ByteArray
		{
			if (bitmap == null)
			{
				return null;
			}
			
			var pixels:ByteArray = new ByteArray();
			var bmd:BitmapData = null;
			if (type == JPG)
			{
				bmd = new BitmapData(bitmap.width, bitmap.height, true);
				bmd.draw(bitmap);
				bmd.encode(bmd.rect, new flash.display.JPEGEncoderOptions(), pixels);
			}
			else if(type==PNG)
			{
				bmd = new BitmapData(bitmap.width, bitmap.height, true, 0xffffff);
				//bmd = bitmap.bitmapData.clone();
				bmd.copyPixels(bitmap.bitmapData, new Rectangle(0, 0, bitmap.width, bitmap.height), new Point(0, 0));
				bmd.encode(bmd.rect, new PNGEncoderOptions(), pixels);
			}
			return pixels;
		
		}
		
		/**
		 * 获取原始bitmapdata二进制数据
		 * @param	bmd
		 * @return
		 */
		public static function getBitmapDataPixels(bitmapData:BitmapData):ByteArray
		{
			if (bitmapData == null)
			{
				return null;
			}
			var bytes:ByteArray = new ByteArray();
			bytes = bitmapData.getPixels(bitmapData.rect);
			bitmapData.dispose();
			bitmapData = null;
			return bytes;
		}
		
		/**
		 * 
		 * @param	bitmap
		 * @param	type
		 * @param	quality
		 * @return
		 */
		public static function BitmapToByteArrayS(bitmap:Bitmap, type:int=1, quality:int = 80):ByteArray
		{
			if (bitmap == null)
			{
				return null;
			}
			
			var byteArray:ByteArray =  new ByteArray();
			if (type == 1)
			{
				bitmap.bitmapData.encode(bitmap.getBounds(bitmap), new JPEGEncoderOptions(quality), byteArray);
			}
			else
			{
				bitmap.bitmapData.encode(bitmap.getBounds(bitmap), new PNGEncoderOptions(), byteArray);
			}
			return byteArray;
		}
	}
	
}