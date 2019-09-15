
/* 
 * 我(TKCB)修改了部分代码：
 * 1. 修改了原有的类名，使之更简单
 * 2. 修改了6个属性参数，使之不单单作用于缩放时使用的参数
 * 3. 修改了cutOutShape()方法（旧的名字为cutOutSuper），添加了后面两个参数，可以定义裁切的开始坐标位置
 * 4. 修改了scaleX()和scaleY()方法，重写了位置设置的算法，旧的算法存在一定的BUG（舞台缩放时候位置偏差）
 * 5. 修改了skewX()和skewY()方法，添加了一个参数，可以定义倾斜时候的定轴位置（也就是那边不动）
 * 6. 重写了对齐和分布的所有的方法函数，因为之前的代码存在一定的BUG（舞台缩放时候位置偏差）
 */


package morn.core.utils
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 *  TransformerEasy 类包含各种对显示对象进行变形转换的方法，包括：裁剪、旋转、缩放、倾斜、对齐、分布。
	 */
	public class TransformerEasy
	{
		//************************ ************************* 缩放静态属性值 ******************** *********** *** **////
		/** 水平左边，水平缩放、倾斜、对齐、分布都会用到的位置（定轴）属性参数。 */
		public static const HORIZONAL_LEFT:String = "horizonalLeft";
		
		/** 水平中间，水平缩放、倾斜、对齐、分布都会用到的位置（定轴）属性参数。 */
		public static const HORIZONAL_CENTER:String = "horizonalCenter";
		
		/** 水平右边，水平缩放、倾斜、对齐、分布都会用到的位置（定轴）属性参数。 */
		public static const HORIZONAL_RIGHT:String = "horizonalRight";
		
		/** 垂直顶部，水平缩放、倾斜、对齐、分布都会用到的位置（定轴）属性参数。 */
		public static const VERTICAL_TOP:String = "verticalTop";
		
		/** 垂直中间，水平缩放、倾斜、对齐、分布都会用到的位置（定轴）属性参数。 */
		public static const VERTICAL_CENTER:String = "verticalCenter";
		
		/** 垂直底部，水平缩放、倾斜、对齐、分布都会用到的位置（定轴）属性参数。 */
		public static const VERTICAL_BOTTOM:String = "verticalBottom";
		
		
		//************************ ************************* 裁剪 ******************** *********** *** **////
		//------------------------------------------------------------
		//  裁剪
		//     |- 裁剪矩形
		//     |- 裁剪任意形状
		//------------------------------------------------------------
	    /**
	     *  裁剪指定矩形区域并返回一个包含结果的 BitmapData 对象。
	     *  @param target 需要裁剪的显示对象。
	     *  @param width 位图图像的宽度，以像素为单位。
	     *  @param height 位图图像的高度，以像素为单位。
	     *  @param distanceX 切割矩形左上角的点到显示对象矩形左上角的点的水平距离。注意：左上角的点不一定就是注册点（0, 0）外，变形过的显示对象就是一个例外。
	     *  @param distanceY 切割矩形左上角的点到显示对象矩形左上角的点的垂直距离。注意：左上角的点不一定就是注册点（0, 0）外，变形过的显示对象就是一个例外。
	     *  @param transparent 指定裁剪后的位图图像是否支持每个像素具有不同的透明度。默认值为 true（透明）。若要创建完全透明的位图，请将 transparent 参数的值设置为 true，将 fillColor 参数的值设置为 0x00000000（或设置为 0）。将 transparent 属性设置为 false 可以略微提升呈现性能。
	     *  @param fillColor 用于填充裁剪后的位图图像区域背景的 32 位 ARGB 颜色值。默认值为 0x00000000（纯透明黑色）。
	     *  @returns 返回裁剪后的 BitmapData 对象。
	     */
		public static function cutOutRect ( target:DisplayObject, width:Number, height:Number, distanceX:Number, distanceY:Number, transparent:Boolean = true, fillColor:uint = 0x00000000 ):BitmapData
		{
			var m:Matrix = target.transform.matrix;
			m.tx -= target.getBounds( target.parent ).x + distanceX;
			m.ty -= target.getBounds( target.parent ).y + distanceY;
			
			var bmpData:BitmapData = new BitmapData( width, height, transparent, fillColor );
			bmpData.draw( target, m );
			
			return bmpData;
		}
		
		/**
		 *  超级裁剪工具！可裁剪任意形状！给定一个裁剪目标和一个模板，就可根据模板裁剪出形状相配的 BitmapData 数据。
		 *  @param target 需要裁剪的显示对象。
		 *  @param template 裁剪模板，可以是任意形状。
		 *  @param distanceX 裁剪模板左上角的点到显示对象矩形左上角的点的水平距离。
	     *  @param distanceY 裁剪模板左上角的点到显示对象矩形左上角的点的垂直距离。
		 *  @returns 返回裁剪后的 BitmapData 对象。
		 */
		public static function cutOutShape ( target:DisplayObject, template:DisplayObject, distanceX:Number, distanceY:Number ):BitmapData
		{
			var rectTarget:Rectangle = target.transform.pixelBounds;
			var rectTemplate:Rectangle = template.transform.pixelBounds;
			var targetBitmapData:BitmapData = TransformerEasy.cutOutRect( target, rectTarget.width, rectTarget.height, 0, 0, true, 0x00000000 );
			var templateBitmapData:BitmapData = TransformerEasy.cutOutRect( template, rectTemplate.width, rectTemplate.height, 0, 0, true, 0x00000000 );
			
			var pixelY:int, pixelX:int, color:uint;
			for( pixelY = 0; pixelY < rectTemplate.height; pixelY++ )
			{
				for( pixelX = 0; pixelX < rectTemplate.width; pixelX++ )
				{
					if( templateBitmapData.getPixel( pixelX, pixelY ) != 0 )
					{
						color = targetBitmapData.getPixel32( pixelX + distanceX, pixelY + distanceY );
						templateBitmapData.setPixel32( pixelX, pixelY, color );
					}
				}
			}
			
			return templateBitmapData;
		}
		
		
		//************************ ************************* 旋转 ******************** *********** *** **////
		//------------------------------------------------------------
		//  旋转
		//     |- 绕内部点
		//     |- 绕外部点
		//------------------------------------------------------------
		/**
		 *  令显示对象围绕其内部的变形点进行旋转，旋转角度由 angleDegress 参数指定。
		 *  @param target 要进行旋转的显示对象。
		 *  @param x 该点的 x 坐标。
		 *  @param y 该点的 y 坐标。
		 *  @param angleDegrees 以度为单位的旋转角度。
		 */
		public static function rotateAroundInternalPoint ( target:DisplayObject, x:Number, y:Number, angleDegrees:Number ):void
		{
			var m:Matrix = target.transform.matrix;
			
			var point:Point = new Point( x, y );
			point = m.transformPoint( point );
			m.tx -= point.x;
			m.ty -= point.y;
			m.rotate( angleDegrees * Math.PI / 180 );
			m.tx += point.x;
			m.ty += point.y;
			
			target.transform.matrix = m;
		}
		
		/**
		 *  令显示对象围绕其父级中的变形点进行旋转，旋转角度由 angleDegress 参数指定。
		 *  @param target 要进行旋转的显示对象。
		 *  @param x 该点的 x 坐标。
		 *  @param y 该点的 y 坐标。
		 *  @param angleDegrees 以度为单位的旋转角度。
		 */
		public static function rotateAroundExternalPoint ( target:DisplayObject, x:Number, y:Number, angleDegrees:Number ):void
		{
			var m:Matrix = target.transform.matrix;
			
			m.tx -= x;
			m.ty -= y;
			m.rotate( angleDegrees * Math.PI / 180 );
			m.tx += x;
			m.ty += y;
			
			target.transform.matrix = m;
		}
		
		public static function scale(target:DisplayObject, newWidth:Number, newHeight:Number, type:int):void
		{
			var oldX:Number = target.x;
			var oldY:Number = target.y;
			var oldHeight:Number = target.height;
			var oldWidth : Number = target.width;
			var sx:Number = newWidth / target.width;
			var sy:Number = newHeight / target.height;
			var m:Matrix = target.transform.matrix;
			if (m.a > 1)
			{
				m.scale( -sx, -sy);
			}
			else
			{
				m.scale(sx, sy);
			}
			target.transform.matrix = m;
			switch( type )
			{
				case 1:
					target.x = oldX - (newWidth - oldWidth)
					target.y = oldY - (newHeight - oldHeight);
					break;
				case 2:
					break;
			}
		}
		
		//************************ ************************* 缩放 ******************** *********** *** **////
		//------------------------------------------------------------
		//  缩放
		//     |- 水平缩放
		//     |        |- 左边定轴
		//     |        |- 水平中间定轴
		//     |        |- 右边定轴
		//     |
		//     |- 垂直缩放
		//              |- 顶部定轴
		//              |- 垂直中间定轴
		//              |- 顶部定轴
		//  搭配
		//     |- 左边: horizonalLeft
		//     |- 水平中间: horizonalCenter
		//     |- 右边: horizonalRight
		//     |- 上边: verticalTop
		//     |- 垂直中间: verticalCenter
		//     |- 顶部: verticalBottom
		//------------------------------------------------------------
		/**
		 *  对显示对象进行水平缩放，缩放后的新宽度由 newWidth 指定。
		 *  @param target 要进行水平缩放的显示对象。
		 *  @param newWidth 水平缩放后新的宽度。可以为负值，负值表示翻转。
		 *  @param horizonalAxis 水平缩放的定轴。可选值有：horizonalLeft、horizonalCenter、horizonalRight。假如以左边为定轴进行缩放，则应值用 TransformerEasy.HORIZONAL_LEFT 值。
		 */
		public static function scaleX ( target:DisplayObject, newWidth:Number, horizonalAxis:String ):void
		{
			// 避免宽度被设为0
			if( newWidth == 0 )
			{
				newWidth = 1;
			}
			
			var oldX : Number = target.x;
			var oldWidth : Number = target.width;
			
			// 水平缩放
			var sx:Number = newWidth / target.width;
			var m:Matrix = target.transform.matrix;
			if( m.a < 0 )
			{
				m.scale( -sx, 1 );
			}else
			{
				m.scale( sx, 1 );
			}
			target.transform.matrix = m;
			
			var newWidth : Number = target.width;
			
			// 设置显示对象新的坐标值
			switch( horizonalAxis )
			{
				case TransformerEasy.HORIZONAL_LEFT:
					target.x = oldX;
					break;
					
				case TransformerEasy.HORIZONAL_CENTER:
					target.x = oldX - ((newWidth - oldWidth) / 2);
					break;
					
				case TransformerEasy.HORIZONAL_RIGHT:
					target.x = oldX - (newWidth - oldWidth);
					break;
				
				default:
					throw new Error( "TKCB Say：水平缩放时，指定的定轴类型不正确！" );
			}
		}
		
		/**
		 *  对显示对象进行垂直缩放，缩放后的新高度由 newHeight 指定。
		 *  @param target 要进行垂直缩放的显示对象。
		 *  @param newHeight 垂直缩放后新的高度。可以为负值，负值表示翻转。
		 *  @param verticalAxis 垂直缩放的定轴。可选值有：verticalTop、verticalCenter、verticalBottom。假如以顶部为定轴进行缩放，则应值用 TransformerEasy.VERTICAL_TOP 值。
		 */
		public static function scaleY ( target:DisplayObject, newHeight:Number, verticalAxis:String ):void
		{
			// 避免高度被设为0
			if( newHeight == 0 )
			{
				newHeight = 1;
			}
			
			var oldY : Number = target.y;
			var oldHeight : Number = target.height;
			
			// 垂直缩放
			var sy:Number = newHeight / target.height;
			var m:Matrix = target.transform.matrix;
			if( m.d < 0 )
			{
				m.scale( 1, -sy );
			}else
			{
				m.scale( 1, sy );
			}
			target.transform.matrix = m;
			
			var newHeight : Number = target.height;
			
			// 设置显示对象新的坐标值
			switch( verticalAxis )
			{
				case TransformerEasy.VERTICAL_TOP:
					target.y = oldY;
					break;
					
				case TransformerEasy.VERTICAL_CENTER:
					target.y = oldY - ((newHeight - oldHeight) / 2);
					break;
					
				case TransformerEasy.VERTICAL_BOTTOM:
					target.y = oldY - (newHeight - oldHeight);
					break;
				
				default:
					throw new Error( "TKCB Say：垂直缩放时，指定的定轴类型不正确！" );
			}
		}
		
		
		//************************ ************************* 倾斜 ******************** *********** *** **////
		//------------------------------------------------------------
		//  倾斜
		//     |- 水平倾斜
		//     |        |- 左边定轴
		//     |        |- 水平中间定轴
		//     |        |- 右边定轴
		//     |
		//     |- 垂直倾斜
		//              |- 顶部定轴
		//              |- 垂直中间定轴
		//              |- 顶部定轴
		//  搭配
		//     |- 左边: horizonalLeft
		//     |- 水平中间: horizonalCenter
		//     |- 右边: horizonalRight
		//     |- 上边: verticalTop
		//     |- 垂直中间: verticalCenter
		//     |- 顶部: verticalBottom
		//------------------------------------------------------------
		/**
		 *  对显示对象进行水平倾斜，倾斜的角度由 skewX 指定。
		 *  @param target 要进行水平倾斜的显示对象。
		 *  @param skewX 需要增加的水平倾斜度，以度为单位，可为负值。
		 *  @param horizonalAxis 水平倾斜的定轴。可选值有：horizonalLeft、horizonalCenter、horizonalRight。假如以左边为定轴进行倾斜，则应值用 TransformerEasy.HORIZONAL_LEFT 值。
		 */
		public static function skewX ( target:DisplayObject, skewX:Number, horizonalAxis:String ):void
		{
			// 用于设置坐标位置
			var oldX : Number = target.x;
			var oldWidth : Number = target.width;
			
			//// 倾斜算法
			var m:Matrix = target.transform.matrix;
			m.c += Math.tan( skewX * Math.PI / 180 );
			target.transform.matrix = m;
			
			// 用于设置坐标位置
			var newWidth : Number = target.width;
			
			// 设置显示对象新的坐标值
			switch( horizonalAxis )
			{
				case TransformerEasy.HORIZONAL_LEFT:
					target.x = oldX;
					
					// 定轴为左边框（下面这种算法是有问题的，会在舞台全屏或缩放的时候出现BUG）
					//m.tx -= newRect.x - oldRect.x;
					break;
					
				case TransformerEasy.HORIZONAL_CENTER:
					target.x = oldX - ((newWidth - oldWidth) / 2);
					
					// 定轴为水平中心轴（下面这种算法是有问题的，会在舞台全屏或缩放的时候出现BUG）
					//m.tx -= (newRect.x + newRect.width / 2) - (oldRect.x + oldRect.width / 2);
					break;
					
				case TransformerEasy.HORIZONAL_RIGHT:
					target.x = oldX - (newWidth - oldWidth);
					
					// 定轴为右边框（下面这种算法是有问题的，会在舞台全屏或缩放的时候出现BUG）
					//m.tx -= (newRect.x + newRect.width) - (oldRect.x + oldRect.width);
					break;
				
				default:
					throw new Error( "TKCB Say：水平倾斜，指定的定轴类型不正确！" );
			}
		}
		
		/**
		 *  对显示对象进行垂直倾斜，倾斜的角度由 skewY 指定。
		 *  @param target 要进行垂直倾斜的显示对象。
		 *  @param skewX 需要增加的垂直倾斜度，以度为单位，可为负值。
		 *  @param verticalAxis 垂直倾斜的定轴。可选值有：verticalTop、verticalCenter、verticalBottom。假如以顶部为定轴进行倾斜，则应值用 TransformerEasy.VERTICAL_TOP 值
		 */
		public static function skewY ( target:DisplayObject, skewY:Number, verticalAxis:String ):void
		{
			// 用于设置坐标位置
			var oldY : Number = target.y;
			var oldHeight : Number = target.height;
			
			//// 倾斜算法
			var m:Matrix = target.transform.matrix;
			m.b += Math.tan( skewY * Math.PI / 180 );
			target.transform.matrix = m;
			
			// 用于设置坐标位置
			var newHeight : Number = target.height;
			
			// 设置显示对象新的坐标值
			switch( verticalAxis )
			{
				case TransformerEasy.VERTICAL_TOP:
					target.y = oldY;
					
					// 定轴为上边框（下面这种算法是有问题的，会在舞台全屏或缩放的时候出现BUG）
					//m.ty -= newRect.y - oldRect.y;
					break;
					
				case TransformerEasy.VERTICAL_CENTER:
					target.y = oldY - ((newHeight - oldHeight) / 2);
					
					// 定轴为垂直中心轴（下面这种算法是有问题的，会在舞台全屏或缩放的时候出现BUG）
					//m.ty -= (newRect.y + newRect.height / 2) - (oldRect.y + oldRect.height / 2);
					break;
					
				case TransformerEasy.VERTICAL_BOTTOM:
					target.y = oldY - (newHeight - oldHeight);
					
					// 定轴为下边框（下面这种算法是有问题的，会在舞台全屏或缩放的时候出现BUG）
					//m.ty -= (newRect.y + newRect.height) - (oldRect.y + oldRect.height);
					break;
				
				default:
					throw new Error( "TKCB Say：垂直倾斜，指定的定轴类型不正确！" );
			}
		}
		
		
		//************************ ************************* 对齐 ******************** *********** *** **////
		//------------------------------------------------------------
		//  对齐
		//     |- 水平对齐
		//     |        |- 左边定轴
		//     |        |- 水平中间定轴
		//     |        |- 右边定轴
		//     |
		//     |- 垂直对齐
		//              |- 顶部定轴
		//              |- 垂直中间定轴
		//              |- 顶部定轴
		//  搭配
		//     |- 左边: horizonalLeft
		//     |- 水平中间: horizonalCenter
		//     |- 右边: horizonalRight
		//     |- 上边: verticalTop
		//     |- 垂直中间: verticalCenter
		//     |- 顶部: verticalBottom
		//------------------------------------------------------------
		/**
		 * 水平对齐给定的显示对象，所有显示对象将向指定的轴线进行对齐。
		 * @param targets 包含若干个显示对象的数组。
		 * @param horizonalAxis 水平对齐的定轴。可选值有：horizonalLeft、horizonalCenter、horizonalRight。假如以左边为定轴进行对齐，则应值用 TransformerEasy.HORIZONAL_LEFT 值。
		 */
		public static function alignX ( targets:Array, horizonalAxis:String ):void
		{
			if ( targets.length > 2 )
			{
				// 循环用到的变量
				var i:int, len:int = targets.length;
				
				// newX是最后确定的对齐轴线的坐标值，minX和maxX是最左边和最右边的对齐轴线的坐标值
				var newX:Number, minX:Number, maxX:Number;
				
				// 临时的显示对象矩阵对象和数组
				var rectArr:Array = [], rect:Rectangle;
				
				// 显示对象缩放前和缩放后的比例值，用于移动显示对象时候的坐标计算
				var sacle:Number = int(targets[i].transform.pixelBounds.width / targets[i].width * 1000) / 1000;
				//trace( "显示对象缩放前和缩放后的比例值：" + sacle );
				
				// 设置显示对象新的坐标值
				switch( horizonalAxis )
				{
					case TransformerEasy.HORIZONAL_LEFT:
						//// 循环找到最左边的对象的X坐标
						newX = 999999;
						for ( i = 0; i < len; i++ )
						{
							rect = targets[i].transform.pixelBounds;
							rectArr[i] = rect;
							if ( rect.x < newX )
							{
								newX = rect.x;
							}
						}
						//// 循环设置所有对象为新的X
						for ( i = 0; i < len; i++ )
						{
							targets[i].x -= (rectArr[i].x - newX) / sacle;
						}
						break;
						
					case TransformerEasy.HORIZONAL_CENTER:
						//// 循环找到最左边对象和最右边对象的坐标值，然后确定新的坐标值
						minX = 999999;
						maxX = -999999;
						for ( i = 0; i < len; i++ )
						{
							rect = targets[i].transform.pixelBounds;
							rectArr[i] = rect;
							if ( rect.x < minX )
							{
								minX = rect.x;
							}
							if ( rect.right > maxX )
							{
								maxX = rect.right;
							}
						}
						newX = minX + (maxX - minX) / 2;
						
						//// 循环设置所有对象为新的X
						for ( i = 0; i < len; i++ )
						{
							rect = rectArr[i];
							targets[i].x += (newX - rect.x  - (rect.width / 2)) / sacle;
						}
						break;
						
					case TransformerEasy.HORIZONAL_RIGHT:
						//// 循环找到最右边的对象的X坐标
						newX = -999999;
						for ( i = 0; i < len; i++ )
						{
							rect = targets[i].transform.pixelBounds;
							rectArr[i] = rect;
							if ( rect.right > newX )
							{
								newX = rect.right;
							}
						}
						//// 循环设置所有对象为新的X
						for ( i = 0; i < len; i++ )
						{
							targets[i].x += (newX - rectArr[i].right) / sacle;
						}
						break;
					
					default:
						throw new Error( "TKCB Say：水平对齐，指定的定轴类型不正确！" );
				}
			}
		}
		
		/**
		 * 垂直对齐给定的显示对象，所有显示对象将向指定的轴线进行对齐。
		 * @param targets 包含若干个显示对象的数组。
		 * @param verticalAxis 垂直对齐的定轴。可选值有：verticalTop、verticalCenter、verticalBottom。假如以顶部为定轴进行对齐，则应值用 TransformerEasy.VERTICAL_TOP 值
		 */
		public static function alignY ( targets:Array, verticalAxis:String ):void
		{
			if ( targets.length > 2 )
			{
				// 循环用到的变量
				var i:int, len:int = targets.length;
				
				// newX是最后确定的对齐轴线的坐标值，minX和maxX是最左边和最右边的对齐轴线的坐标值
				var newY:Number, minY:Number, maxY:Number;
				
				// 临时的显示对象矩阵对象和数组
				var rectArr:Array = [], rect:Rectangle;
				
				// 显示对象缩放前和缩放后的比例值，用于移动显示对象时候的坐标计算
				var sacle:Number = int(targets[i].transform.pixelBounds.height / targets[i].height * 1000) / 1000;
				//trace( "显示对象缩放前和缩放后的比例值：" + sacle );
				
				// 设置显示对象新的坐标值
				switch( verticalAxis )
				{
					case TransformerEasy.VERTICAL_TOP:
						//// 循环找到最左边的对象的Y坐标
						newY = 999999;
						for ( i = 0; i < len; i++ )
						{
							rect = targets[i].transform.pixelBounds;
							rectArr[i] = rect;
							if ( rect.y < newY )
							{
								newY = rect.y;
							}
						}
						//// 循环设置所有对象为新的Y
						for ( i = 0; i < len; i++ )
						{
							targets[i].y -= (rectArr[i].y - newY) / sacle;
						}
						break;
						
					case TransformerEasy.VERTICAL_CENTER:
						//// 循环找到最左边对象和最右边对象的坐标值，然后确定新的坐标值
						minY = 999999;
						maxY = -999999;
						for ( i = 0; i < len; i++ )
						{
							rect = targets[i].transform.pixelBounds;
							rectArr[i] = rect;
							if ( rect.y < minY )
							{
								minY = rect.y;
							}
							if ( rect.bottom > maxY )
							{
								maxY = rect.bottom;
							}
						}
						newY = minY + (maxY - minY) / 2;
						//// 循环设置所有对象为新的Y
						for ( i = 0; i < len; i++ )
						{
							rect = rectArr[i];
							targets[i].y += (newY - rect.y  - (rect.height / 2)) / sacle;
						}
						break;
					
					case TransformerEasy.VERTICAL_BOTTOM:
						//// 循环找到最右边的对象的Y坐标
						newY = -999999;
						for ( i = 0; i < len; i++ )
						{
							rect = targets[i].transform.pixelBounds;
							rectArr[i] = rect;
							if ( rect.bottom > newY )
							{
								newY = rect.bottom;
							}
						}
						//// 循环设置所有对象为新的Y
						for ( i = 0; i < len; i++ )
						{
							targets[i].y += (newY - rectArr[i].bottom) / sacle;
						}
						break;
				
					default:
						throw new Error( "TKCB Say：垂直对齐，指定的定轴类型不正确！" );
				}
			}
		}
		
		
		//************************ ************************* 分布 ******************** *********** *** **////
		//------------------------------------------------------------
		//  分布
		//     |- 水平分布
		//     |        |- 左边分布
		//     |        |- 水平居中分布
		//     |        |- 右边分布
		//     |
		//     |- 垂直分布
		//     |        |- 顶部分布
		//     |        |- 垂直居中分布
		//     |        |- 底部分布
		//  搭配
		//     |- 左边: horizonalLeft
		//     |- 水平中间: horizonalCenter
		//     |- 右边: horizonalRight
		//     |- 上边: verticalTop
		//     |- 垂直中间: verticalCenter
		//     |- 顶部: verticalBottom
		//------------------------------------------------------------
		/**
		 * 水平分布给定的显示对象，所有显示对象将向指定的轴线进行分布。
		 * @param targets 包含若干个显示对象的数组。
		 * @param horizonalAxis 水平分布的定轴。可选值有：horizonalLeft、horizonalCenter、horizonalRight。假如以左边为定轴进行分布，则应值用 TransformerEasy.HORIZONAL_LEFT 值。
		 */
		public static function distributeX ( targets:Array, horizonalAxis:String ):void
		{
			if ( targets.length > 2 )
			{
				// 循环用到的变量
				var i:int, j:int, len:int = targets.length, len2:int = len - 1;
				
				// 临时的显示对象矩阵对象和数组
				var rect:Rectangle, rect2:Rectangle;
				
				// 显示对象缩放前和缩放后的比例值，用于移动显示对象时候的坐标计算
				var sacle:Number = Math.round(targets[i].transform.pixelBounds.width / targets[i].width * 1000) / 1000;
				//trace( "显示对象缩放前和缩放后的比例值：" + sacle );
				
				// 用于排序和分布的临时数组，先复制数组，避免原数组的顺序被改变。
				var tempArr:Array = targets.slice();
				
				
				//// 给数组重新排序（冒泡排序，从小到大）
				// 每循环一轮，所有数字从新排序
				var temp:DisplayObject;		// 用于交换对象的临时变量
				for ( i = 1; i < len; i++ )
				{
					for ( j = 0; j < len2; j++ )
					{
						rect = tempArr[j].transform.pixelBounds;
						rect2 = tempArr[j+1].transform.pixelBounds;
						if ( rect.x > rect2.x )
						{
							temp = tempArr[j+1];
							tempArr[j+1] = tempArr[j];
							tempArr[j] = temp;
						}
					}
				}
				
				
				//// 设置显示对象新的坐标值
				// 用于判断排序对象是否过于紧密
				var tempNum1:Number, tempNum2:Number;
				
				// 显示对象之间的间隔对象值
				var intervalNum:Number;
				
				switch( horizonalAxis )
				{
					case TransformerEasy.HORIZONAL_LEFT:
						//// 获取用于判断是否过于紧密的参数，如果2大于1则是过于紧密
						tempNum1 = tempArr[1].transform.pixelBounds.right - tempArr[0].transform.pixelBounds.x;
						tempNum2 = tempArr[0].transform.pixelBounds.width + tempArr[1].transform.pixelBounds.width;
						
						//// 判断是否过于紧密，因为紧密的算法和宽松的算法不一样
						if ( tempNum1 > tempNum2 )
						{
							// 获取间隔数值
							intervalNum = tempArr[1].transform.pixelBounds.x - tempArr[0].transform.pixelBounds.right;
							
							//// 循环设置所有对象为新的X
							for ( i = 2; i < len; i++ )
							{
								tempArr[i].x -= (tempArr[i].transform.pixelBounds.x - tempArr[i-1].transform.pixelBounds.right - intervalNum) / sacle;
							}
						}
						else
						{
							/*（这是另一种以左边X轴为对齐轴的算法）
							// 获取间隔数值
							intervalNum = tempArr[1].transform.pixelBounds.x - tempArr[0].transform.pixelBounds.x;
							
							//// 循环设置所有对象为新的X
							for ( i = 2; i < len; i++ )
							{
								tempArr[i].x -= (tempArr[i].transform.pixelBounds.x - tempArr[i-1].transform.pixelBounds.x - intervalNum) / sacle;
							}*/
							
							// 获取间隔数值
							intervalNum = tempArr[0].transform.pixelBounds.right - tempArr[1].transform.pixelBounds.x;
							
							//// 循环设置所有对象为新的X
							for ( i = 2; i < len; i++ )
							{
								tempArr[i].x -= (tempArr[i].transform.pixelBounds.x - tempArr[i-1].transform.pixelBounds.right + intervalNum) / sacle;
							}
						}
						break;
						
					case TransformerEasy.HORIZONAL_CENTER:
						//// 获取用于判断是否过于紧密的参数，如果2大于1则是过于紧密
						tempNum1 = tempArr[tempArr.length-1].transform.pixelBounds.right - tempArr[0].transform.pixelBounds.x;
						tempNum2 = 0;
						for ( i = 0; i < len; i++ )
						{
							tempNum2 += tempArr[i].transform.pixelBounds.width;
						}
						
						//// 判断是否过于紧密，因为紧密的算法和宽松的算法不一样
						if ( tempNum1 > tempNum2 )
						{
							// 获取间隔数值
							intervalNum = (tempNum1 - tempNum2) / (tempArr.length-1);
							
							//// 循环设置所有对象为新的X
							for ( i = 1; i < len2; i++ )
							{
								tempArr[i].x -= (tempArr[i].transform.pixelBounds.x - tempArr[i-1].transform.pixelBounds.right - intervalNum) / sacle;
							}
						}
						else
						{
							// 获取间隔数值
							intervalNum = (tempNum2 - tempNum1) / (tempArr.length-1);
							
							//// 循环设置所有对象为新的X
							for ( i = 1; i < len2; i++ )
							{
								tempArr[i].x -= (tempArr[i].transform.pixelBounds.x - tempArr[i-1].transform.pixelBounds.right + intervalNum) / sacle;
							}
						}
						break;
					
					case TransformerEasy.HORIZONAL_RIGHT:
						//// 获取用于判断是否过于紧密的参数，如果2大于1则是过于紧密
						tempNum1 = tempArr[tempArr.length-1].transform.pixelBounds.right - tempArr[tempArr.length-2].transform.pixelBounds.x;
						tempNum2 = tempArr[tempArr.length-1].transform.pixelBounds.width + tempArr[tempArr.length-2].transform.pixelBounds.width;
						
						//// 判断是否过于紧密，因为紧密的算法和宽松的算法不一样
						if ( tempNum1 > tempNum2 )
						{
							// 获取间隔数值
							intervalNum = tempArr[tempArr.length-1].transform.pixelBounds.x - tempArr[tempArr.length-2].transform.pixelBounds.right;
							
							//// 循环设置所有对象为新的X
							for ( i = tempArr.length-3; i >= 0; i-- )
							{
								tempArr[i].x += (tempArr[i+1].transform.pixelBounds.x - tempArr[i].transform.pixelBounds.right - intervalNum) / sacle;
							}
						}
						else
						{
							/*（这是另一种以左边X轴为对齐轴的算法）
							// 获取间隔数值
							intervalNum = tempArr[tempArr.length-1].transform.pixelBounds.right - tempArr[tempArr.length-2].transform.pixelBounds.right;
							trace(intervalNum);
							//// 循环设置所有对象为新的X
							for ( i = tempArr.length-3; i >= 0; i-- )
							{
								
								tempArr[i].x += (tempArr[i+1].transform.pixelBounds.right - tempArr[i].transform.pixelBounds.right - intervalNum) / sacle;
							}*/
							
							// 获取间隔数值
							intervalNum = tempArr[tempArr.length-2].transform.pixelBounds.right - tempArr[tempArr.length-1].transform.pixelBounds.x;
							
							//// 循环设置所有对象为新的X
							for ( i = tempArr.length-3; i >= 0; i-- )
							{
								tempArr[i].x -= (tempArr[i].transform.pixelBounds.right - tempArr[i+1].transform.pixelBounds.x - intervalNum) / sacle;
							}
						}
						break;
						
					default:
						throw new Error( "TKCB Say：水平分布，指定的定轴类型不正确！" );
				}
			}
		}
		
		/**
		 * 垂直分布给定的显示对象，所有显示对象将向指定的轴线进行分布。
		 * @param targets 包含若干个显示对象的数组。
		 * @param verticalAxis 垂直分布的定轴。可选值有：verticalTop、verticalCenter、verticalBottom。假如以顶部为定轴进行分布，则应值用 TransformerEasy.VERTICAL_TOP 值。
		 */
		public static function distributeY ( targets:Array, verticalAxis:String ):void
		{
			if ( targets.length > 2 )
			{
				// 循环用到的变量
				var i:int, j:int, len:int = targets.length, len2:int = len - 1;
				
				// 临时的显示对象矩阵对象和数组
				var rect:Rectangle, rect2:Rectangle;
				
				// 显示对象缩放前和缩放后的比例值，用于移动显示对象时候的坐标计算
				var sacle:Number = Math.round(targets[i].transform.pixelBounds.height / targets[i].height * 1000) / 1000;
				//trace( "显示对象缩放前和缩放后的比例值：" + sacle );
				
				// 用于排序和分布的临时数组，先复制数组，避免原数组的顺序被改变。
				var tempArr:Array = targets.slice();
				
				
				//// 给数组重新排序（冒泡排序，从小到大）
				// 每循环一轮，所有数字从新排序
				var temp:DisplayObject;		// 用于交换对象的临时变量
				for ( i = 1; i < len; i++ )
				{
					for ( j = 0; j < len2; j++ )
					{
						rect = tempArr[j].transform.pixelBounds;
						rect2 = tempArr[j+1].transform.pixelBounds;
						if ( rect.y > rect2.y )
						{
							temp = tempArr[j+1];
							tempArr[j+1] = tempArr[j];
							tempArr[j] = temp;
						}
					}
				}
				
				
				//// 设置显示对象新的坐标值
				// 用于判断排序对象是否过于紧密
				var tempNum1:Number, tempNum2:Number;
				
				// 显示对象之间的间隔对象值
				var intervalNum:Number;
				
				switch( verticalAxis )
				{
					case TransformerEasy.VERTICAL_TOP:
						//// 获取用于判断是否过于紧密的参数，如果2大于1则是过于紧密
						tempNum1 = tempArr[1].transform.pixelBounds.bottom - tempArr[0].transform.pixelBounds.y;
						tempNum2 = tempArr[0].transform.pixelBounds.height + tempArr[1].transform.pixelBounds.height;
						
						//// 判断是否过于紧密，因为紧密的算法和宽松的算法不一样
						if ( tempNum1 > tempNum2 )
						{
							// 获取间隔数值
							intervalNum = tempArr[1].transform.pixelBounds.y - tempArr[0].transform.pixelBounds.bottom;
							
							//// 循环设置所有对象为新的X
							for ( i = 2; i < len; i++ )
							{
								tempArr[i].y -= (tempArr[i].transform.pixelBounds.y - tempArr[i-1].transform.pixelBounds.bottom - intervalNum) / sacle;
							}
						}
						else
						{
							/*（这是另一种以左边X轴为对齐轴的算法）
							// 获取间隔数值
							intervalNum = tempArr[1].transform.pixelBounds.y - tempArr[0].transform.pixelBounds.y;
							
							//// 循环设置所有对象为新的X
							for ( i = 2; i < len; i++ )
							{
								tempArr[i].y -= (tempArr[i].transform.pixelBounds.y - tempArr[i-1].transform.pixelBounds.y - intervalNum) / sacle;
							}*/
							
							// 获取间隔数值
							intervalNum = tempArr[0].transform.pixelBounds.bottom - tempArr[1].transform.pixelBounds.y;
							
							//// 循环设置所有对象为新的X
							for ( i = 2; i < len; i++ )
							{
								tempArr[i].y -= (tempArr[i].transform.pixelBounds.y - tempArr[i-1].transform.pixelBounds.bottom + intervalNum) / sacle;
							}
						}
						break;
						
					case TransformerEasy.VERTICAL_CENTER:
						//// 获取用于判断是否过于紧密的参数，如果2大于1则是过于紧密
						tempNum1 = tempArr[tempArr.length-1].transform.pixelBounds.bottom - tempArr[0].transform.pixelBounds.y;
						tempNum2 = 0;
						for ( i = 0; i < len; i++ )
						{
							tempNum2 += tempArr[i].transform.pixelBounds.height;
						}
						
						//// 判断是否过于紧密，因为紧密的算法和宽松的算法不一样
						if ( tempNum1 > tempNum2 )
						{
							// 获取间隔数值
							intervalNum = (tempNum1 - tempNum2) / (tempArr.length-1);
							
							//// 循环设置所有对象为新的X
							for ( i = 1; i < len2; i++ )
							{
								tempArr[i].y -= (tempArr[i].transform.pixelBounds.y - tempArr[i-1].transform.pixelBounds.bottom - intervalNum) / sacle;
							}
						}
						else
						{
							// 获取间隔数值
							intervalNum = (tempNum2 - tempNum1) / (tempArr.length-1);
							
							//// 循环设置所有对象为新的X
							for ( i = 1; i < len2; i++ )
							{
								tempArr[i].y -= (tempArr[i].transform.pixelBounds.y - tempArr[i-1].transform.pixelBounds.bottom + intervalNum) / sacle;
							}
						}
						break;
					
					case TransformerEasy.VERTICAL_BOTTOM:
						//// 获取用于判断是否过于紧密的参数，如果2大于1则是过于紧密
						tempNum1 = tempArr[tempArr.length-1].transform.pixelBounds.bottom - tempArr[tempArr.length-2].transform.pixelBounds.y;
						tempNum2 = tempArr[tempArr.length-1].transform.pixelBounds.height + tempArr[tempArr.length-2].transform.pixelBounds.height;
						
						//// 判断是否过于紧密，因为紧密的算法和宽松的算法不一样
						if ( tempNum1 > tempNum2 )
						{
							// 获取间隔数值
							intervalNum = tempArr[tempArr.length-1].transform.pixelBounds.y - tempArr[tempArr.length-2].transform.pixelBounds.bottom;
							
							//// 循环设置所有对象为新的X
							for ( i = tempArr.length-3; i >= 0; i-- )
							{
								tempArr[i].y += (tempArr[i+1].transform.pixelBounds.y - tempArr[i].transform.pixelBounds.bottom - intervalNum) / sacle;
							}
						}
						else
						{
							/*（这是另一种以左边X轴为对齐轴的算法）
							// 获取间隔数值
							intervalNum = tempArr[tempArr.length-1].transform.pixelBounds.bottom - tempArr[tempArr.length-2].transform.pixelBounds.bottom;
							trace(intervalNum);
							//// 循环设置所有对象为新的X
							for ( i = tempArr.length-3; i >= 0; i-- )
							{
								
								tempArr[i].y += (tempArr[i+1].transform.pixelBounds.bottom - tempArr[i].transform.pixelBounds.bottom - intervalNum) / sacle;
							}*/
							
							// 获取间隔数值
							intervalNum = tempArr[tempArr.length-2].transform.pixelBounds.bottom - tempArr[tempArr.length-1].transform.pixelBounds.y;
							
							//// 循环设置所有对象为新的X
							for ( i = tempArr.length-3; i >= 0; i-- )
							{
								tempArr[i].y -= (tempArr[i].transform.pixelBounds.bottom - tempArr[i+1].transform.pixelBounds.y - intervalNum) / sacle;
							}
						}
						break;
						
					default:
						throw new Error( "TKCB Say：垂直分布，指定的定轴类型不正确！" );
				}
			}
		}
		
		
		
	}
}