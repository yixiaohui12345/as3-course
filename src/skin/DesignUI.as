/**Created by the Morn,do not modify.*/
package skin {
	import morn.core.components.*;
	import frameworks.view.design.Canvas;
	import frameworks.view.design.LeftPanel;
	import frameworks.view.design.RightPanel;
	import frameworks.view.design.TopPanel;
	public class DesignUI extends View {
		public var topBar:TopPanel = null;
		public var canvas:Canvas = null;
		public var menu:RightPanel = null;
		public var pptList:LeftPanel = null;
		protected static var uiView:XML =
			<View>
			  <TopPanel left="0" top="0" runtime="frameworks.view.design.TopPanel" var="topBar"/>
			  <Canvas runtime="frameworks.view.design.Canvas" var="canvas" x="165" y="40"/>
			  <RightPanel top="41" runtime="frameworks.view.design.RightPanel" var="menu" right="0"/>
			  <LeftPanel left="0" top="40" var="pptList" runtime="frameworks.view.design.LeftPanel"/>
			</View>;
		public function DesignUI(){}
		override protected function createChildren():void {
			viewClassMap["frameworks.view.design.Canvas"] = Canvas;
			viewClassMap["frameworks.view.design.LeftPanel"] = LeftPanel;
			viewClassMap["frameworks.view.design.RightPanel"] = RightPanel;
			viewClassMap["frameworks.view.design.TopPanel"] = TopPanel;
			super.createChildren();
			createView(uiView);
		}
	}
}