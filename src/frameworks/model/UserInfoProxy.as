package frameworks.model 
{
	import frameworks.message.DataMsg;
	import frameworks.model.vo.UserVO;
	/**
	 * ...
	 * @author yxh
	 */
	public class UserInfoProxy extends BaseProxy
	{
		
		public function UserInfoProxy() 
		{
			
		}
		
		public function send():void
		{
			var url:String = "http://" + NetConfig.LAW_IP + ":" + NetConfig.LAW_PORT + "/legal/UserInfo";
			sendRequest(url, ActionData.getUserInfo(UserVO.inst.userId));
		}
		
		override public function onSuccess(args:Array):void
		{
			if (jsonContent&&jsonContent["ResultStatus"]["ResultCode"]=="0")
			{
				UserVO.inst.userName = jsonContent["ResultContent"]["userName"];
				sendMessage(DataMsg.RESPONSE_USERINFO,{resultCode:jsonContent["ResultStatus"]["ResultCode"]});
			}
			else
			{
				sendMessage(DataMsg.RESPONSE_USERINFO,{resultCode:jsonContent["ResultStatus"]["ResultCode"]});
			}
		}
	}

}