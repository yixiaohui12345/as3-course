/**Created by the Morn,do not modify.*/
package skin.panel {
	import morn.core.components.*;
	public class SettingPanelUI extends View {
		protected static var uiView:XML =
			<View width="310" height="560">
			  <Image skin="png.style.bg.gray" x="79" y="246" left="0" right="0" top="0" bottom="0"/>
			</View>;
		public function SettingPanelUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}