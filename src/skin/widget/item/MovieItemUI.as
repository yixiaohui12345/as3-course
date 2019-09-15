/**Created by the Morn,do not modify.*/
package skin.widget.item {
	import morn.core.components.*;
	public class MovieItemUI extends View {
		public var icon:Image = null;
		public var label:Label = null;
		protected static var uiView:XML =
			<View width="90" height="90">
			  <Image x="0" y="0" width="90" height="60" var="icon"/>
			  <Label text="label" x="-1" y="60" left="0" wordWrap="false" multiline="false" align="center" right="0" bottom="0" top="60" size="13" var="label" margin="0,4,0,0" color="0xffffff"/>
			</View>;
		public function MovieItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}