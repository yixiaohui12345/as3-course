/**Created by the Morn,do not modify.*/
package skin.widget.item {
	import morn.core.components.*;
	public class PictureMaterialItemUI extends View {
		public var icon:Image = null;
		protected static var uiView:XML =
			<View width="90" height="60">
			  <Image width="90" height="60" var="icon"/>
			</View>;
		public function PictureMaterialItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}