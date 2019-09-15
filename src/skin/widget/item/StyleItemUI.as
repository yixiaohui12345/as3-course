/**Created by the Morn,do not modify.*/
package skin.widget.item {
	import morn.core.components.*;
	public class StyleItemUI extends View {
		public var icon:Image = null;
		public var label_icon:Label = null;
		protected static var uiView:XML =
			<View width="160" height="20">
			  <Image skin="png.style.bg.white" x="0" y="0" left="0" right="0" top="0" bottom="0"/>
			  <Image width="20" height="20" var="icon" left="5"/>
			  <Label text="加粗" x="70" y="1" size="12" centerY="0" right="40" var="label_icon"/>
			  <Image skin="png.style.icon.hline" bottom="0" left="0" right="0"/>
			</View>;
		public function StyleItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}