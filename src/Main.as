package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import morn.core.handlers.Handler;
	import mouse.MouseModules;
	import org.utils.DateUtils;
	
	/**
	 * ...
	 * @author yxh
	 */
	public class Main extends Sprite 
	{
		private var mainModules:MainModules
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			App.init(this);
			App.loader.loadTXT("config/update.xml?v="+DateUtils.getTime(), new Handler(updateComplete));
		}
		
		private function updateComplete(result:String):void{
			var arr:Array=[]
			try
			{
				var xml:XML = new XML(result);
				for (var i:int = 0, len:int = xml.Item.length(); i < len; i++){
					arr[i] = xml.Item[i].@url + "?v=" + xml.Item[i].@version;
				}
			}
			catch (evt:Error){
				
			}
			if (arr == null || arr.length == 0){
				App.loader.loadAssets(["assets/comp.swf?v=" + DateUtils.getTime(), "assets/style.swf?v=" + DateUtils.getTime()], new Handler(completeHandle));
			}else{
				App.loader.loadAssets(arr, new Handler(completeHandle));
			}
			
		}
		
		private function completeHandle():void
		{
			MouseModules.inst.init();
			mainModules = new MainModules();
			mainModules.start(this);
		}
	}
	
}