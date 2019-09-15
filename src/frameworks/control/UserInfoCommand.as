package frameworks.control 
{
	import frameworks.model.UserInfoProxy;
	import mvcexpress.mvc.Command;
	/**
	 * ...
	 * @author yxh
	 */
	public class UserInfoCommand extends Command
	{
		[Inject]
		public var proxy:UserInfoProxy;
		
		public function UserInfoCommand() 
		{
			
		}
		
		public function execute(data:Object):void
		{
			proxy.send();
		}
	}

}