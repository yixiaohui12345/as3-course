package frameworks.view.upload 
{
	import frameworks.common.Source;
	import skin.dialog.UploadDialogUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class UploadDialog extends UploadDialogUI
	{
		public function UploadDialog() 
		{
			var arr:Array = Source.SUBJECT.concat();
			arr.shift();
			combobox_tag.labels = arr.join();
			combobox_tag.selectedIndex = 0;
			arr = null;
		}
		
		public function update():void
		{
			label_description.hint = "请输入标题";
			label_title.hint = "请输入描述内容";
		}
		
		public function resize():void
		{
			this.x = (App.stage.stageWidth - width) * 0.5;
			this.y = (App.stage.stageHeight - height) * 0.5;
			graphics.clear();
			graphics.beginFill(0, 0.4);
			graphics.drawRect( -x, -y, App.stage.stageWidth, App.stage.stageHeight);
			graphics.endFill();
		}
	}

}