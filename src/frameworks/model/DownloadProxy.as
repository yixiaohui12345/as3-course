package frameworks.model 
{
	import frameworks.message.DataMsg;
	import frameworks.view.widget.Alert;
	import frameworks.view.widget.Loading;
	import morn.core.components.law.EComponent;
	import morn.core.components.law.EImage;
	import morn.core.components.law.EMovie;
	import morn.core.components.law.EMusic;
	import morn.core.components.law.EPage;
	import morn.core.components.law.EText;
	import org.utils.AESUtils;
	/**
	 * ...
	 * @author yxh
	 */
	public class DownloadProxy extends BaseProxy
	{
		
		public function DownloadProxy() 
		{
			
		}
		
		public function send(data:Object):void
		{
			var url:String ="http://"+NetConfig.MTL_IP+":"+NetConfig.MTL_PORT+"/course/courseFileService_selectCourseFile.action?";
			//var url:String = "http://192.168.0.19:8083/course/courseFileService_selectCourseFile.action?";
			sendRequest(url, ActionData.downloadCourseFile(data.id));
			Loading.inst.start();
		}
		
		override public function onFailed(args:Array):void
		{
			Loading.inst.stop();
			Alert.inst.show("网络君好像出了点问题，请稍后再试");
		}
		
		override public function onSuccess(args:Array):void
		{
			if (jsonContent && jsonContent.result && jsonContent.result.list)
			{
				var content:String = AESUtils.decode(jsonContent.result.list[0].fileContent);
				var xml:XML = new XML(content);
				var temp:Vector.<EPage> = new Vector.<EPage>();
			
				for (var i:int = 0, len:int = xml.Page.View.EPage.length(); i < len; i++)
				{
					var page:EPage = new EPage();
					page.width = PageConfig.PAGE_WIDTH;
					page.height = PageConfig.PAGE_HEIGHT;
					trace(xml.Page.View.children()[i].toXMLString());
					page.scene = xml.Page.View.children()[i].@scene.toXMLString()
					page.isEditable = false;
					temp.push(page);
					for (var j:int = 0, childLen:int = xml.Page.View.children()[i].children().length(); j < childLen; j++)
					{
						var clsName:String = xml.Page.View.children()[i].children()[j].name();
						var childNode:XML = xml.Page.View.children()[i].children()[j];
						var comp:EComponent = null;
						switch (clsName)
						{
						case "EText": 
							comp = new EText();
							break;
						case "EImage": 
							comp = new EImage();
							break;
						case "EMovie": 
							comp = new EMovie();
							break;
						case "EMusic":
							comp = new EMusic();
							break;
						}
						var list2:XMLList = childNode.attributes();
						for each (var attrs:XML in list2)
						{
							var prop:String = attrs.name().toString();
							var value:String = attrs.toString();
							if (comp.hasOwnProperty(prop))
							{
								if (prop == "animation" && value != null)
								{
									page.aniList.push(comp);
								}
								comp[prop] = (value == "true" ? true : (value == "false" ? false : value))
							}
						}
						page.addElement(comp, comp["x"], comp["y"]);
					}
				}
				sendMessage(DataMsg.RESPONSE_PREVIEW, temp)
			}
			Loading.inst.stop();
		}
	}

}