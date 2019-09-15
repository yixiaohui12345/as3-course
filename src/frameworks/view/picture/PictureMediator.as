package frameworks.view.picture 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import frameworks.common.Source;
	import frameworks.events.CompEvent;
	import frameworks.message.DataMsg;
	import frameworks.message.OperateType;
	import frameworks.message.ViewMsg;
	import frameworks.model.vo.MaterialVO;
	import frameworks.model.vo.PictureVO;
	import mvcexpress.mvc.Mediator;
	/**
	 * ...
	 * @author yxh
	 */
	public class PictureMediator extends Mediator
	{
		[Inject]
		public var view:PictureNav;
		
		public function PictureMediator() 
		{
			
		}
		
		override protected function onRegister():void
		{
			view.resize();
			addListener(view.noerPic.tabType, Event.CHANGE, selectKindHandler);
			addListener(view.noerPic, CompEvent.SELECT, selectBookHandler);
			addListener(view.noerPic, CompEvent.LOAD_PIC, insertHandler);
			addListener(view.myPic, CompEvent.LOAD_LOCAL_PIC, insertHandler);
			
			addHandler(DataMsg.RESPONSE_BOOK_LIB, handleBookLib);
			addHandler(DataMsg.RESPONSE_BOOK_MATERIAL, handleMaterial);
			selectKindHandler();
		}
		
		private function insertHandler(e:CompEvent):void 
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type:OperateType.ADD_IMAGE, url:e.data});
		}
		
		private function selectBookHandler(e:CompEvent):void 
		{
			sendMessage(ViewMsg.SEND_BOOK,e.data)
		}
		
		private function handleMaterial(vo:MaterialVO):void
		{
			view.noerPic.updateMaterialCover(vo);
		}
		
		private function handleBookLib(vo:PictureVO):void
		{
			view.noerPic.updatePictureCover(vo);
		}
		
		private function selectKindHandler(e:Event=null):void 
		{
			sendMessage(ViewMsg.SEND_BOOK, {requestType:"PictureBookLibProxy",btypeid:null, booktype:Source.PID_LIST[view.noerPic.tabType.selectedIndex], pagenow:1});
		}
		
		override protected function onRemove():void
		{
			view.remove();
			removeAllListeners();
		}
	}

}