package frameworks.control.setup
{
	import frameworks.model.DeleteProxy;
	import frameworks.model.DownloadProxy;
	import frameworks.model.QueryProxy;
	import frameworks.model.UploadProxy;
	import frameworks.model.LoginProxy;
	import frameworks.model.MovieProxy;
	import frameworks.model.PageProxy;
	import frameworks.model.PictureBookLibProxy;
	import frameworks.model.PictureMaterialProxy;
	import frameworks.model.UserInfoProxy;
	import mvcexpress.mvc.Command
	
	/**
	 * Initial set up of maping proxies to proxy class and name for injection.
	 * proxyMap.mapClass(proxyClass:Class, injectClass:Class = null, name:String = "");
	 * proxyMap.mapObject(proxyObject:Proxy, injectClass:Class = null, name:String = "");
	 * @author
	 */
	public class SetupModelCommand extends Command
	{
		
		public function execute(blank:Object):void
		{
			proxyMap.map(new PageProxy(),null,null,PageProxy);
			proxyMap.map(new PictureBookLibProxy(),null,null,PictureBookLibProxy);
			proxyMap.map(new PictureMaterialProxy(), null, null, PictureMaterialProxy);
			proxyMap.map(new MovieProxy(), null, null, MovieProxy);
			proxyMap.map(new UploadProxy(), null, null, UploadProxy);
			proxyMap.map(new LoginProxy(), null, null, LoginProxy);
			proxyMap.map(new UserInfoProxy(), null, null, UserInfoProxy);
			proxyMap.map(new DeleteProxy(), null, null, DeleteProxy);
			proxyMap.map(new QueryProxy(), null, null, QueryProxy);
			proxyMap.map(new DownloadProxy(), null, null, DownloadProxy);
		}
	}
}