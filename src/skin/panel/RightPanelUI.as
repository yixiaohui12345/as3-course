/**Created by the Morn,do not modify.*/
package skin.panel {
	import morn.core.components.*;
	public class RightPanelUI extends View {
		public var btn_font:HBox = null;
		public var btn_image:HBox = null;
		public var btn_movie:HBox = null;
		public var btn_animate:HBox = null;
		public var btn_setting:HBox = null;
		public var btn_style:HBox = null;
		public var btn_music:HBox = null;
		public var btn_model:HBox = null;
		protected static var uiView:XML =
			<View width="60">
			  <Image skin="png.style.bg.black" left="0" right="0" top="0" bottom="0"/>
			  <HBox x="7" y="5" align="middle" space="3" var="btn_font">
			    <Button skin="png.style.button.font" y="8" right="5" x="23"/>
			    <Label text="文字" color="0xcccccc" multiline="true" wordWrap="true" width="25" size="14"/>
			  </HBox>
			  <HBox x="7" y="55" align="middle" space="-2" var="btn_image">
			    <Label text="图片" color="0xcccccc" multiline="true" wordWrap="true" width="25" size="14"/>
			    <Button skin="png.style.button.image"/>
			  </HBox>
			  <HBox x="7" y="105" align="middle" space="-2" var="btn_movie">
			    <Label text="视频" color="0xcccccc" multiline="true" wordWrap="true" width="25" size="14"/>
			    <Button skin="png.style.button.movie" x="22" y="5"/>
			  </HBox>
			  <HBox space="-2" x="7" y="205" var="btn_animate">
			    <Label text="动作" color="0xcccccc" multiline="true" wordWrap="true" width="25" size="14"/>
			    <Button skin="png.style.button.animate" x="22" y="6"/>
			  </HBox>
			  <HBox x="7" y="306" align="middle" space="-2" var="btn_setting">
			    <Label text="设置" color="0xcccccc" multiline="true" wordWrap="true" width="25" size="14"/>
			    <Button skin="png.style.button.setting" x="27" y="3"/>
			  </HBox>
			  <HBox x="7" y="256" space="-2" align="middle" var="btn_style">
			    <Label text="样式" color="0xcccccc" multiline="true" wordWrap="true" width="25" size="14"/>
			    <Button skin="png.style.button.style" x="21" y="5"/>
			  </HBox>
			  <HBox x="7" y="155" align="middle" space="1" var="btn_music">
			    <Label text="音乐" color="0xcccccc" multiline="true" wordWrap="true" width="25" size="14"/>
			    <Button skin="png.style.button.music" x="66" y="13"/>
			  </HBox>
			  <HBox x="7" y="355" align="middle" var="btn_model">
			    <Button skin="png.style.button.model" x="26" y="7"/>
			    <Label text="模版" color="0xcccccc" size="14" multiline="true" wordWrap="true" width="20" height="40"/>
			  </HBox>
			</View>;
		public function RightPanelUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}