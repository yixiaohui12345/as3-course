/**Created by the Morn,do not modify.*/
package skin.tab {
	import morn.core.components.*;
	import frameworks.view.movie.VideoMass;
	import frameworks.view.movie.VideoMaterial;
	import frameworks.view.movie.VideoNative;
	public class VideoNavUI extends View {
		public var nav:Tab = null;
		public var noerMovie:VideoMaterial = null;
		public var myMovie:VideoNative = null;
		public var stgMovie:VideoMass = null;
		protected static var uiView:XML =
			<View width="300" height="550">
			  <Tab labels="诺尔动漫,精彩短片,我的视频" skin="png.style.tab.normal" direction="horizontal" selectedIndex="0" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" right="0" left="0" top="0" var="nav"/>
			  <VideoMaterial x="0" y="30" runtime="frameworks.view.movie.VideoMaterial" var="noerMovie"/>
			  <VideoNative x="0" y="30" var="myMovie" runtime="frameworks.view.movie.VideoNative"/>
			  <VideoMass x="0" y="30" runtime="frameworks.view.movie.VideoMass" var="stgMovie" visible="false"/>
			</View>;
		public function VideoNavUI(){}
		override protected function createChildren():void {
			viewClassMap["frameworks.view.movie.VideoMass"] = VideoMass;
			viewClassMap["frameworks.view.movie.VideoMaterial"] = VideoMaterial;
			viewClassMap["frameworks.view.movie.VideoNative"] = VideoNative;
			super.createChildren();
			createView(uiView);
		}
	}
}