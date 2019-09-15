/**Created by the Morn,do not modify.*/
package skin.panel {
	import morn.core.components.*;
	public class LoginPanelUI extends View {
		public var label_forget:Label = null;
		public var btn_login:Image = null;
		public var btn_register:Label = null;
		public var label_userno:TextInput = null;
		public var label_password:TextInput = null;
		public var checkbox_login:CheckBox = null;
		protected static var uiView:XML =
			<View>
			  <Image skin="jpg.style.bg.background" x="281" y="114" centerX="0" centerY="0"/>
			  <Box centerX="0" centerY="0" x="-185" y="0">
			    <Image skin="png.style.bg.body" sizeGrid="8,8,8,8" alpha="0.8" width="350" height="220"/>
			    <Label text="忘记密码？" x="233" y="6" color="0xffffff" right="5" multiline="false" wordWrap="false" underline="true" var="label_forget" font="宋体" mouseEnabled="true" mouseChildren="true"/>
			    <Image skin="png.style.bg.label" x="46" y="35" centerX="0"/>
			    <Image skin="png.style.bg.label" x="41.5" y="110" centerX="0"/>
			    <Image skin="png.style.button.login" x="247" y="111" var="btn_login"/>
			    <Label text="注册" x="239" y="190" color="0xffffff" multiline="false" wordWrap="false" underline="true" var="btn_register" left="10" font="宋体" mouseEnabled="true" mouseChildren="true"/>
			    <TextInput x="90" y="45" color="0xffffff" width="200" height="23" var="label_userno" size="16"/>
			    <TextInput x="90" y="121" color="0xffffff" width="150" height="23" var="label_password" asPassword="true" size="16"/>
			    <CheckBox skin="png.style.checkbox.checkbox" x="322" y="191" var="checkbox_login"/>
			    <Label text="两周内自动登录" x="233" y="191" color="0xffffff" multiline="false" wordWrap="false" disabled="true" mouseChildren="false" mouseEnabled="false" font="宋体"/>
			    <Label text="帐号" x="55" y="46" color="0xffffff" multiline="false" wordWrap="false" mouseChildren="false" mouseEnabled="false"/>
			    <Label text="密码" x="55" y="122" color="0xffffff" multiline="false" wordWrap="false" mouseChildren="false" mouseEnabled="false"/>
			  </Box>
			</View>;
		public function LoginPanelUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}