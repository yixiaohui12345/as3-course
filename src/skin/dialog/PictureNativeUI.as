/**Created by the Morn,do not modify.*/
package skin.dialog {
	import morn.core.components.*;
	public class PictureNativeUI extends View {
		public var label_image:TextInput = null;
		public var btn_insert:Button = null;
		public var btn_upload:Button = null;
		protected static var uiView:XML =
			<View width="300" height="540">
			  <Image skin="png.style.bg.gray" right="0" left="0" top="0" bottom="0" sizeGrid="4,4,4,4" x="10" y="10"/>
			  <HBox x="10" y="27" space="5" align="middle">
			    <Label text="网络路径" y="4" color="0xffffff" size="14"/>
			    <TextInput skin="png.comp.textinput" x="53" height="28" width="200" align="left" color="0x333333" multiline="false" wordWrap="false" var="label_image"/>
			  </HBox>
			  <Button label="插入" skin="png.style.button.normal" x="10" sizeGrid="15,15,15,15" width="80" height="30" var="btn_insert" y="70" labelColors="0xffffff,0xffffff,0xffffff,0xffffff"/>
			  <Button label="本地上传(vip)" skin="png.style.button.normal" sizeGrid="15,15,15,15" width="100" height="30" var="btn_upload" x="105" y="467" bottom="20" labelColors="0xffffff,"/>
			</View>;
		public function PictureNativeUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}