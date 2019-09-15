/**Created by the Morn,do not modify.*/
package skin.dialog {
	import morn.core.components.*;
	public class UploadDialogUI extends View {
		public var label_title:TextInput = null;
		public var label_description:TextInput = null;
		public var combobox_tag:ComboBox = null;
		public var radio_author:RadioGroup = null;
		public var btn_sure:Button = null;
		public var btn_cancel:Button = null;
		protected static var uiView:XML =
			<View width="520" height="350">
			  <Image skin="png.style.bg.gray" x="0" y="0" left="0" right="0" top="0" bottom="0" alpha="0.8"/>
			  <Image skin="png.style.bg.zise" x="-29" left="0" right="0" top="0" bottom="0" y="-109"/>
			  <TextInput skin="png.comp.textinput" x="45" y="18" sizeGrid="5,5,5,5" height="28" var="label_title" margin="0,2,0,2" width="420" color="0x0"/>
			  <Label text="标题" x="10" y="20" multiline="false" wordWrap="false" mouseChildren="false" mouseEnabled="false" color="0xcccccc"/>
			  <Label text="描述" x="10" y="61" mouseChildren="false" mouseEnabled="false" color="0xcccccc"/>
			  <TextInput skin="png.comp.textinput" x="45" y="65" width="420" height="100" var="label_description" sizeGrid="5,5,5,5" color="0x0"/>
			  <Label text="分类" x="10" y="182" mouseEnabled="false" mouseChildren="false" color="0xcccccc"/>
			  <ComboBox skin="png.style.combobox.combobox" x="45" y="179" sizeGrid="4,4,35,4" width="150" var="combobox_tag" labelColors="0,0,0,0"/>
			  <Label text="权限" x="10" y="232" mouseChildren="false" mouseEnabled="false" color="0xcccccc"/>
			  <RadioGroup labels="所有人可见,仅自己可见" skin="png.comp.radiogroup" x="45" y="234" direction="horizontal" selectedIndex="0" space="10" var="radio_author" labelColors="0xffffff,0xffffff,0xffffff,0xffffff"/>
			  <HBox x="153" y="302" align="middle" space="80" centerX="0" bottom="10">
			    <Button label="确定上传" skin="png.style.button.normal" var="btn_sure" labelColors="0xffffff,0xffffff,0xffffff,0xffffff"/>
			    <Button label="取消" skin="png.style.button.normal" x="123" var="btn_cancel" labelColors="0xffffff,0xffffff,0xffffff,0xffffff"/>
			  </HBox>
			  <Label text="必填" x="470" y="20" multiline="false" wordWrap="false" mouseChildren="false" mouseEnabled="false" color="0xff3300"/>
			  <Label text="必填" x="470" y="62" multiline="false" wordWrap="false" mouseChildren="false" mouseEnabled="false" color="0xff3300"/>
			  <Label text="必填" x="200" y="182" multiline="false" wordWrap="false" mouseChildren="false" mouseEnabled="false" color="0xff3300"/>
			</View>;
		public function UploadDialogUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}