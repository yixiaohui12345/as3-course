/**Created by the Morn,do not modify.*/
package skin.widget.item {
	import morn.core.components.*;
	import skin.widget.item.StyleItemUI;
	public class FontAlignUI extends View {
		public var list:List = null;
		protected static var uiView:XML =
			<View width="170" height="70">
			  <Image skin="png.style.bg.dialog" x="10" y="10" left="0" right="0" top="0" bottom="0" sizeGrid="5,5,5,5"/>
			  <List left="5" right="5" top="5" bottom="5" var="list">
			    <StyleItem name="render" runtime="skin.widget.item.StyleItemUI"/>
			  </List>
			</View>;
		public function FontAlignUI(){}
		override protected function createChildren():void {
			viewClassMap["skin.widget.item.StyleItemUI"] = StyleItemUI;
			super.createChildren();
			createView(uiView);
		}
	}
}