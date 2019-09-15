package frameworks.view.course 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import frameworks.common.Source;
	import frameworks.events.AppEvent;
	import frameworks.events.CompEvent;
	import frameworks.message.DataMsg;
	import frameworks.message.OperateType;
	import frameworks.message.ViewMsg;
	import morn.core.events.UIEvent;
	import mvcexpress.mvc.Mediator;
	/**
	 * ...
	 * @author yxh
	 */
	public class CourseMediator extends Mediator
	{
		[Inject]
		public var view:CourseNative
		
		public function CourseMediator() 
		{
			
		}
		
		override protected function onRegister():void
		{
			view.resize();
			addListener(view.btn_search, MouseEvent.CLICK, onSearchEvent);
			addListener(view.btn_home, MouseEvent.CLICK, onHomeEvent);
			addListener(view.tab, Event.CHANGE, onTabChangeEvent);
			addListener(view, CompEvent.PREVIEW, onPreviewEvent);
			addListener(view, AppEvent.UPDATE, onUpdateEvent);
			addHandler(DataMsg.UPDATE_COURSE, handleUpdateCourse);
			
		}
		
		private function onUpdateEvent(e:AppEvent):void
		{
			onTabChangeEvent();
		}
		
		private function onPreviewEvent(e:CompEvent):void 
		{
			sendMessage(ViewMsg.OPERATE_COURSE, e.data);
		}
		
		private function handleUpdateCourse(data:Object):void 
		{
			view.updateCourse(data);
		}
		
		private function onTabChangeEvent(e:Event=null):void 
		{
			switch(view.tab.selectedIndex)
			{
				case 0:
					sendMessage(ViewMsg.OPERATE_COURSE, {type:OperateType.QUERY_COURSE, tag:"", limitA:0, title:null, pageCount:1, count:9});
					break;
				default:
					sendMessage(ViewMsg.OPERATE_COURSE, {type:OperateType.QUERY_COURSE, tag:Source.SUBJECT[view.tab.selectedIndex], limitA:null, title:null, pageCount:1, count:9});
					break;
			}
		}
		
		private function onSearchEvent(e:MouseEvent):void 
		{
			sendMessage(ViewMsg.OPERATE_COURSE, {type:OperateType.QUERY_COURSE, tag:null, limitA:null, title:view.label_search.text, pageCount:1, count:9});
		}
		
		private function onHomeEvent(e:MouseEvent):void 
		{
			view.remove();
			view.sendEvent(UIEvent.REMOVE);
		}
		
		
		override protected function onRemove():void
		{
		}
	}

}