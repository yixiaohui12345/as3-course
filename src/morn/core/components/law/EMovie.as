package morn.core.components.law
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.media.SoundTransform;
	import frameworks.events.CompEvent;
	import frameworks.model.PageConfig;
	import morn.core.components.Box;
	import morn.core.components.Button;
	import morn.core.components.Label;
	import morn.core.components.law.EController;
	import morn.core.events.UIEvent;
	import morn.core.handlers.Handler;
	import morn.editor.core.IEComponent
	
	/**
	 * ...
	 * @author yxh
	 */
	
	[Event(name = "movieFailed", type = "morn.core.events.UIEvent")]
	
	[Event(name = "movieLoaded", type = "morn.core.events.UIEvent")]
	
	public class EMovie extends EComponent
	{
		private var _content:MovieClip = null;
		
		private var _controller:EController = null;
		
		private var _container:Box = null;
		
		private var _soundTransform:SoundTransform = null;
		
		/*********************扩展属性************************/
		protected var _url:String = null;
		
		protected var _autoPlay:Boolean = false;
		
		protected var _volume:int = 0;
		
		protected var _replay:Boolean = false;
		
		protected var _backgroundColor:Object = 0;
		
		private var _tips:Label = null;
		
		public function EMovie()
		{
		}
		
		override protected function preinitialize():void
		{
			mouseChildren = false;
			_type = EType.MOVIE;
		}
		
		override protected function createChildren():void
		{
			mouseChildren = true;
			addChild(_container = new Box());
			addChild(_eGrid = new EGrid());
			addChild(_controller = new EController());
			addChild(_tips = new Label());
			addChild(_buttonDelete=new Button("png.style.button.icon_delete"));
		}
		
		override protected function initialize():void
		{
			super.initialize();
			this.volume = 50;
			_tips.visible = false;
			_tips.width = 200;
			_tips.height = 30;
			_tips.color = 0xffffff;
			_tips.wordWrap = _tips.multiline = _tips.selectable = false;
			_tips.mouseEnabled = true;
			this.width = PageConfig.PAGE_WIDTH;
			this.height = PageConfig.PAGE_HEIGHT;
			
			_controller.playSkin = "png.style.player.play";
			_controller.pauseSkin = "png.style.player.pause";
			_controller.addEventListener(CompEvent.PLAY, onPlay);
			_controller.addEventListener(CompEvent.PAUSE, onPause);
		}
		
		override public function dispose():void
		{
			super.dispose();
			if (_content && _container.contains(_content))
			{
				_content.stop();
			}
			_content = null;
			
			if (_controller)
				_controller.removeEventListener(CompEvent.PLAY, onPlay);
				_controller.removeEventListener(CompEvent.PAUSE, onPause);
				_controller.dispose();
			
			_container && _container.dispose();
			_container = null;
			
			_tips && _tips.dispose();
			_tips = null;
			
			_soundTransform = null;
		}
		
		override public function backStarter():void
		{
		
		}
		
		private function onPlay(e:CompEvent):void
		{
			if (_content)
			{
				_content.play();
				_controller.play();
			}
		}
		
		private function onPause(e:CompEvent):void
		{
			if (_content)
			{
				_content.stop();
				_controller.pause();
			}
		}
		
		private function ioHandler(data:Object):void
		{
			if (hasEventListener(UIEvent.MOVIE_FAILED))
			{
				sendEvent(UIEvent.MOVIE_FAILED);
			}
			callLater(showLabel);
		}
		
		private function completeHandler(content:MovieClip):void
		{
			this.content = content;
			if (hasEventListener(UIEvent.MOVIE_LOADED))
			{
				sendEvent(UIEvent.MOVIE_LOADED);
			}
			callLater(hideLabel);
			_buttonDelete.x = (width - _buttonDelete.width) * 0.5;
			_buttonDelete.y =- _buttonDelete.height - 16 * 0.5;
		}
		
		public function play():void
		{
			if (this._content)
			{
				this._content.play();
				_controller.play();
			}
		}
		
		private function hideLabel():void
		{
			_tips.visible = false;
			_tips.removeEventListener(MouseEvent.CLICK, reLoad);
		}
		
		private function showLabel():void
		{
			_tips.visible = true;
			_tips.x = (width - _tips.width) * 0.5;
			_tips.y = (height - _tips.height) * 0.5;
			_tips.text = "加载视频失败,请重试";
			_tips.addEventListener(MouseEvent.CLICK, reLoad);
		}
		
		private function reLoad():void
		{
			load();
		}
		
		private function changeVideoSize():void
		{
			if (content)
			{
				var perw:Number = width / 1280;
				var perh:Number = height / 720;
				var scale:Number = (perw <= perh) ? perw : perh;
				content.scaleX = content.scaleY = scale;
				content.x = (width - 1280 * content.scaleX) * 0.5;
				content.y = (height - 720 * content.scaleY) * 0.5;
			}
			eGrid.width = width;
			eGrid.height = height;
			_controller.resize(width, height);
		}
		
		private function changeVideoStyle():void
		{
			if (!isNaN(uint(backgroundColor)))
			{
				graphics.clear();
				graphics.beginFill(uint(backgroundColor));
				graphics.drawRect(0, 0, width, height);
				graphics.endFill();
			}
		}
		
		private function load():void
		{
			App.loader.loadMovie(url, new Handler(completeHandler), null, new Handler(ioHandler));
		}
		
		protected function changeContent():void
		{
			if (content)
			{
				width = 1280;
				height = 720;
				_soundTransform && (content.soundTransform = _soundTransform)
			}
		}
		
		public function get content():MovieClip
		{
			return _content;
		}
		
		public function set content(value:MovieClip):void
		{
			if (_content != value)
			{
				if (_content && _container.contains(_content))
				{
					_container.removeChild(_content);
				}
				_content = value;
				_container.addChildAt(_content, 0);
				if (autoPlay)
				{
					play()
				}
				else
				{
					_content.gotoAndStop(50);
				}
				callLater(changeContent);
			}
		}
		
		override public function get attribute():Object
		{
			return null;
			//return {className: "morn.core.components.law.EImage", x: x, y: y, width: width, height: height, scaleX: scaleX, scaleY: scaleY, rotation: rotation, rotationX: rotationX, rotationY: rotationY, rotationZ: rotationZ, url: url, autoPlay: autoPlay, replay: replay, volume: volume, backgroundColor: backgroundColor};
		}
		
		override public function get exml():XML
		{
			return < EMovie isPreview ={true}  x = {this.x} y = {this.y} width = {this.width} 
				height = {this.height} url = {this.url}  layer = {this.parent.getChildIndex(this)} scaleX = {scaleX} scaleY = {scaleY} autoPlay = {autoPlay}
				replay={replay} volume={volume} animation={animation}  backgroundColor={backgroundColor}/>
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function set url(value:String):void
		{
			if (_url != value)
			{
				_url = value ;
				callLater(load)
			}
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			callLater(changeVideoSize);
			callLater(changeVideoStyle)
			_buttonDelete.x=(width - _buttonDelete.width) * 0.5;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			callLater(changeVideoSize);
			callLater(changeVideoStyle)
			_buttonDelete.y = 0 - _buttonDelete.height -16 * 0.5;
		}
		
		public function get autoPlay():Boolean
		{
			return _autoPlay;
		}
		
		public function set autoPlay(value:Boolean):void
		{
			if (_autoPlay != value)
			{
				_autoPlay = value;
			}
		}
		
		public function get replay():Boolean
		{
			return _replay;
		}
		
		public function set replay(value:Boolean):void
		{
			_replay = value;
		}
		
		public function get volume():int
		{
			return _volume;
		}
		
		public function set volume(value:int):void
		{
			if (_volume != value)
			{
				_volume = value;
				_soundTransform = new SoundTransform(_volume * 0.01);
				callLater(changeContent);
			}
		}
		
		public function get backgroundColor():Object
		{
			return _backgroundColor;
		}
		
		public function set backgroundColor(value:Object):void
		{
			if (_backgroundColor != value)
			{
				_backgroundColor = value;
				callLater(changeVideoStyle);
			}
		}
		
		
	}
}