package frameworks.view.widget
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author yxh
	 */
	public class Alert extends Sprite
	{
		public static const LONG:int = 6 * 1000;
		
		public static const MIDDLE:int = 4 * 1000;
		
		public static const SHORT:int = 2 * 1000;
		
		private static const MARGIN:int = 26;
		
		private var timer:Timer;
		
		private var label:TextField = null;
		
		private static var _inst:Alert = null;
		public static function get inst():Alert
		{
			if (_inst == null)
			{
				_inst = new Alert();
			}
			return _inst;
		}
		
		public function Alert() 
		{
			label = new TextField();
			label.defaultTextFormat = new TextFormat("微软雅黑", 15, 0xffffff,null,null,null,null,null,TextFormatAlign.CENTER);
			label.mouseEnabled = label.selectable = false;
			label.multiline = label.wordWrap = true;
			this.addChild(label);
		}
		
		public function show(msg:String, time:int = 3000):void
		{
			removeTimer()
			this.label.text = msg;
			this.label.width = msg.length * 25 > 1080 * 0.5?1080 * 0.5:msg.length * 25;
			this.label.height = this.label.textHeight + 20;
			this.label.x = this.label.y = 2;
			this.graphics.clear();
			this.graphics.beginFill(0, 0.6);
			this.graphics.drawRoundRect(0, 0, this.label.width + 4, this.label.height + 4,8,8);
			this.graphics.endFill();
			this.x = (App.stage.stageWidth - this.width) / 2;
			this.y = 0.7 * App.stage.stageHeight
			this.timer = new Timer(time / 10, 10);
			this.timer.addEventListener(TimerEvent.TIMER, onTimer);
			this.timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimeComplete);
			this.timer.start();
			App.stage.addChild(this);
		}
		
		private function removeTimer():void
		{
			if (timer)
			{
				timer.reset();
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, onTimer);
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimeComplete);
				timer = null;
			}
			if (this.parent)
			{
				this.parent.removeChild(this);
			}
		}
		
		private function onTimeComplete(e:TimerEvent):void 
		{
			removeTimer()
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			if (this.parent)
			{
				(this.parent as DisplayObjectContainer).setChildIndex(this, this.parent.numChildren - 1);
			}
		}
	}

}