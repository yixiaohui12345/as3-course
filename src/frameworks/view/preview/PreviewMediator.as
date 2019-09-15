package frameworks.view.preview
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import frameworks.message.DataMsg;
	import frameworks.message.OperateType;
	import frameworks.message.ViewMsg;
	import frameworks.model.vo.PreviewVO;
	import morn.core.components.law.EPage;
	import mvcexpress.mvc.Mediator;
	
	/**
	 * ...
	 * @author yxh
	 */
	public class PreviewMediator extends Mediator
	{
		[Inject]
		public var view:Preview
		
		public function PreviewMediator()
		{
		
		}
		
		override protected function onRegister():void
		{
			view.resize();
			App.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown,false,0,true);
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			switch(e.keyCode)
			{
				case Keyboard.LEFT:
					view.playPre();
					break;
				case Keyboard.RIGHT:
					view.playNext();
					break;
				case Keyboard.ESCAPE:
					close();
					break;
			}
		}
		
		private function close():void 
		{
			if (mediatorMap)
			{
				mediatorMap.unmediate(view);
			}
			view.remove();
		}
		
		private function handlePreview(vector:Vector.<EPage>):void 
		{
			view.update(vector);
		}
		
		override protected function onRemove():void
		{
			view.dispose();
			App.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
	
	}

}