/**Created by the Morn,do not modify.*/
package skin.widget.blocks {
	import morn.core.components.*;
	import skin.widget.blocks.ColorPickerPanelUI;
	import skin.widget.item.PictureMaterialItemUI;
	public class BackGroundBlockUI extends View {
		public var radioGroup:RadioGroup = null;
		public var colorPanel:ColorPickerPanelUI = null;
		public var thumbList:List = null;
		protected static var uiView:XML =
			<View width="290" height="480">
			  <Image skin="png.style.bg.gray" x="139" y="147" left="0" top="0" right="0" bottom="0"/>
			  <Label text="背景设置" x="15" y="16" color="0xffffff"/>
			  <RadioGroup labels="无,颜色填充,图片填充" skin="png.comp.radiogroup" x="199" y="16" direction="vertical" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" labelSize="15" space="4" right="50" selectedIndex="0" var="radioGroup"/>
			  <ColorPickerPanel bottom="0" var="colorPanel" runtime="skin.widget.blocks.ColorPickerPanelUI"/>
			  <List bottom="5" top="90" repeatX="3" var="thumbList" vScrollBarSkin="png.style.vscroll.vscroll" left="5" x="1037" y="182" spaceY="6" spaceX="6" width="280">
			    <PictureMaterialItem name="render" runtime="skin.widget.item.PictureMaterialItemUI"/>
			  </List>
			</View>;
		public function BackGroundBlockUI(){}
		override protected function createChildren():void {
			viewClassMap["skin.widget.blocks.ColorPickerPanelUI"] = ColorPickerPanelUI;
			viewClassMap["skin.widget.item.PictureMaterialItemUI"] = PictureMaterialItemUI;
			super.createChildren();
			createView(uiView);
		}
	}
}