/**Created by the Morn,do not modify.*/
package skin.dialog {
	import morn.core.components.*;
	public class PictureMassUI extends View {
		protected static var uiView:XML =
			<View width="300" height="540">
			  <Image skin="png.style.bg.gray" right="0" left="0" top="0" bottom="0" sizeGrid="4,4,4,4" x="20" y="20"/>
			  <Label text="暂无内容" x="125" y="164" color="0xffffff"/>
			</View>;
		public function PictureMassUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}