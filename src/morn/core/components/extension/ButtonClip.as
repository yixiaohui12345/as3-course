package morn.core.components.extension 
{
	import morn.core.components.AutoBitmap;
	import morn.core.components.Button;
	import morn.core.utils.ObjectUtils;
	/**
	 * 图文按钮
	 * @author yxh
	 */
	public class ButtonClip extends Button
	{
		/**
		 * 水平居中
		 */
		static public const CENTER:String = "center"
		
		static public const MIDDLE:String = "middle";
		
		static public const LEFT:String = "left";
		
		static public const RIGHT:String = "right";
		
		static public const JUSITY:String = "jusity";
		
		protected var _icon:AutoBitmap = null;
		
		protected var _iconSkin:String = null;
		
		protected var _iconMargin:Array = [2, 2, 2, 2];
		
		private var _iconAlign:String = "center";
		
		private var _space:Number = 2;
		
		public function ButtonClip(skin:String = null, label:String ="",iconSkin:String=null) 
		{
			this.skin = skin;
			this.label = label;
			this.iconSkin=iconSkin
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			addChild(_icon = new AutoBitmap());
		}
		
		public function get iconSkin():String 
		{
			return _iconSkin;
		}
		
		public function set iconSkin(value:String):void 
		{
			if (_iconSkin != value)
			{
				_iconSkin = value;
				callLater(changeClips);
				callLater(changeLabelSize);
			}
		}
		
		public function get space():Number 
		{
			return _space;
		}
		
		public function set space(value:Number):void 
		{
			if (_space != value)
			{
				_space = value;
				callLater(changeLabelSize);
			}
		}
		
		public function get iconAlign():String 
		{
			return _iconAlign;
		}
		
		public function set iconAlign(value:String):void 
		{
			if (_iconAlign != value)
			{
				_iconAlign = value;
				callLater(changeLabelSize);
			}
		}
		
		override protected function changeLabelSize():void
		{
			exeCallLater(changeClips);
			_icon.clips=App.asset.getClips(_iconSkin, 1, 1);
			_btnLabel.width = _btnLabel.textField.textWidth+5;
			_btnLabel.height = ObjectUtils.getTextField(_btnLabel.format).height;
			switch(_iconAlign)
			{
				case CENTER:
					_icon.x = (width - (_icon.width + _btnLabel.width + _space)) * 0.5;
					_icon.y = (height - _icon.height) * 0.5;
					_btnLabel.y = (height - _btnLabel.height) * 0.5 + _labelMargin[1] - _labelMargin[3];
					_btnLabel.x = _icon.x + _icon.width + space;
					break;
			}
		}
	}

}