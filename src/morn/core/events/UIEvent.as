/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.core.events {
	import flash.events.Event;
	
	/**UI事件类*/
	public class UIEvent extends Event 
	{
		//-----------------Component-----------------	
		/**属性改变*/
		public static const PROPERTY_CHANGE:String = "propertyChange";
		/**延时移动组件*/
		public static const MOVE_DELAY:String = "moveDelay";
		/**移动组件*/
		public static const MOVE:String = "move";
		/**更新完毕*/
		public static const RENDER_COMPLETED:String = "renderCompleted";
		/**显示鼠标提示*/
		public static const SHOW_TIP:String = "showTip";
		/**隐藏鼠标提示*/
		public static const HIDE_TIP:String = "hideTip";
		//-----------------Image-----------------
		/**图片加载完毕*/
		public static const IMAGE_LOADED:String = "imageLoaded";
		
		public static const IMAGE_FAILED:String = "imageFailed";
		//-----------------TextArea-----------------
		/**滚动*/
		public static const SCROLL:String = "scroll";
		
		public static const SCROLL_BEGIN:String = "scrollBegin";
		
		public static const SCROLL_END:String = "scrollEnd";
		//-----------------FrameClip-----------------
		/**帧跳动*/
		public static const FRAME_CHANGED:String = "frameChanged";
		//-----------------List-----------------
		/**项渲染*/
		public static const ITEM_RENDER:String = "listRender";
		//-----------------EMovie------------------
		public static const MOVIE_LOADED:String = "movieLoaded"
		
		public static const MOVIE_FAILED:String = "movieFailed";
		//-----------------EImage------------------
		//-----------------ETextArea------------------
		public static const RESIZE_ITEM:String = "resizeItem";
		
		public static const CORNER_TOUCH:String = "cornerTouch";
		
		public static const SELECT_ITEM:String = "selectItem";
		
		public static const DELETE:String = "delete";
		
		public static const OVER_COLOR_CHANGE:String = "overColorChange";;
		
		public static const SELECT_COLOR:String = "selectColor";
		
		public static const REMOVE:String = "onRemoved";
		
		public static const LINK:String = "link";
		
		private var _data:*;
		
		public function UIEvent(type:String, data:*, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		/**事件数据*/
		public function get data():* {
			return _data;
		}
		
		public function set data(value:*):void {
			_data = value;
		}
		
		override public function clone():Event {
			return new UIEvent(type, _data, bubbles, cancelable);
		}
	}
}