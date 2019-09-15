package morn.core.components.law 
{
	import com.noteflight.standingwave3.formats.WaveFile;
	import com.noteflight.standingwave3.output.AudioPlayer;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.ByteArray;
	import morn.core.components.Button;
	import morn.core.components.Image;
	import morn.core.handlers.Handler;
	/**
	 * ...
	 * @author yxh
	 */
	public class EMusic extends EComponent
	{
		protected var _image:Image = null;
		
		protected var _url:String = null;
		
		protected var _autoPlay:Boolean = false;
		
		protected var _replay:Boolean = false;
		
		protected var _delaySec:int = 0;
		
		protected var _volume:int = 0;
		
		protected var _soundBytes:ByteArray = null;
		
		protected var sound:Sound = null;
		
		protected var soundChannel:SoundChannel = null;
		
		protected var soundTransforms:SoundTransform = null;
		
		protected var player:AudioPlayer = null;
		
		protected var _skin:String = null;
		
		public function EMusic(skin:String=null) 
		{
			this.skin = skin;
		}
		
		override protected function preinitialize():void
		{
			mouseChildren = false;
		}
		
		override protected function createChildren():void
		{
			mouseChildren = true
			addChild(_image = new Image());
			_eGrid = new EGrid()
			addChild(_buttonDelete=new Button("png.style.button.icon_delete"));
		}
		
		override protected function initialize():void
		{
			super.initialize();
			_type = EType.MUSIC
			this.volume = 50;
			_buttonDelete.visible=_eGrid.visible = false;
		}
		
		public function get skin():String 
		{
			return _skin;
		}
		
		public function set skin(value:String):void 
		{
			if (_skin != value)
			{
				_image.skin = _skin = value;
				_image.anchorX = _image.anchorY = 0.5;
				_buttonDelete.x =-_image.width * 0.5;
				_buttonDelete.y =- _buttonDelete.height - _image.height * 0.5;
			}
		}
		
		public function get url():String 
		{
			return _url;
		}
		
		public function set url(value:String):void 
		{
			if (_url != value)
			{
				App.loader.loadBYTE(url, new Handler(completeHandler));
			}
		}
		
		public function get soundBytes():ByteArray 
		{
			return _soundBytes;
		}
		
		public function set soundBytes(value:ByteArray):void 
		{
			if (_soundBytes != value)
			{
				_image.alpha = 1
				if (!isNaN(_delaySec)){
					App.timer.doOnce(_delaySec * 1000, onDelay,[value]);
				}
				else{
					startToPlay(value);
				}
			}
			else
			{
				_image.alpha = 0.2;
			}
			_buttonDelete.visible = true;
		}
		
		private function onDelay(bytes:ByteArray):void
		{
			startToPlay(bytes);
		}
		
		private function startToPlay(bytes:ByteArray):void
		{
			switch(soundType)
			{
				case ".mp3":
					sound = sound || new Sound();
					sound.loadCompressedDataFromByteArray(bytes, bytes.bytesAvailable);
					soundChannel = sound.play(0, 0, soundTransforms);
					soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
					break;
				case ".wav":
					player = player || new AudioPlayer();
					player.play(WaveFile.createSample(bytes));
					soundChannel = player.channel;
					soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
					break;
			}
			App.timer.doFrameLoop(2, onTween);
		}
		
		private function onTween():void
		{
			_image && _image.rotation++;
		}
		
		private function onSoundComplete(e:Event):void 
		{
			App.timer.clearTimer(onTween);
			_image.rotation = 0;
			if (_replay)
			{
				if (sound)
				{
					soundChannel = sound.play(0, 0, soundTransforms);
					soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				}
				else if (player)
				{
					player.play(WaveFile.createSample(_soundBytes));
					soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				}
				App.timer.doFrameLoop(2, onTween);
			}
		}
		
		private function completeHandler(byte:ByteArray):void
		{
			this.soundBytes = byte;
		}
		
		public function get soundType():String
		{
			if (_url)
			{
				return _url.substr( -4).toLocaleLowerCase();
			}
			return null;
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
				soundTransforms = soundTransforms || new SoundTransform();
				soundTransforms.volume = value*0.01;
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
		
		public function get delaySec():int 
		{
			return _delaySec;
		}
		
		public function set delaySec(value:int):void 
		{
			_delaySec = value;
		}
		
		override public function get exml():XML
		{
			var xml:XML =<EText></EText>;
			xml.@isPreview = "true";
			xml.@x = x;
			xml.@y = y;
			xml.@width = width;
			xml.@height = height;
			xml.@layer = this.parent.getChildIndex(this)
			xml.@url = url;
			xml.@volume = volume;
			xml.@replay = replay;
			xml.@delaySec = delaySec;
			return xml;
		}
		
		override public function get attribute():Object
		{
			return null;
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			if (soundChannel)
			{
				soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				soundChannel.stop();
			}
			if (player)
			{
				player.stop();
			}
			_image && _image.dispose();
			_soundBytes && _soundBytes.clear();
			_soundBytes = null;
			sound = null;
			soundChannel = null;
			player = null;
			_image = null;
			soundTransforms = null;
			App.timer.clearTimer(onTween);
			App.timer.clearTimer(onDelay);
		}
	}
}