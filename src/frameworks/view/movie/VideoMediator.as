package frameworks.view.movie 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import frameworks.common.Source;
	import frameworks.events.CompEvent;
	import frameworks.message.DataMsg;
	import frameworks.message.OperateType;
	import frameworks.message.ViewMsg;
	import frameworks.model.vo.MovieVO;
	import mvcexpress.mvc.Mediator;
	/**
	 * ...
	 * @author yxh
	 */
	public class VideoMediator extends Mediator
	{
		[Inject]
		public var view:VideoNav
		
		public function VideoMediator() 
		{
			
		}
		
		override protected function onRegister():void
		{
			view.resize();
			addListener(view.noerMovie, CompEvent.LOAD_VCR, insertHandler);
			addListener(view.noerMovie.tabFree, Event.CHANGE, selectMovieListHandle);
			addHandler(DataMsg.RESPONSE_MOVIE, updateList);
			selectMovieListHandle();
		}
		
		private function insertHandler(e:CompEvent):void 
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type:OperateType.ADD_MOVIE, url:e.data});
		}
		
		private function updateList(vo:MovieVO):void 
		{
			view.noerMovie.updateList(vo)
		}
		
		private function selectMovieListHandle(e:Event=null):void
		{
			sendMessage(ViewMsg.SEND_MOVIE, {requestType:"MovieProxy", pid:Source.PID_LIST[view.noerMovie.tabFree.selectedIndex]});
		}
		
		override protected function onRemove():void
		{
			removeAllListeners();
		}
		
	}

}