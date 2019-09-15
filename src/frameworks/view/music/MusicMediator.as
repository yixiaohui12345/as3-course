package frameworks.view.music 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import frameworks.message.OperateType;
	import frameworks.message.ViewMsg;
	import frameworks.view.widget.Alert;
	import morn.core.events.UIEvent;
	import mvcexpress.mvc.Mediator;
	/**
	 * ...
	 * @author yxh
	 */
	public class MusicMediator extends Mediator
	{
		[Inject]
		public var view:MusicPanel
		
		public function MusicMediator() 
		{
			
		}
		
		override protected function onRegister():void
		{
			view.resize();
			addListener(view.btn_insert, MouseEvent.CLICK, handleInsert);
			addListener(view.btn_upload, MouseEvent.CLICK, handleUpload);
			addListener(view.volumeSlider, UIEvent.SCROLL_END, handleVolume);
			addListener(view.delaySlider, UIEvent.SCROLL_END, handleDelay);
		}
		
		private function handleVolume(e:UIEvent):void 
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type:OperateType.MODIFY, key:"volume", value:view.volumeSlider.value});
		}
		
		private function handleDelay(e:UIEvent):void 
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type:OperateType.MODIFY, key:"delaySec", value:view.delaySlider.value});
		}
		
		private function handleUpload(e:MouseEvent):void 
		{
			Alert.inst.show("该功能暂时不对外开放");
		}
		
		private function handleInsert(e:MouseEvent):void 
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type:OperateType.ADD_MUSIC, url:view.label_url.text});
		}
		
		override protected function onRemove():void
		{
			
		}
	}

}