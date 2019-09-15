package morn.core.components.extension 
{
	import flash.events.MouseEvent;
	import morn.core.components.Button;
	/**
	 * ...
	 * @author yxh
	 */
	public class TabButton extends Button
	{
		
		public function TabButton(skin:String = null, label:String = "") 
		{
			super(skin, label);
		}
		
		override protected function onMouse(e:MouseEvent):void {
			
			if (e.type == MouseEvent.CLICK) {
				if (_toggle) {
					selected = !_selected;
				}
				if (_clickHandler) {
					_clickHandler.execute();
				}
				return;
			}
			if (_selected == false) {
				state = stateMap[e.type];
			}
		}
	}

}