/**Created by the Morn,do not modify.*/
package skin.widget.item {
	import morn.core.components.*;
	public class CourseItemUI extends View {
		public var icon:Image = null;
		public var label:Label = null;
		public var label_date:Label = null;
		public var label_page:Label = null;
		protected static var uiView:XML =
			<View width="200" height="200">
			  <Image skin="png.style.icon.cover" var="icon"/>
			  <VBox align="center" space="2" left="0" right="0" bottom="5">
			    <Label text="浩浩和胖子在干嘛" backgroundColor="0xffffff" color="0x0" size="13" left="5" right="5" align="center" var="label" mouseChildren="false" mouseEnabled="false"/>
			    <Label text="创建于:2016-8-1" backgroundColor="0xffffff" color="0x0" size="13" left="5" right="5" align="center" var="label_date" mouseChildren="false" mouseEnabled="false"/>
			    <Label text="总页数: 18页" backgroundColor="0xffffff" color="0x0" size="13" left="5" right="5" align="center" var="label_page" mouseChildren="false" mouseEnabled="false"/>
			  </VBox>
			</View>;
		public function CourseItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}