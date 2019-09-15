package frameworks.view.design 
{
	import flash.events.MouseEvent;
	import frameworks.events.CompEvent;
	import morn.core.components.Button;
	import skin.panel.RightPanelUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class RightPanel extends RightPanelUI
	{
		private var thumb:Button = null;
		
		public function RightPanel() 
		{
			btn_font.toolTip = "拖动插入文字";
			btn_image.toolTip = "添加图片";
			btn_movie.toolTip = "添加影片";
			btn_animate.toolTip="添加动画"
			btn_setting.toolTip = "设置"
		    btn_model.visible = false;
			btn_font.addEventListener(MouseEvent.MOUSE_DOWN, onFontDown);
			thumb=new Button("png.style.button.font")
		}
		
		private function onFontDown(e:MouseEvent):void 
		{
			App.stage.addEventListener(MouseEvent.MOUSE_UP, onFontUp);
			thumb.x = App.stage.mouseX;
			thumb.y = App.stage.mouseY;
			App.stage.addChild(thumb);
			thumb.startDrag(false);
		}
		
		private function onFontUp(e:MouseEvent):void 
		{
			App.stage.removeEventListener(MouseEvent.MOUSE_UP, onFontUp);
			thumb.stopDrag();
			thumb.remove();
			dispatchEvent(new CompEvent(CompEvent.LOAD_TXT, {px:thumb.x, py:thumb.y,target:thumb}));
		}
		
		public function resize():void
		{
			this.x = App.stage.stageWidth - this.width;
			this.height = App.stage.stageHeight - 40;
			this.y = 40;
		}
	}

}