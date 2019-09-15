package frameworks.model 
{
	/**
	 * ...
	 * @author yxh
	 */
	public class DeleteProxy extends BaseProxy
	{
		
		public function DeleteProxy() 
		{
			
		}
		
		public function send(data:Object):void
		{
			var url:String = "http://" + NetConfig.MTL_IP + ":" + NetConfig.MTL_PORT + "/course/courseFileService_deleteCourseFile.action";
			//var url:String = "http://192.168.0.19:8083/course/courseFileService_deleteCourseFile.action";
			sendRequest(url, ActionData.deleteCourseFile(data.userId, data.idS));
		}
		
		override public function onSuccess(args:Array):void
		{
			
		}
	}

}