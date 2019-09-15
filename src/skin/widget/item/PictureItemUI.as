/**Created by the Morn,do not modify.*/
package skin.widget.item {
	import morn.core.components.*;
	public class PictureItemUI extends View {
		public var icon:Image = null;
		public var label:Label = null;
		protected static var uiView:XML =
			<View width="90" height="70">
			  <Image x="0" y="0" width="90" height="50" var="icon"/>
			  <Label text="label" left="0" wordWrap="false" multiline="false" align="center" right="0" top="50" size="12" var="label"/>
			</View>;
		public function PictureItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}