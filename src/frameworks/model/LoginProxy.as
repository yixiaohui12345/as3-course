package frameworks.model 
{
	import frameworks.message.DataMsg;
	import frameworks.message.NetCode;
	import frameworks.model.vo.UserVO;
	import frameworks.view.widget.Alert;
	import frameworks.view.widget.Loading;
	import org.cache.LocalCache;
	import org.utils.DateUtils;
	/**
	 * ...
	 * @author yxh
	 */
	public class LoginProxy extends BaseProxy
	{
		private var isAuto:Boolean = false;
		
		public function LoginProxy() 
		{
			
		}
		
		public function send(userno:String,password:String,isAuto:Boolean):void
		{
			var url:String = "http://"+NetConfig.LAW_IP + ":" + NetConfig.LAW_PORT + "/legal/Login";
			sendRequest(url, ActionData.getLogin(userno, password),[userno,password,isAuto]);
			Loading.inst.start("登录中,请稍候");
		}
		
		override public function onFailed(args:Array):void
		{
			Loading.inst.stop();
			sendMessage(DataMsg.RESPONSE_LOGIN, {resultCode: NetCode.SERVER_EXCEPTION});
		}
		
		override public function onSuccess(args:Array):void
		{
			Loading.inst.stop();
			if (jsonContent)
			{
				if (jsonContent.ResultStatus.ResultCode == "0")
				{
					if (args&&args[2]==true){
						LocalCache.inst.saveData(LocalCache.LOGIN_CACHE, {userno:args[0], password:args[1], isAuto:args[2],time:DateUtils.getTime()});
					}
					var obj:Object = jsonContent["ResultContent"];
					UserVO.inst.userId = obj.userId;
					UserVO.inst.orgId = obj.orgId;
					UserVO.inst.signIn = obj.signIn;
					UserVO.inst.roleId = obj.roleId;
					UserVO.inst.province = obj.province;
					UserVO.inst.provinceId = obj.provinceId;
					UserVO.inst.photo = obj.photo;
					UserVO.inst.organization = obj.organization;
					UserVO.inst.userType = obj.userType;
					UserVO.inst.department = obj.department
					UserVO.inst.deptTypeId = obj.deptTypeId;
					UserVO.inst.city = obj.city;
					UserVO.inst.cityId = obj.cityId;
					UserVO.inst.district = obj.district;
					UserVO.inst.districtId = obj.districtId
					sendMessage(DataMsg.RESPONSE_LOGIN, {resultCode:jsonContent.ResultStatus.ResultCode});
				}
				else
				{
					Alert.inst.show(jsonContent.ResultStatus.ResultDescription);
				}
			}
			else
			{
				Alert.inst.show("网络原因，无法登录");
				sendMessage(DataMsg.RESPONSE_LOGIN, {resultCode: NetCode.JSON_ERROR});
			}
		}
	}

}