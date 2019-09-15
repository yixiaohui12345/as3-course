package org.cache 
{
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	/**
	 * ...
	 * @author yxh
	 */
	public class LocalCache 
	{
		private var session:SharedObject = null;
		
		public static const LOGIN_CACHE:String = "loginCache";
		
		private static const NAME:String="course"
		
		public function LocalCache() 
		{
			session = SharedObject.getLocal(NAME , '/' );
		}
		
		private static var _inst:LocalCache = null;
		public static function get inst():LocalCache{
			if (_inst == null){
				_inst = new LocalCache();
			}
			return _inst;
		}
		
		public function clearData(key:String):void{
			if (session && session.data){
				session.data[key] = null;
			}
		}
		
		public function saveData(key:String,data:Object):void{
			try{
				if (session && session.data){
					session.data[key] = data;
					session.flush(500);
				}
			}
			catch (evt:Error){
				trace(evt.getStackTrace());
			}
		}
		
		public function getData(key:String):Object{
			if (session && session.data){
				return session.data[key];
			}
			return null;
		}
	}

}