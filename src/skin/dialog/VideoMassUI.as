/**Created by the Morn,do not modify.*/
package skin.dialog {
	import morn.core.components.*;
	public class VideoMassUI extends View {
		protected static var uiView:XML =
			<View width="300" height="540">
			  <Image skin="png.style.bg.gray" right="0" left="0" top="0" bottom="0"/>
			  <Label text="暂无内容" x="123" y="174" color="0xffffff"/>
			</View>;
		public function VideoMassUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}