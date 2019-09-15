/**Created by the Morn,do not modify.*/
package skin.dialog {
	import morn.core.components.*;
	public class FilterPanelUI extends View {
		protected static var uiView:XML =
			<View width="600" height="400">
			  <Image skin="png.style.bg.white" x="221" y="189" left="0" right="0" top="0" bottom="0"/>
			  <Label text="发布日期" x="15" y="116" mouseChildren="false" mouseEnabled="false" selectable="false" color="0x666666"/>
			  <Label text="发布对象" x="15" y="74" mouseChildren="false" mouseEnabled="false" selectable="false" color="0x666666"/>
			</View>;
		public function FilterPanelUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}