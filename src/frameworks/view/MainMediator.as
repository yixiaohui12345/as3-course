package frameworks.view 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.Keyboard;
	import frameworks.events.CompEvent;
	import frameworks.message.DataMsg;
	import frameworks.message.OperateType;
	import frameworks.message.ViewMsg;
	import frameworks.model.vo.UserVO;
	import frameworks.view.design.Design;
	import frameworks.view.design.DesignMediator;
	import frameworks.view.picture.PictureMaterial;
	import frameworks.view.widget.FontWidget;
	import frameworks.view.style.StylePanel;
	import morn.core.components.Panel;
	import mvcexpress.mvc.Mediator;
	import org.cache.LocalCache;
	import org.utils.DateUtils;
	import org.utils.StringUtils;
	/**
	 * ...
	 * @author yxh
	 */
	public class MainMediator extends Mediator
	{
		[Inject]
		public var view:Main;
		
		public var design:Design
		
		public function MainMediator() 
		{
			App.stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private function onResize(e:Event=null):void 
		{
			design.resize();
		}
		
		override protected function onRegister():void
		{
			design = new Design();
			mediatorMap.mediate(design);
			
			view.addChild(design);
			design.resize();
			design.topBar.label_name.text = UserVO.inst.userName;
			sendMessage(ViewMsg.OPERATE_PAGE, {type:OperateType.ADD_PAGE});
		}
		
		override protected function onRemove():void 
		{
			
		}
		
	}

}