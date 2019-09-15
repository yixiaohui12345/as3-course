package frameworks.control 
{
	import frameworks.model.MovieProxy;
	import mvcexpress.mvc.Command;
	/**
	 * ...
	 * @author yxh
	 */
	public class MovieCommand extends Command
	{
		
		public function MovieCommand() 
		{
			
		}
		
		public function execute(data:Object):void 
		{
			var proxy:* = null;
			switch(data.requestType)
			{
				case "MovieProxy":
					proxy=proxyMap.getProxy(MovieProxy) as MovieProxy
					proxy.send(data.pid);
					break; 	
			}
		}
		
	}

}