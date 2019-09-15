/**Created by the Morn,do not modify.*/
package skin.tab {
	import morn.core.components.*;
	import frameworks.view.picture.PictureMass;
	import frameworks.view.picture.PictureMaterial;
	import frameworks.view.picture.PictureNative;
	public class PictureNavUI extends View {
		public var noerPic:PictureMaterial = null;
		public var nav:Tab = null;
		public var myPic:PictureNative = null;
		public var stgPic:PictureMass = null;
		protected static var uiView:XML =
			<View width="300" height="550">
			  <PictureMaterial x="0" y="30" runtime="frameworks.view.picture.PictureMaterial" var="noerPic"/>
			  <Tab labels="诺尔素材,海量图库,我的图库" skin="png.style.tab.normal" x="0" y="0" direction="horizontal" selectedIndex="0" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" var="nav"/>
			  <PictureNative x="0" y="30" var="myPic" runtime="frameworks.view.picture.PictureNative"/>
			  <PictureMass x="0" y="30" runtime="frameworks.view.picture.PictureMass" var="stgPic"/>
			</View>;
		public function PictureNavUI(){}
		override protected function createChildren():void {
			viewClassMap["frameworks.view.picture.PictureMass"] = PictureMass;
			viewClassMap["frameworks.view.picture.PictureMaterial"] = PictureMaterial;
			viewClassMap["frameworks.view.picture.PictureNative"] = PictureNative;
			super.createChildren();
			createView(uiView);
		}
	}
}