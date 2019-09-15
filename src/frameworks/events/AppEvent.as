package frameworks.events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author yxh
	 */
	public class AppEvent extends Event 
	{
		public static const UPDATE:String = "UPDATE"
		
		public static const RESIZE:String = "RESIZE";
		
		public static const REMOVED:String = "REMOVED";
		
		public static const CREATE:String = "CREATE";
		
		private var _data:Object = null;
		
		public function AppEvent(type:String, data:Object=null,bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			this.data = data;
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event 
		{ 
			return new AppEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("CompEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get data():Object 
		{
			return _data;
		}
		
		public function set data(value:Object):void 
		{
			_data = value;
		}
		
	}

}