/**Created by the Morn,do not modify.*/
package skin.widget.blocks {
	import morn.core.components.*;
	public class ColorPickerPanelUI extends View {
		public var label_sediao:TextInput = null;
		public var label_baohedu:TextInput = null;
		public var label_liangdu:TextInput = null;
		public var label_r:TextInput = null;
		public var label_b:TextInput = null;
		public var label_g:TextInput = null;
		public var btn_modify:Button = null;
		protected static var uiView:XML =
			<View width="290" height="380">
			  <HBox x="28" y="238" align="middle" space="20">
			    <Label text="色调" y="1" multiline="false" wordWrap="false" mouseEnabled="false" mouseChildren="false" selectable="false" color="0xffffff"/>
			    <TextInput text="0" skin="png.comp.textinput" x="53" width="50" align="center" restrict="0-9" var="label_sediao"/>
			  </HBox>
			  <HBox x="28" y="274" space="9" align="middle">
			    <Label text="饱和度" multiline="false" wordWrap="false" mouseEnabled="false" mouseChildren="false" selectable="false" color="0xffffff"/>
			    <TextInput text="0" skin="png.comp.textinput" x="53" y="2" width="50" align="center" restrict="0-9" var="label_baohedu"/>
			  </HBox>
			  <HBox x="29" y="310" align="middle" space="20">
			    <TextInput text="0" skin="png.comp.textinput" width="50" align="center" restrict="0-9" var="label_liangdu" x="142"/>
			    <Label text="亮度" multiline="false" wordWrap="false" mouseEnabled="false" mouseChildren="false" selectable="false" color="0xffffff" y="11"/>
			  </HBox>
			  <HBox x="168" y="238" align="middle" space="20">
			    <Label text="红" y="1" multiline="false" wordWrap="false" mouseEnabled="false" mouseChildren="false" selectable="false" color="0xffffff"/>
			    <TextInput text="0" skin="png.comp.textinput" x="53" width="50" align="center" restrict="0-9" var="label_r"/>
			  </HBox>
			  <HBox x="168" y="310" space="20" align="middle">
			    <Label text="蓝" multiline="false" wordWrap="false" mouseEnabled="false" mouseChildren="false" selectable="false" color="0xffffff"/>
			    <TextInput text="0" skin="png.comp.textinput" width="50" align="center" restrict="0-9" var="label_b"/>
			  </HBox>
			  <HBox x="168" y="274" align="middle" space="20">
			    <Label multiline="false" wordWrap="false" mouseEnabled="false" mouseChildren="false" width="16" height="23.324099722991686" selectable="false" text="绿" x="0" y="0" color="0xffffff"/>
			    <TextInput text="0" skin="png.comp.textinput" width="50" align="center" restrict="0-9" var="label_g"/>
			  </HBox>
			  <Button label="确定修改" skin="png.style.button.normal" x="106" y="290" sizeGrid="4,4,4,4" height="25" centerX="0" bottom="10" var="btn_modify" labelColors="0xffffff,0xffffff,0xffffff,0xffffff"/>
			</View>;
		public function ColorPickerPanelUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}