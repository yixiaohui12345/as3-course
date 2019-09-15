/**Created by the Morn,do not modify.*/
package skin.panel {
	import morn.core.components.*;
	public class ModelPanelUI extends View {
		protected static var uiView:XML =
			<View width="300" height="540">
			  <Image skin="png.style.bg.gray" x="89" y="256" left="0" right="0" top="0" bottom="0"/>
			</View>;
		public function ModelPanelUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}