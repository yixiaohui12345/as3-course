package frameworks.view.settings 
{
	import frameworks.events.CompEvent;
	import frameworks.message.OperateType;
	import frameworks.message.ViewMsg;
	import mvcexpress.mvc.Mediator;
	/**
	 * ...
	 * @author yxh
	 */
	public class SettingMediator extends Mediator
	{
		[Inject]
		public var view:SettingPanel
		
		public function SettingMediator() 
		{
			
		}
		
		override protected function onRegister():void
		{
			view.resize();
			addListener(view.bg_block, CompEvent.CHANGE_PROPERTY, handleBg);
		}
		
		private function handleBg(event:CompEvent):void
		{
			sendMessage(ViewMsg.OPERATE_PAGE, event.data);
		}
		
		override protected function onRemove():void
		{
			
		}
	}

}