package frameworks.view.settings 
{
	import frameworks.view.blocks.BackGroundBlock;
	import frameworks.view.blocks.AppBlock;
	import morn.core.components.FlexBox;
	import morn.core.components.Panel;
	import skin.panel.SettingPanelUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class SettingPanel extends SettingPanelUI
	{
		private static const LIST:String = "背景设置";
		
		private var flexBox:FlexBox = null;
		
		private var panel:Panel = null
		
		public var bg_block:BackGroundBlock;
		
		public var app_block:AppBlock;
		
		public function SettingPanel() 
		{
			panel = new Panel();
			panel.x = 0;
			panel.y = 0;
			panel.width = this.width;
			panel.height = this.height;
			panel.vScrollBarSkin = "png.style.vscroll.vscroll";
			panel.vScrollBarSizeGrid = "2,4,2,4";
			addChild(panel);
			flexBox = new FlexBox(LIST, "png.style.combobox.flexBox");
			flexBox.blocks = [BackGroundBlock];
			panel.addChild(flexBox);
			flexBox.x = 5;
			flexBox.y = 10;
			flexBox.space = 10;
			flexBox.labelColors = "0xffffff,0x2b2b2b,0x2b2b2b,0xffffff"
			
			bg_block = flexBox.getBlocks(0) as BackGroundBlock;
			//app_block = flexBox.getBlocks(1) as AppBlock
			//app_block.c_save.selectedIndex = 0;
		}
		
		public function resize():void
		{
			this.x = App.stage.stageWidth - 60-this.width;
			this.y = 40;
		}
	}

}