package frameworks.view.model 
{
	import skin.panel.ModelPanelUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class ModelPanel extends ModelPanelUI
	{
		
		public function ModelPanel() 
		{
			
		}
		
		public function resize():void
		{
			this.x = App.stage.stageWidth - 60-this.width;
			this.y = 40;
		}
		
	}

}