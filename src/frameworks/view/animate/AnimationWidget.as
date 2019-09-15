package frameworks.view.animate 
{
	import frameworks.message.EffectConfig;
	import morn.core.components.SimpleSlider;
	import skin.panel.AnimationPanelUI
	/**
	 * ...
	 * @author yxh
	 */
	public class AnimationWidget extends AnimationPanelUI
	{
		public var sliderLast:SimpleSlider = null;
		
		public var sliderDelay:SimpleSlider = null;
		
		public function AnimationWidget() 
		{
			sliderLast = new SimpleSlider();
			sliderDelay = new SimpleSlider();
			sliderDelay.skin = sliderLast.skin = "png.style.icon.border";
			sliderLast.sizeGrid = sliderDelay.sizeGrid = "4,2,43,2";
			sliderLast.hint = sliderDelay.hint = "秒";
			sliderLast.min = 0; sliderLast.max = 10;
			sliderDelay.min = 0; sliderDelay.max = 10;
			sliderDelay.width = sliderLast.width = 100;
			sliderDelay.value = 0;
			sliderLast.value = 1;
			sliderLast.x = 50
			sliderDelay.x = 200;
			sliderLast.y = sliderDelay.y = 60;
			addChild(sliderLast);
			addChild(sliderDelay);
			
			effectBox.labels = EffectConfig.LIST.join();
			effectBox.labelColors = "0,0,0,0";
			effectBox.selectedIndex = 0;
		}
		
		public function get delay():int
		{
			return sliderDelay.value;
		}
		
		public function get last():int
		{
			return sliderLast.value;
		}
		
		public function resize():void
		{
			this.x = App.stage.stageWidth - 360;
			this.y = 40;
		}
	}

}