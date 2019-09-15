package frameworks.view.movie 
{
	import flash.events.MouseEvent;
	import frameworks.view.widget.Alert;
	import skin.dialog.VideoNativeUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class VideoNative extends VideoNativeUI
	{
		
		public function VideoNative() 
		{
			btn_insert.addEventListener(MouseEvent.CLICK, handleInsert);
			btn_upload.addEventListener(MouseEvent.CLICK, handleUpload);
		}
		
		private function handleUpload(e:MouseEvent):void 
		{
			Alert.inst.show("该功能暂时不对外开放");
		}
		
		private function handleInsert(e:MouseEvent):void 
		{
			Alert.inst.show("该功能暂时不对外开放");
		}
		
	}

}