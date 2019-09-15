package frameworks.model 
{
	import frameworks.message.DataMsg;
	import frameworks.model.vo.MaterialVO;
	/**
	 * ...
	 * @author yxh
	 */
	public class PictureMaterialProxy extends BaseProxy
	{
		
		public function PictureMaterialProxy() 
		{
		}
		
		public function send(btypeid:int, booklib:int, pixel:String="2072*1256", picType:String="J"):void
		{
			var url:String = "http://" + NetConfig.MTL_IP + ":" + NetConfig.MTL_PORT + "/nuoer/materialCentreService_selectMaterialPricture.action";
			sendRequest(url, ActionData.selectMaterialPricture(btypeid, booklib, pixel, picType));
		}
		
		override public function onSuccess(args:Array):void
		{
			if (jsonContent && jsonContent["code"] == "1")
			{
				var vo:MaterialVO = new MaterialVO();
				vo.list = jsonContent["result"]["list"];
				sendMessage(DataMsg.RESPONSE_BOOK_MATERIAL, vo);
			}
		}
	}

}