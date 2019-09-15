package frameworks.model.command
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import mx.collections.ArrayCollection;
	
	/**
	 * ...
	 * @author yxh
	 */
	public class DisposeUtil
	{
		
		public function DisposeUtil()
		{
		
		}
		
		public static function Dispose(value:Object):void
		{
			if (value == null)
				return;
			if (value is Array)
			{
				ClearArray(value as Array);
			}
			else if (value is ArrayCollection)
			{
				ClearArrayCollection(value as ArrayCollection);
			}
			else if (value is Sprite)
			{
				DisposeSprite(value as Sprite);
			}
			else if (value is Dictionary)
			{
				ClearDictionary(value as Dictionary);
			}
		}
		
		private static function ClearArray(value:Array):void
		{
			if (value == null)
				return;
			while (value.length > 0)
			{
				var child:IDispose = value.pop() as IDispose;
				if (child != null)
					child.Dispose();
			}
		}
		
		private static function ClearArrayCollection(value:ArrayCollection):void
		{
			if (value == null)
				return;
			while (value.length > 0)
			{
				var child:IDispose = value.removeItemAt(0) as IDispose;
				if (child != null)
					child.Dispose();
			}
		}
		
		private static function DisposeSprite(value:Sprite):void
		{
			if (value == null)
				return;
			while (value.numChildren > 0)
			{
				var child:DisplayObject = value.removeChildAt(0);
				if (child is IDispose)
					IDispose(child).Dispose();
			}
		}
		
		private static function ClearDictionary(value:Dictionary):void
		{
			if (value == null)
				return;
			for each (var key:* in value)
			{
				var val:IDispose = value[key] as IDispose;
				if (value != null)
					val.Dispose();
				delete value[key];
			}
		}
	
	}

}