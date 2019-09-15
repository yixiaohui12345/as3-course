package frameworks.model 
{
	import frameworks.message.DataMsg;
	import frameworks.model.vo.MovieVO;
	import frameworks.model.vo.UserVO;
	/**
	 * ...
	 * @author yxh
	 */
	public class MovieProxy extends BaseProxy
	{
		
		public function MovieProxy() 
		{
			
		}
		
		public function send(pid:int):void
		{
			var url:String = "http://" + NetConfig.LAW_IP + ":" + NetConfig.LAW_PORT  + "/legal/BookType";
			sendRequest(url, ActionData.getBookList(pid, UserVO.inst.userId, UserVO.inst.roleId));
		}
		
		override public function onSuccess(args:Array):void
		{
			if (jsonContent && jsonContent["ResultContent"] && jsonContent["ResultContent"]["book"])
			{
				var vo:MovieVO = new MovieVO();
				vo.bookList = jsonContent["ResultContent"]["book"];
				sendMessage(DataMsg.RESPONSE_MOVIE, vo);
			}
		}
	}

}