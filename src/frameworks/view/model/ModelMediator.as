package frameworks.view.model 
{
	import mvcexpress.mvc.Mediator;
	/**
	 * ...
	 * @author yxh
	 */
	public class ModelMediator extends Mediator
	{
		[Inject]
		public var view:ModelPanel
		
		public function ModelMediator() 
		{
			
		}
		
		override protected function onRegister():void
		{
			view.resize();
		}
		
		override protected function onRemove():void
		{
			
		}
		
	}

}