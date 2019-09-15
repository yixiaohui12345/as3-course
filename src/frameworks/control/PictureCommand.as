package frameworks.control 
{
	import frameworks.model.PictureBookLibProxy;
	import frameworks.model.PictureMaterialProxy;
	import mvcexpress.mvc.Command;
	import mvcexpress.mvc.Proxy;
	/**
	 * ...
	 * @author yxh
	 */
	public class PictureCommand extends Command
	{
		[Inject]
		public var proxy:PictureBookLibProxy;
		
		public function PictureCommand() 
		{
			
		}
		
		public function execute(data:Object):void 
		{
			var proxy:* = null;
			switch(data.requestType)
			{
				case "PictureBookLibProxy":
					proxy=proxyMap.getProxy(PictureBookLibProxy) as PictureBookLibProxy
					proxy.send(data.btypeid, data.booktype, data.pagenow);
					break; 	
				case "PictureMaterialProxy":
					proxy=proxyMap.getProxy(PictureMaterialProxy) as PictureMaterialProxy
					proxy.send(data.btypeid, data.booklib, data.pixel, data.picType);
					break; 	
			}
		}
		
	}

}