/**Created by the Morn,do not modify.*/
package skin.dialog {
	import morn.core.components.*;
	import skin.widget.item.CourseItemUI;
	public class CourseNativeUI extends View {
		public var search_box:HBox = null;
		public var label_search:TextInput = null;
		public var btn_search:Image = null;
		public var btn_home:Image = null;
		public var label_page:Label = null;
		public var btn_pre:Button = null;
		public var btn_next:Button = null;
		public var courseList:List = null;
		public var checkbox_select:CheckBox = null;
		protected static var uiView:XML =
			<View>
			  <HBox x="784" y="7" right="15" top="10" var="search_box">
			    <TextInput skin="png.comp.textinput" height="30" size="16" color="0x999999" width="200" var="label_search" margin="3,3,3,3"/>
			    <Image skin="png.style.button.search" x="202" y="1" height="30" var="btn_search"/>
			  </HBox>
			  <Image skin="png.style.button.home" x="15" y="10" var="btn_home" toolTip="返回主页"/>
			  <HBox x="863" y="563" align="middle" space="10" right="20" bottom="10">
			    <Label text="0/1" x="52" y="10" color="0x666666" var="label_page"/>
			    <Button label="上一页" skin="png.style.button.page" sizeGrid="3,3,3,3" height="25" var="btn_pre" y="9"/>
			    <Button label="下一页" skin="png.style.button.page" x="101" var="btn_next" sizeGrid="3,3,3,3" height="25"/>
			  </HBox>
			  <List spaceX="60" var="courseList" vScrollBarSkin="png.style.vscroll.vscroll" x="15" bottom="40" left="15" top="130" right="15" spaceY="10">
			    <CourseItem name="render" runtime="skin.widget.item.CourseItemUI"/>
			  </List>
			  <CheckBox skin="png.style.checkbox.checkbox_shen" var="checkbox_select" label="科目" labelSize="13" labelColors="0,0,0,0" x="10" y="64"/>
			</View>;
		public function CourseNativeUI(){}
		override protected function createChildren():void {
			viewClassMap["skin.widget.item.CourseItemUI"] = CourseItemUI;
			super.createChildren();
			createView(uiView);
		}
	}
}