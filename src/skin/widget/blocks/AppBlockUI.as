/**Created by the Morn,do not modify.*/
package skin.widget.blocks {
	import morn.core.components.*;
	public class AppBlockUI extends View {
		public var c_save:ComboBox = null;
		protected static var uiView:XML =
			<View width="290" height="400">
			  <Image skin="png.style.bg.gray" x="44" y="130" left="0" right="0" top="0" bottom="0"/>
			  <Label text="自动保存" x="10" y="20" color="0xffffff"/>
			  <ComboBox labels="1分钟,3分钟,5分钟" skin="png.style.combobox.combobox" x="70" y="18" var="c_save"/>
			</View>;
		public function AppBlockUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}