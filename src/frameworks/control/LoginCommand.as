package frameworks.control 
{
	import frameworks.model.LoginProxy;
	import mvcexpress.mvc.Command;
	/**
	 * ...
	 * @author yxh
	 */
	public class LoginCommand extends Command
	{
		[Inject]
		public var proxy:LoginProxy;
		
		public function LoginCommand() 
		{
			
		}
		
		public function execute(data:Object):void 
		{
			proxy.send(data.userno, data.password,data.isAuto);
		}
		
	}

}