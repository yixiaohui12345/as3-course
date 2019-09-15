package org.net 
{
	/**
	 * ...
	 * @author ...
	 */
	public class HttpConfig 
	{
		
		public function HttpConfig() 
		{
			
		}
		
		public static var online:Boolean = true;
		
		/**
		 * 是否同步数据
		 */
		public static var isSyncData:Boolean = false;
		
		/**
		 * 同步数据时间间隔
		 */
		public static var interval:int = 60 * 1000;
		
		
	}

}