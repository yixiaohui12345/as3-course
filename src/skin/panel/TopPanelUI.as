/**Created by the Morn,do not modify.*/
package skin.panel {
	import morn.core.components.*;
	public class TopPanelUI extends View {
		public var bg:Image = null;
		public var btn_undo:Button = null;
		public var btn_redo:Button = null;
		public var btn_preview:Button = null;
		public var c_full:CheckBox = null;
		public var slider:HSlider = null;
		public var label_percent:Label = null;
		public var btn_upload:Button = null;
		public var box_exchange:HBox = null;
		public var label_name:Label = null;
		protected static var uiView:XML =
			<View height="40">
			  <Image skin="png.style.bg.zise" left="0" right="0" top="0" bottom="0" var="bg"/>
			  <HBox align="middle" space="20" x="648" centerY="0" y="-84" centerX="0">
			    <Button skin="png.style.button.undo" var="btn_undo" buttonMode="true" y="1"/>
			    <Button skin="png.style.button.redo" x="50" var="btn_redo" buttonMode="true" y="4"/>
			    <Button skin="png.style.button.preview" x="94" y="20" var="btn_preview" buttonMode="true"/>
			    <CheckBox skin="png.style.checkbox.screen" x="105" y="11" buttonMode="true" var="c_full"/>
			    <HSlider skin="png.style.slider.hslider" x="216" y="13" showLabel="false" tick="0.1" min="0.4" max="4" value="1" var="slider"/>
			    <Label text="60%" x="330" y="7" color="0xffffff" var="label_percent"/>
			    <Button skin="png.style.button.upload" x="130" var="btn_upload"/>
			  </HBox>
			  <HBox x="908" y="6" align="middle" var="box_exchange" space="10">
			    <Image skin="png.style.icon.head" url="http://games.qq.com/images/netgame/2007/09/25/1.jpg" width="30" height="30"/>
			    <Label text="测试帐号" x="39" y="3" color="0xffffff" size="15" width="70" height="25" multiline="false" wordWrap="false" underline="true" align="left" var="label_name" toolTip="切换账户" font="宋体"/>
			  </HBox>
			</View>;
		public function TopPanelUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}