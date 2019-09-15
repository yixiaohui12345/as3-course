package frameworks.model 
{
	import frameworks.message.DataMsg;
	import frameworks.model.vo.UserVO;
	import frameworks.view.widget.Loading;
	/**
	 * ...
	 * @author yxh
	 */
	public class QueryProxy extends BaseProxy
	{
		
		public function QueryProxy() 
		{
			
		}
		
		public function send(data:Object):void
		{
			var url:String =  "http://" + NetConfig.MTL_IP + ":" + NetConfig.MTL_PORT + "/course/courseFileService_selectCourseFile.action?";
			//var url:String="http://192.168.0.19:8083/course/courseFileService_selectCourseFile.action?"
			sendRequest(url, ActionData.selectCourseFile(UserVO.inst.userId.toString(), data.tag, data.limitA, data.title, data.pageCount, data.count));
			Loading.inst.start();
		}
		
		override public function onFailed(args:Array):void
		{
			Loading.inst.stop();
			sendMessage(DataMsg.UPDATE_COURSE,null)
		}
		
		override public function onSuccess(args:Array):void
		{
			Loading.inst.stop();
			if (jsonContent && jsonContent.code == "1")
			{
				sendMessage(DataMsg.UPDATE_COURSE,jsonContent.result)
			}
		}
	}

}