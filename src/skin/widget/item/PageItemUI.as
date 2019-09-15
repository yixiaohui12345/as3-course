/**Created by the Morn,do not modify.*/
package skin.widget.item {
	import morn.core.components.*;
	public class PageItemUI extends View {
		public var label:Label = null;
		public var icon:Image = null;
		public var btn_delete:Button = null;
		protected static var uiView:XML =
			<View width="160" height="140">
			  <Label size="14" multiline="true" wordWrap="true" width="30" height="20" align="center" bold="false" mouseChildren="false" mouseEnabled="false" var="label" text="1" color="0xffffff" left="0" y="45" centerY="0"/>
			  <Image var="icon" width="130" height="100" right="0" top="20"/>
			  <Button skin="png.style.button.delete_icon" right="0" var="btn_delete" top="2" stateNum="1"/>
			</View>;
		public function PageItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}