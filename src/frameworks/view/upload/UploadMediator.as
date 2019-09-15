package frameworks.view.upload 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import frameworks.message.OperateType;
	import frameworks.message.ViewMsg;
	import frameworks.model.PageProxy;
	import frameworks.model.vo.PageVO;
	import mvcexpress.mvc.Mediator;
	/**
	 * ...
	 * @author yxh
	 */
	public class UploadMediator extends Mediator
	{
		[Inject]
		public var view:UploadDialog;
		
		public function UploadMediator() 
		{
			
		}
		
		override protected function onRegister():void
		{
			view.resize();
			addListener(view.btn_cancel, MouseEvent.CLICK, handleCancel);
			addListener(view.btn_sure, MouseEvent.CLICK, handleSure);
		}
		
		private function handleCancel(e:MouseEvent):void 
		{
			closeHandler();
		}
		
		private function handleSure(e:MouseEvent):void 
		{
			var title:String = view.label_title.text;
			var description:String = view.label_description.text;
			var tag:String = view.combobox_tag.selectedLabel;
			var limitA:int = view.radio_author.selectedIndex;
			var proxy:PageProxy = proxyMap.getProxy(PageProxy) as PageProxy;
			var vector:Vector.<PageVO> = proxy.vector;
			sendMessage(ViewMsg.OPERATE_COURSE, {type:OperateType.UPLOAD_COURSE,title:title, description:description, tag:tag, limitA:limitA, vector:vector});
			
			closeHandler();
		}
		
		private function closeHandler():void 
		{
			view.dispose();
			view.remove();
		}
		
		override protected function onRemove():void
		{
			removeAllListeners();
		}
	}

}