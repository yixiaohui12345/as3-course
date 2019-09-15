/**Created by the Morn,do not modify.*/
package skin.widget.item {
	import morn.core.components.*;
	public class FontFormatUI extends View {
		protected static var uiView:XML =
			<View width="170" height="110">
			  <Image skin="png.style.bg.dialog" sizeGrid="5,5,5,5" left="0" right="0" top="0" bottom="0"/>
			  <Label text="文字间距" x="5" y="15"/>
			  <Label text="首行缩进" x="5" y="75"/>
			  <Label text="段落间距" x="5" y="45"/>
			</View>;
		public function FontFormatUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}