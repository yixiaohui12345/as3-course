package frameworks.view.music 
{
	import morn.core.components.SimpleSlider;
	import skin.panel.MusicPanelUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class MusicPanel extends MusicPanelUI
	{
		public var volumeSlider:SimpleSlider = null;
		
		public var delaySlider:SimpleSlider = null;
		
		public function MusicPanel() 
		{
			volumeSlider = new SimpleSlider();
			delaySlider = new SimpleSlider();
			volumeSlider.skin = delaySlider.skin = "png.style.icon.border";
			volumeSlider.sizeGrid = delaySlider.sizeGrid = "2,2,43,2";
			volumeSlider.max = 100; volumeSlider.min = 0; volumeSlider.value = 50;
			delaySlider.value = 0; delaySlider.max = 10; delaySlider.min = 0;
			delaySlider.x= volumeSlider.x = 90;
			volumeSlider.y = 196;
			delaySlider.y = 153;
			addChild(volumeSlider);
			addChild(delaySlider);
		}
		
		public function resize():void
		{
			this.x = App.stage.stageWidth - 360;
			this.y = 40;
		}
	}

}