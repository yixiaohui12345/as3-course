/**Created by the Morn,do not modify.*/
package skin.widget.item {
	import morn.core.components.*;
	public class IamgeItemUI extends View {
		public var icon:Image = null;
		protected static var uiView:XML =
			<View width="60" height="60">
			  <Image width="60" height="60" var="icon"/>
			</View>;
		public function IamgeItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}