package frameworks.view.design 
{
	import frameworks.events.CompEvent;
	import skin.DesignUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class Design extends DesignUI
	{
		
		public function Design() 
		{
			
		}
		
		public function resize():void
		{
			canvas.resize();
			pptList.resize();
			menu.resize();
			topBar.resize();
		}
	}

}