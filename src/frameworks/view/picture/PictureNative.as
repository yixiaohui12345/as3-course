package frameworks.view.picture 
{
	import flash.events.MouseEvent;
	import frameworks.events.CompEvent;
	import frameworks.view.widget.Alert;
	import skin.dialog.PictureNativeUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class PictureNative extends PictureNativeUI
	{
		
		public function PictureNative() 
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
			if (label_image.text.length == 0){
				Alert.inst.show("请填入图片路径");
				return
			}
			dispatchEvent(new CompEvent(CompEvent.LOAD_LOCAL_PIC, label_image.text));
		}
		
	}

}