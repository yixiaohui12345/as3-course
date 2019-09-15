package org.utils 
{
	/**
	 * ...
	 * @author yxh
	 */
	public class RegExpUtils 
	{
		private static const pattern:RegExp =/[a-zA-z]+:\/\/[^\s]*/;
		public function RegExpUtils() 
		{
			
		}
		
		public static function checkNet(url:String):Boolean
		{
			return pattern.test(url);
		}
	}

}