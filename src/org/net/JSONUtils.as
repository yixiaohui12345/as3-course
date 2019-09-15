package org.net 
{
	import com.maccherone.json.JSON;
	/**
	 * ...
	 * @author ...
	 */
	public class JSONUtils 
	{
		
		public function JSONUtils() 
		{
			
		}
		
		public static function decode(str:String):Object
		{
			try
			{
				var obj:Object =com.maccherone.json.JSON.decode(str);
				return obj;
			}
			catch (evt:Error)
			{
				
			}
			return null;
		}
		
	}

}