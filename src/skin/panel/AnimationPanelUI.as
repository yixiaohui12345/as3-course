/**Created by the Morn,do not modify.*/
package skin.panel {
	import morn.core.components.*;
	public class AnimationPanelUI extends View {
		public var effectBox:ComboBox = null;
		public var btn_add:Button = null;
		public var btn_remove:Button = null;
		protected static var uiView:XML =
			<View width="300" height="200">
			  <Image skin="png.style.bg.gray" left="0" right="0" top="0" bottom="0" sizeGrid="4,4,4,4"/>
			  <Label text="效果" x="10" y="15" size="15" color="0xffffff"/>
			  <ComboBox skin="png.style.combobox.combobox" x="50" y="12" sizeGrid="3,3,35,3" width="150" var="effectBox"/>
			  <Label text="持续" x="10" y="67" size="15" color="0xffffff"/>
			  <Label text="延迟" x="160" y="67" size="15" color="0xffffff"/>
			  <HBox x="54" y="159" align="middle" space="50" centerX="0">
			    <Button label="添加效果" skin="png.style.button.normal" var="btn_add" labelColors="0xffffff,0xffffff,0xffffff,0xffffff"/>
			    <Button label="清除效果" skin="png.style.button.normal" x="115" var="btn_remove" labelColors="0xffffff,0xffffff,0xffffff,0xffffff"/>
			  </HBox>
			</View>;
		public function AnimationPanelUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}