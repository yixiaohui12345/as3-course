/**Created by the Morn,do not modify.*/
package skin.panel {
	import morn.core.components.*;
	public class StylePanelUI extends View {
		public var radioGroup:RadioGroup = null;
		public var label_link:TextInput = null;
		public var combobox_link:ComboBox = null;
		public var btn_up:Button = null;
		public var btn_down:Button = null;
		public var btn_copy:Button = null;
		public var btn_uppest:Button = null;
		public var btn_downest:Button = null;
		public var btn_restore:Button = null;
		public var btn_rotate_right:Button = null;
		public var btn_rotate_left:Button = null;
		public var btn_rotate_x:Button = null;
		public var btn_rotate_y:Button = null;
		protected static var uiView:XML =
			<View width="300" height="480">
			  <Image skin="png.style.bg.gray" left="0" right="0" top="0" bottom="0"/>
			  <Label text="超链接" x="15" y="340" color="0xffffff"/>
			  <RadioGroup labels="无,跳转链接,跳转页面" skin="png.comp.radiogroup" x="284" y="340" direction="vertical" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" labelSize="15" space="4" right="20" selectedIndex="0" var="radioGroup"/>
			  <TextInput skin="png.comp.textinput" x="15" y="410" width="260" height="50" var="label_link" multiline="false" wordWrap="false"/>
			  <ComboBox labels="label1,label2" skin="png.style.combobox.combobox" x="15" y="410" sizeGrid="8,8,40,8" width="150" right="20" var="combobox_link"/>
			  <Label text="旋转" color="0xffffff" mouseChildren="false" mouseEnabled="false" x="50" y="40" size="14"/>
			  <Button skin="png.style.button.normal" x="26" y="289" label="上移一层" sizeGrid="4,4,4,4" width="118" var="btn_up" labelColors="0xffffff,0xffffff,0xffffff,0xffffff"/>
			  <Button skin="png.style.button.normal" x="164" y="289" label="下移一层" sizeGrid="4,4,4,4" width="118" var="btn_down" labelColors="0xffffff,0xffffff,0xffffff,0xffffff"/>
			  <Button label="复制" skin="png.style.button.normal" x="26" y="246" sizeGrid="4,4,4,4" width="50" var="btn_copy" labelColors="0xffffff,0xffffff,0xffffff,0xffffff"/>
			  <Button label="置顶" skin="png.style.button.normal" x="162" y="246" sizeGrid="4,4,4,4" width="50" var="btn_uppest" labelColors="0xffffff,0xffffff,0xffffff,0xffffff"/>
			  <Button label="置底" skin="png.style.button.normal" y="246" sizeGrid="4,4,4,4" width="50" var="btn_downest" x="230" labelColors="0xffffff,0xffffff,0xffffff,0xffffff"/>
			  <Button label="原图" skin="png.style.button.normal" x="94" y="246" sizeGrid="4,4,4,4" width="50" var="btn_restore" labelColors="0xffffff,0xffffff,0xffffff,0xffffff"/>
			  <Label text="缩放" color="0xffffff" mouseChildren="false" mouseEnabled="false" x="50" y="80" size="14"/>
			  <Label text="不透明度" color="0xffffff" mouseChildren="false" mouseEnabled="false" x="21" y="120" size="14"/>
			  <HBox x="60" y="171" space="50" align="middle" centerX="0">
			    <Button skin="png.style.button.rotate_right" x="64" var="btn_rotate_right"/>
			    <Button skin="png.style.button.rotate_left" var="btn_rotate_left"/>
			    <Button skin="png.style.button.rotate_x" x="128" y="4" var="btn_rotate_x"/>
			    <Button skin="png.style.button.rotate_y" x="192" y="3" var="btn_rotate_y"/>
			  </HBox>
			  <Label text="样式" x="15" y="10" color="0xffffff" size="15" font="微软雅黑"/>
			  <Label text="工具" x="15" y="220" color="0xffffff" size="15" font="微软雅黑"/>
			</View>;
		public function StylePanelUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}