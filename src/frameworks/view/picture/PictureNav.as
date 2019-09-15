package frameworks.view.picture 
{
	import com.greensock.TweenLite;
	import flash.events.Event;
	import skin.tab.PictureNavUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class PictureNav extends PictureNavUI
	{
		
		public function PictureNav() 
		{
			nav.addEventListener(Event.CHANGE, onTabChange);
			stgPic.visible=myPic.visible = false;
		}
		
		private function onTabChange(e:Event):void 
		{
			switch(nav.selectedIndex)
			{
				case 0:
					stgPic.visible=myPic.visible = false;
					noerPic.visible = true;
					break;
				case 1:
					noerPic.visible=myPic.visible = false;
					stgPic.visible = true;
					break;
				case 2:
					stgPic.visible=noerPic.visible = false;
					myPic.visible = true;
					break;
			}
			
		}
		
		public function resize():void
		{
			this.x = App.stage.stageWidth - 360;
			this.y = 40;
		}
	}

}