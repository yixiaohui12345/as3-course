package frameworks.view.movie 
{
	import flash.events.Event;
	import skin.tab.VideoNavUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class VideoNav extends VideoNavUI
	{
		
		public function VideoNav() 
		{
			nav.addEventListener(Event.CHANGE, onTabChange);
			myMovie.visible = stgMovie.visible = false;
		}
		
		private function onTabChange(e:Event):void 
		{
			switch(nav.selectedIndex)
			{
				case 0:
					myMovie.visible = stgMovie.visible = false;
					noerMovie.visible = true;
					break;
				case 1:
					myMovie.visible = noerMovie.visible = false;
					stgMovie.visible = true;
					break;
				case 2:
					noerMovie.visible = stgMovie.visible = false;
					myMovie.visible = true;
					break
			}
		}
		
		public function resize():void
		{
			this.x = App.stage.stageWidth - 360;
			this.y = 40;
		}
		
	}

}