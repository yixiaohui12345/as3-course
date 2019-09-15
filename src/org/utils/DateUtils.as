package org.utils 
{
	/**
	 * ...
	 * @author yxh
	 */
	public class DateUtils 
	{
		
		public function DateUtils() 
		{
			
		}
		
		public static function getDate(year:int,month:int,date:int,hours:int,minutes:int,seconds:int):Date
		{
			var d:Date = new Date(year, month, date, hours, minutes, seconds);
			return d
		}
		
		
		public static function getDateTime(time:Number):Date
		{
			var date:Date = new Date();
			date.time = time;
			return date
		}
		
		public static function getDateString(date:Date):String
		{
			return date.fullYear + "-" + String(date.month + 1) + "-" + date.date;
		}
		
		public static function getfullDateString(date:Date):String
		{
			return date.fullYear + "-" + String(date.month + 1) + "-" + date.date+" " + date.hours + ":" + date.minutes + ":" + date.seconds;
		}
		
		public static function getTime():Number
		{
			var date:Date = new Date();
			var t:Number = date.getTime();
			date = null;
			return t
		}
		
	}

}