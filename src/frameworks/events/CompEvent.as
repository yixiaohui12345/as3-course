package frameworks.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author yxh
	 */
	public class CompEvent extends Event 
	{
		
		
		public static const CHANGE_SCALE:String = "changeScale";
		
		public static const PREVIEW:String = "preview";
		
		public static const CHANGE_CMD:String = "commandChange";
		
		public static const PLAY:String = "play";
		
		public static const PAUSE:String = "pause";
		
		public static const LOAD_TXT:String = "loadTxt";
		
		public static const LOAD_PIC:String = "loadPic";
		
		public static const LOAD_LOCAL_PIC:String = "loadLocalPic";
		
		public static const LOAD_VCR:String="loadVcr"
		
		public static const DELETE_PAGE:String = "deletePage";
		
		public static const SHOW_PAGE:String = "showPage";
		
		public static const SELECT:String = "select";
		
		public static const CHANGE_ACCOUNT:String = "changeAccount";
		
		public static const CHANGE_PROPERTY:String = "changeProperty";
		
		private var _data:Object = null;
		
		public function CompEvent(type:String, data:Object=null,bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			this.data = data;
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new CompEvent(type, bubbles, cancelable);
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