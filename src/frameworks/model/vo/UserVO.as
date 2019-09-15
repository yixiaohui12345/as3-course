package frameworks.model.vo 
{
	/**
	 * ...
	 * @author yxh
	 */
	public class UserVO 
	{
		public var isActivate:Boolean = false;
		public var changeInfo:int = 0;
		public var userId:int = 13281;
		public var selDepIds:Array = [];
		public var roleId:int = 0;
		
		public var deptTypeId:int=0;
		
		public var gender:int = 0;
		
		public var orgId:int = 0;
		
		public var province:String = "";
		
		public var city:String = "";
		
		public var district:String = "";
		
		public var provinceId:int = 0;
		
		public var cityId:int = 0;
		
		public var twonId:int = 0;
		
		public var districtId:int = 0;
		
		public var organization:String = "";
		
		public var department:String = "";
		
		public var userno:String = "visitor";
		
		public var password:String = "123456";
		
		public var integral:String = "";
		
		public var experience:String = "";
		
		public var photo:String  = "";
		
		public var signIn:int = 0;
		
		public var borth:String  = "";
		
		public var gold:int = 0;
		
		public var level:int = 0;
		
		public var status:String = "";
		
		public var title:String="";
		
		public var userNameChange:int  = 0;
		
		public var vipLevel:int = 0;
		
		public var phone:String   ="";
		
		public var mail:String = "";
		
		public var userName:String = null;
		
		public var deptId:String = "";
		
		public var address:String = "";
		
		public var triMsg:String = "";
		
		public var userType:int = 0;
		
		public var goods:Array = new Array();
		
		public var roleDetailedIdList:Array = [100];
		
		public var bookList:Array = [];
		
		public var continueSign:int = 1;
		
		public var notice:Object = null;
		
		public var goodsAddress:String ="";
		public var goodsRecipients:String ="";
		public var goodsPhone:String ="";
		public var goodsMail:String ="";
		public var groupsId:int = 0;
		public var groupName:String = "";
		public var isWaitComplete:Boolean = false;
		public var courtCaseObj:Object ;
		
		public var gameRoomObj:Object ;
		
		public var myToken:int = 0;
		
		public var token:int = 0;
		
		public var msgMap:Object  = null;
		
		public var ifUserRelation:int = 0;
		
		public var onlinelist:Object=null;
		
		public var userAgent:String;
		
		public var userInfos:String=null;
		
		public var userIp:String = "";
		
		private static const RANDOM:Number = Math.random();
		
		public function UserVO(value:Number) 
		{
			if (value != RANDOM)
			{
				throw new Error("此类不能实例化");
				return;
			}
		}
		
		private static var _inst:UserVO = null;
		public static function get inst():UserVO
		{
			if (_inst == null)
			{
				_inst = new UserVO(RANDOM);
			}
			return _inst;
		}
		
		public function clear():void
		{
			userId = -1
			orgId = -1
			signIn = -1
			roleId = -1
			province = null;
			provinceId = -1
			photo = null
			organization = null
			userType = -1
			department = null
			deptTypeId = -1
			city = null
			cityId = -1
			district = null
			districtId=-1
		}
	}

}