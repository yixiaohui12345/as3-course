/**Created by the Morn,do not modify.*/
package skin.panel {
	import morn.core.components.*;
	public class MusicPanelUI extends View {
		public var btn_upload:Button = null;
		public var c_replay:CheckBox = null;
		public var label_url:TextInput = null;
		public var btn_insert:Button = null;
		protected static var uiView:XML =
			<View width="300" height="540">
			  <Image skin="png.style.bg.gray" x="35" y="220" left="0" right="0" top="0" bottom="0"/>
			  <Button label="本地上传" skin="png.style.button.normal" sizeGrid="15,15,15,15" width="100" height="30" var="btn_upload" x="115" y="477" bottom="20" centerX="0" labelColors="0xffffff,0xffffff,0xffffff,0xffffff"/>
			  <Label text="循环播放" x="10" y="115" color="0xffffff" size="15" mouseChildren="false" mouseEnabled="false"/>
			  <Label text="音量" x="10" y="201" color="0xffffff" size="15" mouseChildren="false" mouseEnabled="false"/>
			  <CheckBox skin="png.comp.checkbox" x="90" y="119" var="c_replay"/>
			  <Label text="延时秒数" x="10" y="158" color="0xffffff" size="15" mouseChildren="false" mouseEnabled="false"/>
			  <HBox x="10" y="10" space="5" align="middle">
			    <Label text="网络路径" y="4" color="0xffffff" size="14"/>
			    <TextInput skin="png.comp.textinput" x="53" height="28" width="200" align="left" color="0x333333" multiline="false" wordWrap="false" var="label_url"/>
			  </HBox>
			  <Button label="插入" skin="png.style.button.normal" x="10" sizeGrid="15,15,15,15" width="80" height="30" var="btn_insert" y="60" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" labelFont="宋体"/>
			</View>;
		public function MusicPanelUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}