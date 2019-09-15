package frameworks.view.animate 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import frameworks.message.EffectConfig;
	import frameworks.message.OperateType;
	import frameworks.message.ViewMsg;
	import mvcexpress.mvc.Mediator;
	/**
	 * ...
	 * @author yxh
	 */
	public class AnimateMediator extends Mediator
	{
		[Inject]
		public var view:AnimationWidget
		
		public function AnimateMediator() 
		{
			
		}
		
		override protected function onRegister():void
		{
			view.resize();
			addListener(view.btn_add, MouseEvent.CLICK, addAnimation);
			addListener(view.btn_remove, MouseEvent.CLICK, removeAnimation);
			addListener(view.effectBox, Event.CHANGE, showAnimation);
		}
		
		private function showAnimation(e:Event):void 
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type:OperateType.PLAY, key:"animation", value:JSON.stringify(EffectConfig.ANI[view.effectBox.selectedIndex])});
		}
		
		private function removeAnimation(e:MouseEvent):void 
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type:OperateType.ADD_ANI, key:"animation", value:null});
		}
		
		private function addAnimation(e:MouseEvent):void 
		{
			EffectConfig.ANI[view.effectBox.selectedIndex].delay = view.last;
			EffectConfig.ANI[view.effectBox.selectedIndex].vars.delay = view.delay;
			sendMessage(ViewMsg.OPERATE_PAGE, {type:OperateType.ADD_ANI, key:"animation", value:JSON.stringify(EffectConfig.ANI[view.effectBox.selectedIndex])});
		}
		
		override protected function onRemove():void
		{
			removeAllListeners();
		}
	}

}