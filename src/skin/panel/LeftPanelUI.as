/**Created by the Morn,do not modify.*/
package skin.panel {
	import morn.core.components.*;
	import frameworks.view.widget.item.PageItemRender;
	public class LeftPanelUI extends View {
		public var btn_add:Button = null;
		public var imageList:List = null;
		protected static var uiView:XML =
			<View width="170" height="526">
			  <Image skin="png.style.bg.black" x="0" y="0" left="0" right="0" top="0" bottom="0" sizeGrid="5,5,5,5"/>
			  <Button label="+ 新建" skin="png.style.button.normal" labelFont="宋体" labelSize="15" var="btn_add" top="5" centerX="0" sizeGrid="20,10,20,10" height="26" width="100" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" x="35" y="7"/>
			  <List top="45" bottom="0" var="imageList" spaceY="3" vScrollBarSkin="png.style.vscroll.vscroll" right="0" left="0">
			    <PageItem runtime="frameworks.view.widget.item.PageItemRender" name="render"/>
			  </List>
			</View>;
		public function LeftPanelUI(){}
		override protected function createChildren():void {
			viewClassMap["frameworks.view.widget.item.PageItemRender"] = PageItemRender;
			super.createChildren();
			createView(uiView);
		}
	}
}