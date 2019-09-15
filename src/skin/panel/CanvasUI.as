/**Created by the Morn,do not modify.*/
package skin.panel {
	import morn.core.components.*;
	public class CanvasUI extends View {
		protected static var uiView:XML =
			<View/>;
		public function CanvasUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}