package frameworks.view.widget.item 
{
	import flash.display.Shape;
	import skin.widget.item.PageItemUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class PageItemRender extends PageItemUI
	{
		private var _isSelected:Boolean = false;
		
		public function PageItemRender() 
		{
		}
		
		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
			graphics.clear();
			if (value)
			{
				graphics.beginFill(0x282828);
				graphics.drawRect(0, 0, 170, height);
			}
			else
			{
				graphics.beginFill(0x1a1a1a);
				graphics.drawRect(0, 0, 170, height);
			}
			graphics.endFill();
		}
		
		public function get isSelected():Boolean
		{
			return _isSelected;
		}
	}

}