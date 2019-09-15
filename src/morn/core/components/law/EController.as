package morn.core.components.law
{
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import frameworks.events.CompEvent;
	import morn.core.components.Box;
	import morn.core.components.Button;
	import morn.core.components.law.IPlayer;
	
	/**
	 * ...
	 * @author yxh
	 */
	public class EController extends Box implements IPlayer
	{
		private var shape:Shape = null;
		
		private var play_button:Button = null;
		
		private var pause_button:Button = null;
		
		private var _pauseSkin:String = null;
		
		private var _playSkin:String = null;
		
		private var parentWidth:Number = 0;
		
		private var parentHeight:Number = 0;
		
		
		
		public function EController()
		{
		
		}
		
		override protected function createChildren():void
		{
			addChildAt(shape = new Shape(), 0);
			addChild(play_button = new Button());
			addChild(pause_button = new Button());
		}
		
		override protected function initialize():void
		{
			play_button.visible = true;
			pause_button.visible = false;
			play_button.buttonMode = pause_button.buttonMode = true;
			pause_button.addEventListener(MouseEvent.CLICK, onPuase);
			play_button.addEventListener(MouseEvent.CLICK, onPlay);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		}
		
		private function mouseOver(e:MouseEvent):void 
		{
			this.alpha = 1;
		}
		
		private function mouseOut(e:MouseEvent):void 
		{
			this.alpha = 0;
		}
		
		private function onPlay(e:MouseEvent):void 
		{
			dispatchEvent(new CompEvent(CompEvent.PLAY));
		}
		
		private function onPuase(e:MouseEvent):void 
		{
			dispatchEvent(new CompEvent(CompEvent.PAUSE));
		}
		
		public function stop():void
		{
			//pause_button.visible = true;
			//play_button.visible = false;
		}
		
		public function pause():void
		{
			pause_button.visible = false;
			play_button.visible = true;
		}
		
		public function resume():void
		{
			
		}
		
		public function hide():void
		{
			this.visible = false;
		}
		
		public function show():void
		{
			this.visible = true;
		}
		
		public function play():void
		{
			pause_button.visible = true;
			play_button.visible = false;
		}
		
		public function get pauseSkin():String
		{
			return _pauseSkin;
		}
		
		public function set pauseSkin(value:String):void
		{
			if (_pauseSkin != value)
			{
				_pauseSkin = value;
				pause_button.skin = _pauseSkin;
				callLater(changeController);
			}
		}
		
		public function get playSkin():String
		{
			return _playSkin;
		}
		
		public function set playSkin(value:String):void
		{
			if (_playSkin != value)
			{
				_playSkin = value;
				play_button.skin = _playSkin;
				callLater(changeController);
			}
		}
		
		public function resize(pw:Number,ph:Number):void
		{
			this.parentWidth = pw;
			this.parentHeight = ph;
			callLater(changeController);
		}
		
		public function changeController():void
		{
			shape.graphics.clear();
			shape.graphics.beginFill(0xcccccc, .6);
			shape.graphics.drawRect(0, 0, parentWidth, 30);
			play_button.x = 10;
			play_button.y = (30 - play_button.height) * 0.5;
			pause_button.x = 10;
			pause_button.y = (30 - pause_button.height) * 0.5;
			this.y = parentHeight - 30;
		}
	
	}

}