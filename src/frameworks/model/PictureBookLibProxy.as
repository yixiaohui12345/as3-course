package frameworks.model 
{
	import frameworks.message.DataMsg;
	import frameworks.model.vo.PictureVO;
	/**
	 * ...
	 * @author yxh
	 */
	public class PictureBookLibProxy extends BaseProxy
	{
		
		public function PictureBookLibProxy() 
		{
			
		}
		
		/**
		 * 
		 * @param	btypeid
		 * @param	booktype
		 * @param	pagenow
		 */
		public function send(btypeid:String,booktype:String,pagenow:int):void
		{
			var url:String = "http://"+NetConfig.MTL_IP+":"+NetConfig.MTL_PORT+"/nuoer/materialCentreService_selectBookLib.action";
			sendRequest(url, ActionData.getBookTypeLib(btypeid,booktype,pagenow));
		}
		
		override public function onSuccess(args:Array):void
		{
			if (jsonContent &&jsonContent["result"]&& jsonContent["result"]["list"])
			{
				var vo:PictureVO = new PictureVO();
				vo.pageIndex = jsonContent["result"]["page"][0];
				vo.pageCount = jsonContent["result"]["count"][0];
				vo.list = jsonContent["result"]["list"];
				sendMessage(DataMsg.RESPONSE_BOOK_LIB, vo);
			}
		}
		
		override public function onFailed(args:Array):void
		{
			
		}
		
		override public function onTimeOut(args:Array):void
		{
			
		}
	}

}