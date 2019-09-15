package frameworks.view.design 
{
	import frameworks.events.CompEvent;
	import frameworks.model.command.CommandManager;
	import morn.core.components.ComboBox;
	import morn.core.components.Component;
	import morn.core.events.UIEvent;
	import skin.panel.TopPanelUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class TopPanel extends TopPanelUI
	{
		public var combobox_mode:ComboBox = null;
		
		public function TopPanel() 
		{
			slider.addEventListener(UIEvent.SCROLL_END, scrollEnd);
			CommandManager.inst.addEventListener(CompEvent.CHANGE_CMD, commandChange);
			btn_undo.visible = btn_redo.visible = false;
			
			combobox_mode = new ComboBox("png.style.combobox.combobox_home","课件编辑,课件中心");
			combobox_mode.selectedIndex = 0;
			combobox_mode.x = 10;
			combobox_mode.centerY = 0;
			combobox_mode.labelMargin = "2,0,2,0";
			combobox_mode.labelColors = "0xffffff,0xffffff,0xffffff,0xffffff";
			addChild(combobox_mode);
		}
		
		private function commandChange(e:CompEvent):void 
		{
			btn_undo.visible = CommandManager.inst.CanUndo
			btn_redo.visible = CommandManager.inst.CanRedo;
		}
		
		private function scrollEnd(e:UIEvent):void 
		{
			this.dispatchEvent(new CompEvent(CompEvent.CHANGE_SCALE, slider.value));
			label_percent.text = int(slider.value * 100) + "%";
		}
		
		public function resize():void
		{
			bg.width=this.width = App.stage.stageWidth;
			bg.height=this.height = 40;
			for (var i:int = 0; i < this.numChildren; i++)
			{
				(this.getChildAt(i) as Component).updatePosition();
			}
			box_exchange.x = App.stage.stageWidth-100
		}
		
	}

}