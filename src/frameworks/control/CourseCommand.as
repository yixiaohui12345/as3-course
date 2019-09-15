package frameworks.control 
{
	import frameworks.message.OperateType;
	import frameworks.model.DeleteProxy;
	import frameworks.model.DownloadProxy;
	import frameworks.model.QueryProxy;
	import frameworks.model.UploadProxy;
	import mvcexpress.mvc.Command;
	/**
	 * ...
	 * @author yxh
	 */
	public class CourseCommand extends Command
	{
		[Inject]
		public var proxy:UploadProxy
		
		[Inject]
		public var proxyDelete:DeleteProxy
		
		[Inject]
		public var proxyQuery:QueryProxy
		
		[Inject]
		public var proxyDownload:DownloadProxy
		
		public function CourseCommand() 
		{
			
		}
		
		public function execute(data:Object):void 
		{
			switch(data.type)
			{
				case OperateType.UPLOAD_COURSE:
					proxy.send(data);
					break;
				case OperateType.QUERY_COURSE:
					proxyQuery.send(data)
					break;
				case OperateType.DOWNLOAD_COURSE:
					proxyDownload.send(data);
					break;
				case OperateType.DELETE_COURSE:
					proxyDelete.send(data);
					break;
			}
		}
	}

}