package org.utils
{
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author yxh
	 */
	public class StringUtils
	{
		
		public function StringUtils()
		{
		
		}
		
		public static function isEmpty(value:String):Boolean{
			return !(value && value.length > 0)
		}
		
		public static function convertToByteArray(str:String):ByteArray
		{
			var bytes:ByteArray;
			if (str)
			{
				bytes = new ByteArray();
				bytes.writeUTFBytes(str);
			}
			return bytes;
		}
		
		public static function convertToString(bytes:ByteArray):String
		{
			var str:String;
			if (bytes)
			{
				bytes.position = 0;
				str = bytes.readUTFBytes(bytes.length);
			}
			
			return str;
		}
	}

}