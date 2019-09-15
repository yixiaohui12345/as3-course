package frameworks.view.widget 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author yxh
	 */
	public class Loading extends Sprite
	{
		private var loading:LoadingSkin = null;
		
		private var label:TextField = null;
		
		public function Loading() 
		{
			loading = new LoadingSkin();
			addChild(loading);
			
			label = new TextField();
			label.defaultTextFormat = new TextFormat("微软雅黑", 15, 0xffffff,null,null,null,null,null,TextFormatAlign.CENTER);
			label.mouseEnabled = label.selectable = false;
			label.multiline = label.wordWrap = true;
			label.width = 120;
			this.addChild(label);
		}
		
		private static var _inst:Loading = null;
		public static function get inst():Loading
		{
			if (_inst == null)
			{
				_inst = new Loading();
			}
			return _inst;
		}
		
		public function start(tips:String="加载中,请稍候"):void
		{
			graphics.clear();
			graphics.beginFill(0, 0);
			graphics.drawRect(0, 0, App.stage.stageWidth, App.stage.stageHeight);
			graphics.endFill();
			label.text = tips;
			loading.x = (App.stage.stageWidth - loading.width) * 0.5;
			loading.y = (App.stage.stageHeight - loading.height) * 0.5;
			label.x = (loading.width - label.width) * 0.5+loading.x;
			label.y = loading.y + loading.height + 10;
			App.stage.addChild(this);
			
		}
		
		public function stop():void
		{
			if (this.parent)
			{
				this.parent.removeChild(this);
			}
		}
		
	}

}