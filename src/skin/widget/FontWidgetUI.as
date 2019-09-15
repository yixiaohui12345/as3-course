/**Created by the Morn,do not modify.*/
package skin.widget {
	import morn.core.components.*;
	public class FontWidgetUI extends View {
		public var fontFamily:ComboBox = null;
		public var fontColor:ColorPicker = null;
		public var btn_close:Button = null;
		protected static var uiView:XML =
			<View width="430" height="35">
			  <Image skin="png.style.bg.green" left="0" right="0" top="0" bottom="0" x="-86" y="24"/>
			  <ComboBox labels="label1,label2" skin="png.style.combobox.combobox" x="8" y="8" sizeGrid="3,3,35,3" width="100" var="fontFamily" centerY="0" height="27"/>
			  <ColorPicker x="211" y="6.5" skin="png.style.button.color" selectedColor="0" centerY="0" var="fontColor"/>
			  <Button skin="png.style.button.delete_icon" x="410" y="10" right="5" var="btn_close" stateNum="1"/>
			</View>;
		public function FontWidgetUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}