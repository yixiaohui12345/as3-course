package org.utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Transform;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import flash.net.registerClassAlias;
	/**
	 * ...
	 * @author ...
	 */
	public class ArrayUtils 
	{
		
		public function ArrayUtils() 
		{
			
		
		}
		
		public static function cloneArray(data:Array):Array
		{
			if (data == null){
				return null;
			}
			var arr:Array = null;
			var copier:ByteArray = new ByteArray();
			copier.writeObject(data);
			copier.position = 0;
			arr = copier.readObject() as Array;
			copier.clear();
			copier = null;
			return arr
		}
	}

}