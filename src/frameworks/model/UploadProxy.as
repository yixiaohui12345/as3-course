package frameworks.model 
{
	import frameworks.model.vo.PageVO;
	import frameworks.model.vo.UserVO;
	import frameworks.view.widget.Alert;
	import frameworks.view.widget.Loading;
	import org.utils.AESUtils;
	/**
	 * ...
	 * @author yxh
	 */
	public class UploadProxy extends BaseProxy
	{
		
		public function UploadProxy() 
		{
			
		}
		
		/**
		 * 
		 * @param	data
		 */
		public function send(data:Object):void
		{
			if (data==null||data.vector == null || data.vector.length < 1)
			{
				Alert.inst.show("少于1页不能上传");
				return;
			}
			Loading.inst.start("上传中,请稍候");
			var count:int = data.vector.length;
			var xml:XML=<root pageAll={count}></root>
			for (var i:int = 0; i < count; i++)
			{
				var node:XML =<Page></Page>
				node.appendChild(data.vector[i].page.exml);
				xml.appendChild(node);
			}
			var content:String = AESUtils.encode(xml.toXMLString());
			var url:String = "http://" + NetConfig.MTL_IP + ":" + NetConfig.MTL_PORT + "/course/courseFileService_saveCourseFile.action";
			//var url:String = "http://192.168.0.19:8083/course/courseFileService_saveCourseFile.action";
			sendRequest(url, ActionData.uploadCourseFile(UserVO.inst.userId, data.title, data.description, data.tag, count, data.limitA, content, UserVO.inst.userName));
		}
		
		override public function onFailed(args:Array):void
		{
			Loading.inst.stop();
			Alert.inst.show("上传课件失败");
		}
		
		override public function onSuccess(args:Array):void
		{
			Loading.inst.stop();
			if (jsonContent && jsonContent.code == "1")
			{
				Alert.inst.show("上传成功");
			}
			else
			{
				Alert.inst.show("上传课件失败");
			}
		}
		
	}

}