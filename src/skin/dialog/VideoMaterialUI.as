/**Created by the Morn,do not modify.*/
package skin.dialog {
	import morn.core.components.*;
	import skin.widget.item.MovieItemUI;
	public class VideoMaterialUI extends View {
		public var videoList:List = null;
		public var label_tips:Label = null;
		protected static var uiView:XML =
			<View width="300" height="540">
			  <Image skin="png.style.bg.gray" sizeGrid="5,5,5,5" left="0" right="0" top="0" bottom="0"/>
			  <List bottom="5" top="160" repeatX="3" spaceX="6" spaceY="6" var="videoList" vScrollBarSkin="png.style.vscroll.vscroll" width="290" left="5">
			    <MovieItem name="render" runtime="skin.widget.item.MovieItemUI"/>
			  </List>
			  <Label text="暂时没有内容" x="371" y="214" width="300" height="100" multiline="true" wordWrap="true" align="center" size="16" font="微软雅黑" var="label_tips" centerX="0" centerY="0"/>
			</View>;
		public function VideoMaterialUI(){}
		override protected function createChildren():void {
			viewClassMap["skin.widget.item.MovieItemUI"] = MovieItemUI;
			super.createChildren();
			createView(uiView);
		}
	}
}