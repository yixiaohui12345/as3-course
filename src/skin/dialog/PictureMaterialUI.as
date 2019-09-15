/**Created by the Morn,do not modify.*/
package skin.dialog {
	import morn.core.components.*;
	import skin.widget.item.PictureItemUI;
	import skin.widget.item.PictureMaterialItemUI;
	public class PictureMaterialUI extends View {
		public var label_tips:Label = null;
		public var picList:List = null;
		public var thumbList:List = null;
		public var label_count:Label = null;
		public var btn_back:Button = null;
		protected static var uiView:XML =
			<View width="300" height="540">
			  <Image skin="png.style.bg.gray" right="0" left="0" top="0" bottom="0" sizeGrid="4,4,4,4"/>
			  <Label text="暂时没有内容" x="381" y="224" width="300" height="100" multiline="true" wordWrap="true" align="center" size="16" font="微软雅黑" var="label_tips" centerX="0" centerY="0"/>
			  <List bottom="5" top="180" repeatX="3" var="picList" vScrollBarSkin="png.style.vscroll.vscroll" width="295" left="5" spaceX="6" spaceY="6">
			    <PictureItem name="render" runtime="skin.widget.item.PictureItemUI"/>
			  </List>
			  <List bottom="5" top="80" repeatX="3" var="thumbList" vScrollBarSkin="png.style.vscroll.vscroll" left="5" x="1071" y="171" spaceY="6" spaceX="6" width="295">
			    <PictureMaterialItem name="render" runtime="skin.widget.item.PictureMaterialItemUI"/>
			  </List>
			  <Label text="总数:18" x="941" y="7" align="right" right="10" var="label_count" color="0xffffff" size="13"/>
			  <Button skin="png.style.button.button_return" top="5" var="btn_back" x="180" y="63" left="5" stateNum="1" width="25" height="25"/>
			</View>;
		public function PictureMaterialUI(){}
		override protected function createChildren():void {
			viewClassMap["skin.widget.item.PictureItemUI"] = PictureItemUI;
			viewClassMap["skin.widget.item.PictureMaterialItemUI"] = PictureMaterialItemUI;
			super.createChildren();
			createView(uiView);
		}
	}
}