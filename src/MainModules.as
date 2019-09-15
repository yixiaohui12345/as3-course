package 
{
	import frameworks.control.setup.*
	import mvcexpress.modules.ModuleCore;
	/**
	 * ...
	 * @author yxh
	 */
	public class MainModules extends ModuleCore
	{
		
		public function MainModules() 
		{
			
		}
		
		override protected function onInit():void 
		{
			// map commands (you can map them here.. or move it to command.)
			commandMap.execute(SetupControlerCommand);
		
			// map proxies (and services)(you can map them here.. or move it to command.)
			commandMap.execute(SetupModelCommand);
			
			// map mediators(you can map them here.. or move it to command.)
			commandMap.execute(SetupViewCommand);
		}
		
		public function start(main:Main):void
		{
			mediatorMap.mediate(main);
		}
	}

}